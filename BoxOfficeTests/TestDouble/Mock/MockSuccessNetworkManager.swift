//
//  MockSuccessNetworkManager.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/22.
//

@testable import BoxOffice
import XCTest
import Foundation

final class MockSuccessNetworkManager: NetworkManageable {
    var requester: Requestable
    private var data: Data
    private var delay: DispatchTime
    private var callCount: Int = 0
    
    init(data: Data = Data(), delay: DispatchTime = .now()) {
        requester = DummyRequester()
        self.data = data
        self.delay = delay
    }
    
    func fetchData(urlRequest: URLRequest, completion: @escaping NetworkResult) {
        callCount += 1
        
        DispatchQueue.global().asyncAfter(deadline: delay) {
            completion(.success(self.data))
        }
    }
    
    func verify(callCount: Int = 1) {
        XCTAssertEqual(self.callCount, callCount)
    }
}
