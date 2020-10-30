//
//  Users.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

import Foundation

// MARK: - Users

struct Users: Codable {
    let response: [Response]
}

// MARK: - Response

struct Response: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photoMax: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoMax = "photo_max"
    }
}
