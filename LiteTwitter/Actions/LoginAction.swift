//
//  LoginAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol LoginAction {
    var saveUserLocalManager: SaveCurrentUserLocalManager { get set }
    var loginManager: LoginManager { get set }
    func login(with username: String, password: String, handler: @escaping (Result<Bool>) -> ())
}

class LoginActionProvider: LoginAction {
    var saveUserLocalManager: SaveCurrentUserLocalManager
    var loginManager: LoginManager
    
    init(saveUserLocalManager: SaveCurrentUserLocalManager,
         loginManager: LoginManager) {
        self.saveUserLocalManager = saveUserLocalManager
        self.loginManager = loginManager
    }
    
    func login(with username: String, password: String, handler: @escaping (Result<Bool>) -> ()) {
        loginManager.login(
            with: username,
            password: password) { [weak self] (result) in
                switch result {
                case let .success(user):
                    self?.saveUserLocalManager.save(user: user, handler: handler)
                    
                case let .failed(error):
                    handler(.failed(error))
                }
        }
    }
}
