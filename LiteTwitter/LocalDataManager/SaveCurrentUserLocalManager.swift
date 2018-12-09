//
//  SaveCurrentUserLocalManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol SaveCurrentUserLocalManager {
    func save(user: User, handler: @escaping (Result<Bool>) -> ())
}

class UserDefaultSaveCurrentUserLocalManager: SaveCurrentUserLocalManager {
    
    func save(user: User, handler: @escaping (Result<Bool>) -> ()) {
        UserDefaults.standard.set(user, forKey: "user")
        handler(.success(true))
    }
}
