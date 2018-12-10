//
//  GetUserLocalManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol GetUserLocalManager {
    func getCurrentUser(handler: @escaping (Result<User>) -> ())
}

class UserDefaultGetUserLocalManager: GetUserLocalManager {
    func getCurrentUser(handler: @escaping (Result<User>) -> ()) {
        if let user = UserDefaults.standard.object(forKey: "user") as? [String: Any],
            let name = user["name"] as? String,
            let id = user["id"] as? String {
            handler(.success(UserResponse(
                id: id,
                name: name))
            )
        } else {
            handler(.failed(CustomError.noObject))
        }
    }
}
