//
//  ImageSearch+.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/22.
//

@testable import BoxOffice

extension ImageSearch: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(documents, forKey: .documents)

        enum CodingKeys: String, CodingKey {
            case documents
        }
    }
}

extension ImageSearch: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.documents[0].imageURL == rhs.documents[0].imageURL
    }
}
