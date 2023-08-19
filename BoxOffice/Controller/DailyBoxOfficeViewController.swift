//
//  DailyBoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  last modified by Idinaloq, MARY

import UIKit

struct BoxOfficeEntity: Hashable {
    let dailyBoxOffice: DailyBoxOffice
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: BoxOfficeEntity, rhs: BoxOfficeEntity) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

enum Section: CaseIterable {
    case main
}

final class DailyBoxOfficeViewController: UIViewController {
    private var kobisOpenAPI: KobisOpenAPI = KobisOpenAPI()
    private var networkService: NetworkService = NetworkService()
    private var dateManager: DateManager = DateManager()
    private var boxOfficeData: BoxOffice?
    private let loadingView: LoadingView = LoadingView()
    var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeEntity>!
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeEntity>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeEntity) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier, for: indexPath) as? DailyBoxOfficeCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(data: identifier)
            
            return cell
        }
    }
    
    func performQuery() {
        guard let boxOffice = boxOfficeData else { return }
        
        let data = boxOffice.boxOfficeResult.dailyBoxOfficeList.map {
            BoxOfficeEntity(
                dailyBoxOffice: DailyBoxOffice(
                    rowNumber: $0.rowNumber,
                    rank: $0.rank,
                    rankChangeValue: $0.rankChangeValue,
                    rankOldAndNew: $0.rankOldAndNew,
                    movieCode: $0.movieCode,
                    movieName: $0.movieName,
                    openDate: $0.openDate,
                    salesAmount: $0.salesAmount,
                    salesShare: $0.salesShare,
                    salesChangeValue: $0.salesChangeValue,
                    salesChangeRatio: $0.salesChangeRatio,
                    salesAccumulate: $0.salesAccumulate,
                    audienceCount: $0.audienceCount,
                    audienceChangeValue: $0.audienceChangeValue,
                    audienceChangeRatio: $0.audienceChangeRatio,
                    audienceAccumulate: $0.audienceAccumulate,
                    screenCount: $0.screenCount,
                    showCount: $0.showCount
                )
            )
        }
    
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeEntity>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        return refreshControl
    }()
    
    private let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.minimumLineSpacing = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        setupCollectionView()
        configureView()
        setUpAutoLayout()
        configureDataSource()
        receiveData()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = try? dateManager.getYesterdayDate(format: "yyyy-MM-dd")
    }
    
    private func setupCollectionView() {
//        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DailyBoxOfficeCollectionViewCell.self,
                                forCellWithReuseIdentifier: DailyBoxOfficeCollectionViewCell.identifier)
        collectionView.refreshControl = refreshControl
    }
    
    private func configureView() {
        view.addSubview(loadingView)
        view.addSubview(collectionView)
        view.backgroundColor = .systemBackground
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func receiveData() {
        guard let urlRequest = receiveURLRequest() else { return }
        
        networkService.fetchData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                self.decodeData(data)
                self.reloadCollectionView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func receiveURLRequest() -> URLRequest? {
        do {
            let yesterdayDate = try dateManager.getYesterdayDate(format: "yyyyMMdd")
            let urlRequest = try kobisOpenAPI.receiveURLRequest(serviceType: .dailyBoxOffice, queryItems: ["targetDt": yesterdayDate])
            
            return urlRequest
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    private func decodeData(_ data: Data) {
        do {
            let decodedData = try JSONDecoder().decode(BoxOffice.self, from: data)
            boxOfficeData = decodedData
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.hide()
//            self?.collectionView.reloadData()
            self?.performQuery()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc private func refreshData() {
        receiveData()
    }
}

extension DailyBoxOfficeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        var height: CGFloat = collectionView.frame.height * 0.1
        
        guard let data = boxOfficeData,
              let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return CGSize(width: width, height: height)
        }
        
        let cell = DailyBoxOfficeCollectionViewCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
        
        cell.titleLabel.text = data.movieName
        cell.layoutIfNeeded()
        
        let titleLabelSize = cell.titleLabel.intrinsicContentSize
        
        height += titleLabelSize.height
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = boxOfficeData,
              let data = data.boxOfficeResult.dailyBoxOfficeList[index: indexPath.item] else {
            return
        }
        
        let movieInformationViewController: MovieInformationViewController = MovieInformationViewController(data: data)
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        navigationController?.pushViewController(movieInformationViewController, animated: true)
    }
}
