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
    
    func testFailure() {
        testFailureCase(
            description: "requestFailure",
            requester: FailureRequester(),
            expectError: NetworkError.requestFail
        )
    }
    
    func testFailureWithResponseError() {
        testFailureCase(
            description: "responseFailure",
            requester: ResponseFailureRequester(),
            expectError: NetworkError.responseFail
        )
    }
    
    func testFailureWithStatusCodeError() {
        testFailureCase(
            description: "statusCodeFailure",
            requester: StatusCodeFailureRequester(),
            expectError: NetworkError.statusCodeNotSuccess(300)
        )
    }
    
    func testFailureWithDataError() {
        testFailureCase(
            description: "dataFailure",
            requester: DataFailureRequester(),
            expectError: NetworkError.dataIsNil
        )
    }
    
    private func testFailureCase(description: String, requester: Requestable, expectError: NetworkError) {
        let expectation = XCTestExpectation(description: description)
        
        networkManager = NetworkManager(requester: requester)
        networkManager.fetchData(urlRequest: URLRequest(url: URL(string: "failure")!)) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, expectError)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
