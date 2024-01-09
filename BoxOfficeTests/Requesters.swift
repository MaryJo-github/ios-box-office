//
//  Requesters.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/09.
//

import Foundation
@testable import BoxOffice

final class SuccessRequester: Requestable {
    private let data: Data
    
    init(data: Data = Data()) {
        self.data = data
    }
    
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, HTTPURLResponse(url: urlRequest.url!, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        return URLSession.shared.dataTask(with: urlRequest)
    }
}
