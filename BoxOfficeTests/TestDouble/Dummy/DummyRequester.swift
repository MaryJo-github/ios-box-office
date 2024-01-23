//
//  DummyRequester.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/22.
//

@testable import BoxOffice
import Foundation

final class DummyRequester: Requestable {
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: URL(string: "")!)
    }
}
