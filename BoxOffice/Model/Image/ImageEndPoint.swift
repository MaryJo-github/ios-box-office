//
//  ImageEndPoint.swift
//  BoxOffice
//
//  Created by Idinaloq, MARY on 2023/08/09.
//

import Foundation

struct ImageEndPoint {
    init(serviceType: ImageServiceType) {
        self.serviceType = serviceType
    }
    
    var urlRequest: URLRequest? {
        var components: URLComponents = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = serviceType.path
        components.queryItems = serviceType.queryItems
        
        guard let url = components.url,
              let apiKey = Bundle.main.infoDictionary?["KakaoAPIKey"] as? String else {
            return nil
        }
        
        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        urlRequest.addValue(apiKey, forHTTPHeaderField: "Authorization")
    
        return urlRequest
    }
    
    private let scheme: String = "https"
    private let host: String = "dapi.kakao.com"
    private let serviceType: ImageServiceType
    
    enum ImageServiceType {
        case search(query: String)
        
        var path: String {
            switch self {
            case .search:
                return "/v2/search/image"
            }
        }
        
        var queryItems: [URLQueryItem] {
            switch self {
            case .search(let query):
                return [URLQueryItem(name: "query", value: query), URLQueryItem(name: "size", value: "1")]
            }
        }
    }
}
