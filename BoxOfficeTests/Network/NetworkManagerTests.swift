//
//  NetworkManagerTests.swift
//  BoxOfficeTests
//
//  Created by MARY on 2023/12/13.
//

import XCTest
@testable import BoxOffice

final class NetworkManagerTests: XCTestCase {
    private var networkManager: NetworkManager!
    
    func testSuccess() {
        let expectation = XCTestExpectation(description: "requestSuccess")
        var resultData: Data?
        
        networkManager = NetworkManager(requester: SuccessRequester())
        networkManager.fetchData(urlRequest: URLRequest(url: URL(string: "success")!)) { result in
            switch result {
            case .success(let data):
                resultData = data
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(resultData)
    }
}
