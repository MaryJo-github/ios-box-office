//
//  NetworkError+.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/09.
//

@testable import BoxOffice

extension NetworkError: Equatable {
    public static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.requestFail, .requestFail):
            return true
        case (.responseFail, .responseFail):
            return true
        case (.statusCodeNotSuccess(let left), .statusCodeNotSuccess(let right)):
            return left == right
        case (.dataIsNil, .dataIsNil):
            return true
        default:
            return false
        }
    }
}
