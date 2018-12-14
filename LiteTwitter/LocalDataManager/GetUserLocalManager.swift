//
//  GetUserLocalManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol GetUserLocalManager {
    func getCurrentUser(handler: @escaping (Result<User>) -> ())
}

class KeyChainGetUserLocalManager: GetUserLocalManager {
    func getCurrentUser(handler: @escaping (Result<User>) -> ()) {
        if let userData = KeychainWrapper.standard.data(forKey: "user"),
            let user = try? JSONDecoder().decode([String: String].self, from: userData),
            let name = user["name"],
            let id = user["id"] {
            handler(.success(UserResponse(
                id: id,
                username: name))
            )
        } else {
            handler(.failed(CustomError.noObject))
        }
    }
}
