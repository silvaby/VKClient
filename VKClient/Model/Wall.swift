//
//  Wall.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

import Foundation

struct ResponseWall: Codable {
    static func empty() -> Self { ResponseWall(response: .empty()) }

    let response: Wall
}

// MARK: - Wall

struct Wall: Codable {
    static func empty() -> Self { Wall(count: 0, items: [], profiles: []) }

    let count: Int
    let items: [Item]
    let profiles: [Profile]
}

// MARK: - Item

struct Item: Codable {
    let id, fromID, ownerID, date: Int
    let postType, text: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case ownerID = "owner_id"
        case date
        case postType = "post_type"
        case text
    }
}

// MARK: - Profile

struct Profile: Codable {
    let firstName: String?
    let id: Int
    let lastName: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
    }
}
