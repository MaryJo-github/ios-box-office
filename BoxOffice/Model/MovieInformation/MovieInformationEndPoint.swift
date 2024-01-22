//
//  MovieInformationEndPoint.swift
//  BoxOffice
//
//  Created by MARY on 2024/01/10.
//

import Foundation

struct MovieInformationEndPoint {
    init(serviceType: MovieInformationServiceType) {
        self.serviceType = serviceType
    }
    
    var urlRequest: URLRequest? {
        var components: URLComponents = URLComponents()
        let apiQuery: URLQueryItem = URLQueryItem(name: APIKey.key, value: APIKey.value)
        
        components.scheme = scheme
        components.host = host
        components.path = serviceType.path
        components.queryItems = serviceType.queryItems
        components.queryItems?.append(apiQuery)
        
        guard let url = components.url else { return nil }
        
        return URLRequest(url: url)
    }
    
    private let scheme: String = "http"
    private let host: String = "www.kobis.or.kr"
    private let serviceType: MovieInformationServiceType
    
    enum MovieInformationServiceType {
        case daily(date: String)
        case detail(queryKey: String, queryValue: String)
        
        var path: String {
            switch self {
            case .daily:
                return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
            case .detail:
                return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
            }
        }
        
        var queryItems: [URLQueryItem] {
            switch self {
            case .daily(let date):
                return [URLQueryItem(name: "targetDt", value: date)]
            case let .detail(key, value):
                return [URLQueryItem(name: key, value: value)]
            }
        }
        
    }

    private enum APIKey {
        static let key: String = "key"
        static let value: String = "c824c74a1ff9ed62089a9a0bcc0d3211"
    }
}
