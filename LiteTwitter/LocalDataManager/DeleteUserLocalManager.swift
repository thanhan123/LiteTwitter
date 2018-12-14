//
//  DeleteUserLocalManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

protocol DeleteUserLocalManager {
    func deleteUser(handler: @escaping ((Result<Bool>) -> ()))
}

class KeyChainDeleteUserLocalManager: DeleteUserLocalManager {
    func deleteUser(handler: @escaping ((Result<Bool>) -> ())) {
        KeychainWrapper.standard.removeObject(forKey: "user")
        handler(.success(true))
    }
}
