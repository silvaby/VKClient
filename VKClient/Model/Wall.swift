//
//  Wall.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

//   let wall = try? newJSONDecoder().decode(Wall.self, from: jsonData)

import Foundation

// MARK: - Wall

struct ResponseWall: Codable {
    let response: Wall
}

// MARK: - Response

struct Wall: Codable {
    let count: Int
    let items: [Item]
    let profiles: [Profile]
}

// MARK: - Item

struct Item: Codable {
    let id, fromID, ownerID, date: Int
    let postType, text: String
    let canEdit: Int?
    let canDelete: Int
    let friendsOnly, canPin: Int?
    let canArchive, isArchived: Bool
    let postSource: PostSource
    let comments: Comments
    let likes: Likes
    let reposts: Reposts
    let isFavorite: Bool
    let attachments: [Attachment]?

    enum CodingKeys: String, CodingKey {
        case id
        case fromID = "from_id"
        case ownerID = "owner_id"
        case date
        case postType = "post_type"
        case text
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case friendsOnly = "friends_only"
        case canPin = "can_pin"
        case canArchive = "can_archive"
        case isArchived = "is_archived"
        case postSource = "post_source"
        case comments, likes, reposts
        case isFavorite = "is_favorite"
        case attachments
    }
}

// MARK: - Attachment

struct Attachment: Codable {
    let type: String
    let graffiti: Graffiti
}

// MARK: - Graffiti

struct Graffiti: Codable {
    let id, ownerID: Int
    let photo200, photo586: String

    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case photo200 = "photo_200"
        case photo586 = "photo_586"
    }
}

// MARK: - Comments

struct Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool
    let canClose: Int?

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
        case canClose = "can_close"
    }
}

// MARK: - Likes

struct Likes: Codable {
    let count, userLikes, canLike, canPublish: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - PostSource

struct PostSource: Codable {
    let type: String
}

// MARK: - Reposts

struct Reposts: Codable {
    let count, wallCount, mailCount, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case wallCount = "wall_count"
        case mailCount = "mail_count"
        case userReposted = "user_reposted"
    }
}

// MARK: - Profile

struct Profile: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let canAccessClosed, isClosed: Bool
    let sex: Int
    let screenName: String
    let photo50, photo100: String
    let onlineInfo: OnlineInfo
    let online: Int

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case sex
        case screenName = "screen_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case onlineInfo = "online_info"
        case online
    }
}

// MARK: - OnlineInfo

struct OnlineInfo: Codable {
    let visible: Bool
    let lastSeen: Int
    let isOnline, isMobile: Bool

    enum CodingKeys: String, CodingKey {
        case visible
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case isMobile = "is_mobile"
    }
}
