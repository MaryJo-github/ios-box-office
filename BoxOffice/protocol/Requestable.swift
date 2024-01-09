//
//  Requestable.swift
//  BoxOffice
//
//  Created by MARY on 2024/01/09.
//

import Foundation

protocol Requestable {
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
