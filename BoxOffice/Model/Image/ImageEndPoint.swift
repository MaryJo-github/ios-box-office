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
        
        guard let url = components.url else { return nil }
        
        var urlRequest: URLRequest = URLRequest(url: url)

        urlRequest.httpMethod = "GET"
        urlRequest.addValue(APIKey.value, forHTTPHeaderField: APIKey.key)
    
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
    
    private enum APIKey {
        static let key: String = "Authorization"
        static let value: String = "KakaoAK 5a5bed59f416826d3b667c6d97eac62a"
    }
}
