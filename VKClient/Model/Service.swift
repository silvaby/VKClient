//
//  Service.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

import Alamofire
import Foundation

class Service {
    // MARK: - Properties

    /// Array of `Users`
    var users: Users = Users(response: [Response]())
    /// New sorted array with items and profiles
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
}
