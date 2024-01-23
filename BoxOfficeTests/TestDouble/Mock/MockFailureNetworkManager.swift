//
//  MockFailureNetworkManager.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/22.
//

@testable import BoxOffice
import XCTest
import Foundation

final class MockFailureNetworkManager: NetworkManageable {
    var requester: Requestable
    private var error: NetworkError
    private var callCount: Int = 0
    
    init(error: NetworkError = .dataIsNil) {
        requester = DummyRequester()
        self.error = error
    }
    
    func fetchData(urlRequest: URLRequest, completion: @escaping NetworkResult) {
        callCount += 1
        
        completion(.failure(error))
    }
    
    func verify(callCount: Int = 1) {
        XCTAssertEqual(self.callCount, callCount)
    }
}
