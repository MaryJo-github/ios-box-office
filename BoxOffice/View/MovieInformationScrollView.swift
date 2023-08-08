//
//  MovieInformationScrollView.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/08.
//

import UIKit

class MovieInformationScrollView: UIScrollView {
    let imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let directorTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let productionYearTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제작년도"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let openDateTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개봉일"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let showTimeTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "상영시간"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let watchGradeNameTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "관람등급"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let nationTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제작국가"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let genreTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "장르"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let actorTitleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배우"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "감독이름"
        return label
    }()
    
    private let productionYearLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2023"
        return label
    }()
    
    private let openDateLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2023-01-01"
        return label
    }()
    
    private let showTimeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "108"
        return label
    }()
    
    private let watchGradeNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "15세이상관람가"
        return label
    }()
    
    private let nationLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "한국"
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "범죄"
        return label
    }()
    
    private let actorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배우이름"
        label.numberOfLines = 0
        return label
    }()
    
    private let directorLabelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let productionYearLabelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let openDateLabelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let showTimeLabelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let watchGradeNameLabelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let nationLabelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let genreLabelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let actorLabelStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView: UIStackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setUpAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        directorLabelStackView.addArrangedSubview(directorTitleLabel)
        directorLabelStackView.addArrangedSubview(directorLabel)
        
        productionYearLabelStackView.addArrangedSubview(productionYearTitleLabel)
        productionYearLabelStackView.addArrangedSubview(productionYearLabel)
        
        openDateLabelStackView.addArrangedSubview(openDateTitleLabel)
        openDateLabelStackView.addArrangedSubview(openDateLabel)
        
        showTimeLabelStackView.addArrangedSubview(showTimeTitleLabel)
        showTimeLabelStackView.addArrangedSubview(showTimeLabel)
        
        watchGradeNameLabelStackView.addArrangedSubview(watchGradeNameTitleLabel)
        watchGradeNameLabelStackView.addArrangedSubview(watchGradeNameLabel)
        
        nationLabelStackView.addArrangedSubview(nationTitleLabel)
        nationLabelStackView.addArrangedSubview(nationLabel)
        
        genreLabelStackView.addArrangedSubview(genreTitleLabel)
        genreLabelStackView.addArrangedSubview(genreLabel)
        
        actorLabelStackView.addArrangedSubview(actorTitleLabel)
        actorLabelStackView.addArrangedSubview(actorLabel)
        
        contentStackView.addArrangedSubview(directorLabelStackView)
        contentStackView.addArrangedSubview(productionYearLabelStackView)
        contentStackView.addArrangedSubview(openDateLabelStackView)
        contentStackView.addArrangedSubview(showTimeLabelStackView)
        contentStackView.addArrangedSubview(watchGradeNameLabelStackView)
        contentStackView.addArrangedSubview(nationLabelStackView)
        contentStackView.addArrangedSubview(genreLabelStackView)
        contentStackView.addArrangedSubview(actorLabelStackView)
        
        addSubview(contentStackView)
        addSubview(imageView)
    }
    
    private func setUpAutolayout() {
        NSLayoutConstraint.activate([
            directorTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            productionYearTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            openDateTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            showTimeTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            watchGradeNameTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            nationTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            genreTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            actorTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
