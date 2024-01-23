//
//  DecodingError+.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/23.
//

extension DecodingError: Equatable {
    public static func == (lhs: DecodingError, rhs: DecodingError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
