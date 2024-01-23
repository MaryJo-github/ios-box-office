//
//  Document+.swift
//  BoxOfficeTests
//
//  Created by MARY on 2024/01/22.
//

@testable import BoxOffice

extension Document: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(imageURL, forKey: .imageURL)

        enum CodingKeys: String, CodingKey {
            case imageURL = "image_url"
        }
    }
}
