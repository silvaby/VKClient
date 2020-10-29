//
//  Session.swift
//  VKClient
//
//  Created by Dzmitry on 10/29/20.
//

class Session {
    static let instance = Session()

    private init() {}

    var token: String = ""
    var userId: String = ""
}
