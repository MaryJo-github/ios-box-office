//
//  MovieInformationManager.swift
//  BoxOffice
//
//  Created by MARY on 2024/01/09.
//

import Foundation

final class MovieInformationManager {
    static let shared: MovieInformationManager = MovieInformationManager()
    private let networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable = NetworkManager(requester: DefaultRequester())) {
        self.networkManager = networkManager
    }
    
    func receiveDailyURLRequest(date: Date) -> URLRequest? {
        let dateString = date.convertString(format: "yyyyMMdd")
        return MovieInformationEndPoint(serviceType: .daily(date: dateString)).urlRequest
    }

    func receiveDetailURLRequest(movieCode: String) -> URLRequest? {
        return MovieInformationEndPoint(serviceType: .detail(queryKey: "movieCd", queryValue: movieCode)).urlRequest
    }
    
    func receiveDailyData(urlRequest: URLRequest, completion: @escaping (Result<BoxOffice, Error>) -> Void) {
        networkManager.fetchData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(BoxOffice.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func receiveDetailData(urlRequest: URLRequest, completion: @escaping (Result<DetailInformation, Error>) -> Void) {
        networkManager.fetchData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(DetailInformation.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
