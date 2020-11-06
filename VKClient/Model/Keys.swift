//
//  Keys.swift
//  VKClient
//
//  Created by Dzmitry on 11/7/20.
//

import Foundation

/// Describes the keys for `String` values.
enum Keys {
    /// The key associated with the base url.
    static let baseUrl = "https://api.vk.com/method"
    /// The key associated with the path for get info about users.
    static let pathUsersGet = "/users.get"
    /// The key associated with the path for get info from the wall.
    static let pathWallGet = "/wall.get"
    /// The key associated with the access token key.
    static let accessTokenKey = "access_token"
    /// The key associated with the access token value.
    static let accessTokenValue = UserDefaults.standard.string(forKey: "Token")
    /// The key associated with the user id key.
    static let userIdKey = "user_id"
    /// The key associated with the user id value.
    static let userIdValue = UserDefaults.standard.string(forKey: "UserId")
    /// The key associated with the version key.
    static let versionKey = "v"
    /// The key associated with the version value.
    static let versionValue = "5.124"
    /// The key associated with the fields key.
    static let fieldsKey = "fields"
    /// The key associated with the fields value.
    static let fieldsValue = "photo_max"
    // The key associated with the
    static let countKey = "count"
    // The key associated with the
    static let countValue = "100"
    // The key associated with the
    static let filtersKey = "filters"
    // The key associated with the
    static let filtersValue = "all"
    // The key associated with the
    static let extendedKey = "extended"
    // The key associated with the
    static let extendedValue = "1"
}
