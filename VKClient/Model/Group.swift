//
//  Groups.swift
//  VKClient
//
//  Created by Dzmitry on 11/2/20.
//

import Foundation

// MARK: - Groups

struct Group {
    let response: GroupResponse
}

// MARK: - GroupsResponse

struct GroupResponse {
    let count: Int
    let items: [GroupItem]
}

// MARK: - GroupsItem

struct GroupItem {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String
    let adminLevel: Int?
}
