//
//  MovieInformationManagerTests.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/22.
//

import XCTest
@testable import BoxOffice

final class MovieInformationManagerTests: XCTestCase {
    private var movieInformationManager: MovieInformationManager!
    private let dailyData = NSDataAsset(name: "box_office_sample")!.data
    private let detailData = NSDataAsset(name: "movie_information_sample")!.data
    
    func testReceiveDailyData() {
        let expectation = XCTestExpectation(description: "receiveDailyData")
        let expectationMovieName = "경관의 피"
        let networkManager = MockSuccessNetworkManager(data: dailyData)
        movieInformationManager = MovieInformationManager(networkManager: networkManager)
        
        movieInformationManager.receiveDailyData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
            switch result {
            case .success(let data):
                networkManager.verify()
                XCTAssertEqual(expectationMovieName, data.boxOfficeResult.dailyBoxOfficeList[0].movieName)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
    }
    
    func testReceiveDailyDataNetworkFailure() {
        let expectation = XCTestExpectation(description: "receiveDailyDataNetworkFailure")
        let networkManager = MockFailureNetworkManager(error: .requestFail)
        movieInformationManager = MovieInformationManager(networkManager: networkManager)
        
        movieInformationManager.receiveDailyData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
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
    
    func testReceiveDailyDataDecodingFailure() {
        let expectation = XCTestExpectation(description: "receiveDailyDataDecodingFailure")
        let failureData = "{}".data(using: .utf8)!
        let networkManager = MockSuccessNetworkManager(data: failureData)
        movieInformationManager = MovieInformationManager(networkManager: networkManager)
        
        movieInformationManager.receiveDailyData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
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
    
    func testReceiveDetailData() {
        let expectation = XCTestExpectation(description: "receiveDetailData")
        let expectationMovieName = "광해, 왕이 된 남자"
        let networkManager = MockSuccessNetworkManager(data: detailData)
        movieInformationManager = MovieInformationManager(networkManager: networkManager)

        movieInformationManager.receiveDetailData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
            switch result {
            case .success(let data):
                networkManager.verify()
                XCTAssertEqual(expectationMovieName, data.movieInformationResult.movieInformation.movieName)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
    }

    func testReceiveDetailDataNetworkFailure() {
        let expectation = XCTestExpectation(description: "receiveDetailDataNetworkFailure")
        let networkManager = MockFailureNetworkManager(error: .requestFail)
        movieInformationManager = MovieInformationManager(networkManager: networkManager)

        movieInformationManager.receiveDetailData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
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

    func testReceiveDetailDataDecodingFailure() {
        let expectation = XCTestExpectation(description: "receiveDetailDataDecodingFailure")
        let failureData = "{}".data(using: .utf8)!
        let networkManager = MockSuccessNetworkManager(data: failureData)
        movieInformationManager = MovieInformationManager(networkManager: networkManager)

        movieInformationManager.receiveDetailData(urlRequest: URLRequest(url: URL(string: "sample")!)) { result in
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
