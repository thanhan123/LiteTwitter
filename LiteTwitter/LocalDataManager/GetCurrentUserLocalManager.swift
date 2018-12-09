//
//  GetCurrentUserLocalManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol GetCurrentUserLocalManager {
    func getCurrentUser(handler: @escaping (Result<User>) -> ())
}

class UserDefaultGetCurrentUserLocalManager: GetCurrentUserLocalManager {
    func getCurrentUser(handler: @escaping (Result<User>) -> ()) {
        if let user = UserDefaults.standard.object(forKey: "user") as? User {
            handler(.success(user))
        } else {
            handler(.failed(CustomError.noObject))
        }
    }
}
