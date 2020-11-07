//
//  Keys.swift
//  VKClient
//
//  Created by Dzmitry on 11/7/20.
//

import Foundation

/// Describes the keys for `String` values.
enum Keys {
    // MARK: - Common keys.

    /// The key associated with the base url.
    static let baseUrl = "https://api.vk.com/method"
    /// The key associated with the path for get info about users.
    static let pathUsersGet = "/users.get"
    /// The key associated with the path for get info from the wall.
    static let pathWallGet = "/wall.get"
    /// The key associated with the version key.
    static let versionKey = "v"
    /// The key associated with the version value.
    static let versionValue = "5.124"
    /// The key associated with the access token key.
    static let accessTokenKey = "access_token"
    /// The key associated with the user id key.
    static let userIdKey = "user_id"

    // MARK: - `UserDefaults` keys.

    /// The key associated with the access token key.
    static let userDefaultsAccessTokenKey = "Token"
    /// The key associated with the user id key.
    static let userDefaultsUserIdKey = "UserId"
    /// The key associated with the access token value.
    static let accessTokenValue = UserDefaults.standard.string(forKey:
        Keys.userDefaultsAccessTokenKey)
    /// The key associated with the user id value.
    static let userIdValue = UserDefaults.standard.string(forKey:
        Keys.userDefaultsUserIdKey)

    // MARK: - Keys for `getUser`.

    /// The key associated with the fields key.
    static let fieldsKey = "fields"
    /// The key associated with the fields value.
    static let fieldsValue = "photo_max"

    // MARK: - Keys for `getWall`.

    /// The key associated with the count key.
    static let countKey = "count"
    /// The key associated with the count value.
    static let countValue = "100"

    /// The key associated with the filters key.
    static let filtersKey = "filters"
    /// The key associated with the filters value.
    static let filtersValue = "all"

    /// The key associated with the extended key.
    static let extendedKey = "extended"
    /// The key associated with the extended value.
    static let extendedValue = "1"

    // MARK: - Keys for request.

    /// The key associated with the request scheme.
    static let requestScheme = "https"
    /// The key associated with the request host.
    static let requestHost = "oauth.vk.com"
    /// The key associated with the request path.
    static let requestPath = "/authorize"

    /// The key associated with the request clientId key.
    static let requestClientIdKey = "client_id"
    /// The key associated with the request clientId value.
    static let requestClientIdValue = "7643520"

    /// The key associated with the request display key.
    static let requestDisplayKey = "display"
    /// The key associated with the request display value.
    static let requestDisplayValue = "mobile"

    /// The key associated with the request redirect uri key.
    static let requestRedirectUriKey = "redirect_uri"
    /// The key associated with the request redirect uri value.
    static let requestRedirectUriValue = "https://oauth.vk.com/blank.html"

    /// The key associated with the request scope key.
    static let requestScopeKey = "scope"
    /// The key associated with the request scope value.
    static let requestScopeValue = "270342"

    /// The key associated with the request response type key.
    static let requestResponseTypeKey = "response_type"
    /// The key associated with the request response type value.
    static let requestResponseTypeValue = "token"

    // MARK: - Keys for response.

    /// The key associated with the response path.
    static let responsePath = "/blank.html"

    // MARK: - ID keys.

    /// The key associated with the login segue id.
    static let loginSegueID = "LoginSegue"
    /// The key associated with the posts cell id.
    static let postsCellID = "PostsCell"
    /// The key associated with the groups cell id.
    static let groupsCellID = "GroupsCell"
}
