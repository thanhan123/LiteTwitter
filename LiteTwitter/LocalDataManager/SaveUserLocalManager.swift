//
//  SaveUserLocalManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol SaveUserLocalManager {
    func save(user: User, handler: @escaping (Result<Bool>) -> ())
}

class UserDefaultSaveUserLocalManager: SaveUserLocalManager {
    
    func save(user: User, handler: @escaping (Result<Bool>) -> ()) {
        UserDefaults.standard.set(user.toDictionary(), forKey: "user")
        handler(.success(true))
    }
}
