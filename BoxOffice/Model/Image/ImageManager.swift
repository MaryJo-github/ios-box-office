//
//  ImageManager.swift
//  BoxOffice
//
//  Created by MARY on 2024/01/18.
//

import Foundation

final class ImageManager {
    static let shared: ImageManager = ImageManager()
    private let networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable = NetworkManager(requester: DefaultRequester())) {
        self.networkManager = networkManager
    }

    func receiveSearchData(urlRequest: URLRequest, completion: @escaping (Result<ImageSearch, Error>) -> Void) {
        networkManager.fetchData(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(ImageSearch.self, from: data)
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
