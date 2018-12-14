//
//  SaveUserLocalManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol SaveUserLocalManager {
    func save(user: User, handler: @escaping (Result<Bool>) -> ())
}

class KeyChainSaveUserLocalManager: SaveUserLocalManager {
    
    func save(user: User, handler: @escaping (Result<Bool>) -> ()) {
        do {
            let data = try JSONSerialization.data(withJSONObject: user.toDictionary())
            KeychainWrapper.standard.set(data, forKey: "user")
            handler(.success(true))
        } catch {
            handler(.failed(error))
        }
    }
}
