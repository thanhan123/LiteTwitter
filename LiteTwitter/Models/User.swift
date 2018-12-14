//
//  User.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol User {
    var id: String { get }
    var username: String { get }
}

extension User {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": username
        ]
    }
}

struct UserResponse: User {
    let id: String
    let username: String
}

extension UserDetails: User { }
