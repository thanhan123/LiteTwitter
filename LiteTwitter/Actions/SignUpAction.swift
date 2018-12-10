//
//  SignUpAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol SignUpAction {
    var saveUserLocalManager: SaveUserLocalManager { get set }
    var signUpManager: SignUpManager { get set }
    func signUp(with username: String, password: String, handler: @escaping (Result<Bool>) -> ())
}

class SignUpActionProvider: SignUpAction {
    var signUpManager: SignUpManager
    var saveUserLocalManager: SaveUserLocalManager
    
    init(signUpManager: SignUpManager,
         userLocalManager: SaveUserLocalManager) {
        self.signUpManager = signUpManager
        self.saveUserLocalManager = userLocalManager
    }
    
    func signUp(with username: String, password: String, handler: @escaping (Result<Bool>) -> ()) {
        signUpManager.signUp(with: username, password: password) { [weak self] (result) in
            switch result {
            case let .success(user):
                self?.saveUserLocalManager.save(
                    user: user,
                    handler: handler
                )
                
            case let .failed(error):
                handler(.failed(error))
            }
        }
    }
}
