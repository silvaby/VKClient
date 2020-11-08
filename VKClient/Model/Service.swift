//
//  Service.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

import Alamofire
import Foundation
import WebKit

class Service {
    // MARK: - Properties

    /// A property that stores detailed information about users.
    var users: Users = Users(response: [Response]())
    /// New sorted array with items and profiles.
    var itemsWithNames = [ItemsWithName]()

    // MARK: - users.get

    /// Returns detailed information on users.
    func getUser(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = Keys.baseUrl + Keys.pathUsersGet
        let parameters = [
            Keys.accessTokenKey: Keys.accessTokenValue,
            Keys.userIdKey: Keys.userIdValue,
            Keys.versionKey: Keys.versionValue,
            Keys.fieldsKey: Keys.fieldsValue,
        ]

        AF.request(url, method: .get, parameters: parameters).responseData { result in
            guard let data = result.value else { return }
            completion(.success(data))
        }
    }

    /// Parses data about users.
    func parseUsers(jsonData: Data) {
        do {
            let result = try JSONDecoder().decode(Users.self, from: jsonData)
            users = result
        } catch {
            print("Error")
        }
    }

    // MARK: - wall.get

    /// Returns a list of posts on a user wall or community wall.
    func getWall(completion: @escaping (Result<Data, Error>) -> Void) {
        let url = Keys.baseUrl + Keys.pathWallGet
        let parameters = [
            Keys.accessTokenKey: Keys.accessTokenValue,
            Keys.userIdKey: Keys.userIdValue,
            Keys.versionKey: Keys.versionValue,
            Keys.countKey: Keys.countValue,
            Keys.filtersKey: Keys.filtersValue,
            Keys.extendedKey: Keys.extendedValue,
        ]

        AF.request(url, method: .get, parameters: parameters).responseData { result in
            guard let data = result.value else { return }
            completion(.success(data))
        }
    }

    /// Parses data from wall.
    func parseWall(jsonData: Data) {
        do {
            let result = try JSONDecoder().decode(ResponseWall.self, from: jsonData)
            itemsWithNames = [ItemsWithName]()
            for item in result.response.items {
                for profiles in result.response.profiles {
                    if item.fromID == profiles.id {
                        itemsWithNames.append(ItemsWithName(firstName: profiles.firstName,
                                                            lastName: profiles.lastName,
                                                            id: item.id,
                                                            fromID: item.fromID,
                                                            ownerID: item.ownerID,
                                                            date: item.date,
                                                            text: item.text))
                    }
                }
            }
            itemsWithNames.sort { $0.date > $1.date }
        } catch {
            print("Error")
        }
    }

    // MARK: - Network

    /// Load web content into `WKWebView`.
    class func loadContent(in webView: WKWebView) {
        var urlComponents = URLComponents()
        urlComponents.scheme = Keys.requestScheme
        urlComponents.host = Keys.requestHost
        urlComponents.path = Keys.requestPath
        urlComponents.queryItems = [
            URLQueryItem(name: Keys.requestClientIdKey,
                         value: Keys.requestClientIdValue),
            URLQueryItem(name: Keys.requestDisplayKey,
                         value: Keys.requestDisplayValue),
            URLQueryItem(name: Keys.requestRedirectUriKey,
                         value: Keys.requestRedirectUriValue),
            URLQueryItem(name: Keys.requestScopeKey,
                         value: Keys.requestScopeValue),
            URLQueryItem(name: Keys.requestResponseTypeKey,
                         value: Keys.requestResponseTypeValue),
            URLQueryItem(name: Keys.versionKey, value: Keys.versionValue),
        ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)

        print("Now isSignedIn: ", Authentication.isSignedIn)
    }
}
