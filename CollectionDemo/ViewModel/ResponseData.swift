//
//  ResponseData.swift
//  CollectionDemo
//
//  Created by Kshama Saklecha on 18/02/21.
//

import Foundation

struct ResponseData: Codable {
    public let userId: Int64
    public let id: Int64?
    public let title: String?
    public let body: String?

    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}
