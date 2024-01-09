//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/07/27.
//

import Foundation

final class NetworkManager {
    typealias NetworkResult = (Result<Data, NetworkError>) -> Void
    
    private(set) var requester: Requestable
    
    init(requester: Requestable = DefaultRequester()) {
        self.requester = requester
    }

    func fetchData(urlRequest: URLRequest, completion: @escaping NetworkResult) {
        let task: URLSessionDataTask = requester.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.requestFail))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.responseFail))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.statusCodeNotSuccess(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.dataIsNil))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

final class DefaultRequester: Requestable {
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler)
    }
}
