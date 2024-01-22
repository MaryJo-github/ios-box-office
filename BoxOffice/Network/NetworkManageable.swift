//
//  NetworkManageable.swift
//  BoxOffice
//
//  Created by MARY on 2024/01/09.
//

import Foundation

typealias NetworkResult = (Result<Data, NetworkError>) -> Void

protocol NetworkManageable: AnyObject {
    var requester: Requestable { get }
    
    func fetchData(urlRequest: URLRequest, completion: @escaping NetworkResult)
}
