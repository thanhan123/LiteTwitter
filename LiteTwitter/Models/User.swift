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
    var name: String { get }
}

extension User {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name
        ]
    }
}

struct UserResponse: User {
    let id: String
    let name: String
}
