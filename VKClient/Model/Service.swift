//
//  Service.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

import Alamofire
import Foundation
import SwiftyJSON

class Service {
    private let baseUrl = "https://api.vk.com/method"

    func getUser(completion: @escaping (Result<[Users], Error>) -> Void) {
        let path = "/users.get"

        let url = baseUrl + path
        let parameters = [
            "access_token": Session.instance.token,
            "user_id": Session.instance.userId,
            "v": "5.124",
            "fields": "photo_max",
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

    // https://vk.com/dev/wall.get?params[owner_id]=2850791&params[count]=1&params[filter]=all&params[extended]=1&params[v]=5.124

//    func getWall(token: String, ownerId: String, version: String, offset: Int, completion: @escaping (Swift.Result<ResponseNews, Error>) -> Void ) {
//        let requestURL = baseUrl + "/wall.get"
//        var params: [String : String]
//        params = ["access_token": token,
//                  "owner_id": ownerId,
//                  "extended": "1",
//                  "filters": "post",
//                  "count": "20",
//                  "offset": String(offset),
//                  "fields": "first_name,last_name,name,photo_100,online",
//                  "v": version]
//
//        AF.request(requestURL,
//                          method: .get,
//                          parameters: params as Parameters)
//            .responseData { (result) in
//                guard let data = result.value else { return }
//                do {
//                    let result = try JSONDecoder().decode(CommonResponseNews.self, from: data)
//                    completion(.success(result.response))
//                } catch {
//                    completion(.failure(error))
//                }
//        }
//    }
}
