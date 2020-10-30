//
//  Service.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

import Alamofire
import Foundation

class Service {
    private let baseUrl = "https://api.vk.com/method"

    func getUser(completion: @escaping (Result<[Users], Error>) -> Void) {
        let path = "/users.get"
        let url = baseUrl + path
        let parameters = [
            "access_token": UserDefaults.standard.string(forKey: "Token"),
            "user_id": UserDefaults.standard.string(forKey: "UserId"),
            "fields": "photo_max",
            "v": "5.124",
        ]

        AF.request(url, method: .get, parameters: parameters).responseData { result in
            guard let data = result.value else { return }
            do {
                let result = try JSONDecoder().decode(Users.self, from: data)
                completion(.success([result]))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func getWall(completion: @escaping (Result<ResponseWall, Error>) -> Void) {
        let path = "/wall.get"
        let url = baseUrl + path
        let parameters = [
            "access_token": UserDefaults.standard.string(forKey: "Token"),
            "owner_id": UserDefaults.standard.string(forKey: "UserId"),
            "count": "20",
            "filters": "all",
            "extended": "1",
            "v": "5.124",
        ]

        AF.request(url, method: .get, parameters: parameters).responseData { result in
            guard let data = result.value else { return }
            do {
                let result = try JSONDecoder().decode(ResponseWall.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
