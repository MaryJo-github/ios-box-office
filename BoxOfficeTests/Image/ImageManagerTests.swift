//
//  ImageManagerTests.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/22.
//

import XCTest
@testable import BoxOffice

final class ImageManagerTests: XCTestCase {
    private var imageManager: ImageManager!
    private let imageData = ImageSearch(documents: [Document(imageURL: "imageURL")])
    private var encoded: Data!
    
    override func setUpWithError() throws {
        encoded = try! JSONEncoder().encode(imageData)
    }
    
    func testReceiveSearchData() {
        let expectation = XCTestExpectation(description: "receiveSearchData")
        let networkManager = MockSuccessNetworkManager(data: encoded)
        imageManager = ImageManager(networkManager: networkManager)
        
        imageManager.receiveSearchData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
            switch result {
            case .success(let data):
                networkManager.verify()
                XCTAssertEqual(self.imageData, data)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
    }
    
    func testReceiveSearchDataNetworkFailure() {
        let expectation = XCTestExpectation(description: "receiveSearchDataNetworkFailure")
        let networkManager = MockFailureNetworkManager(error: .requestFail)
        imageManager = ImageManager(networkManager: networkManager)
        
        imageManager.receiveSearchData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                networkManager.verify()
                XCTAssertEqual(error as! NetworkError, NetworkError.requestFail)
                expectation.fulfill()
            }
        }
    }
    
    func testReceiveSearchDataDecodingFailure() {
        let expectation = XCTestExpectation(description: "receiveSearchDataDecodingFailure")
        let failureData = "{}".data(using: .utf8)!
        let networkManager = MockSuccessNetworkManager(data: failureData)
        imageManager = ImageManager(networkManager: networkManager)
        
        imageManager.receiveSearchData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                networkManager.verify()
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
    }
}
