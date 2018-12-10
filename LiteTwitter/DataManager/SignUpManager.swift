//
//  SignUpManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation
import Apollo

protocol SignUpManager {
    func signUp(with username: String, password: String, onCompleted: ((Result<User>)->())?)
}

class ApolloSignUpManager: SignUpManager {
    
    let apollo = ApolloClient(url: URL(string: graphCoolURL)!)
    
    func signUp(with username: String, password: String, onCompleted: ((Result<User>) -> ())?) {
        apollo.perform(
            mutation: RegisterUserMutation(username: username, password: password),
            queue: DispatchQueue.main) { (result, error) in
                if let user = result?.data?.createUser {
                    onCompleted?(.success(UserResponse(id: user.id, name: user.username)))
                } else if let error = error {
                    onCompleted?(.failed(error))
                } else {
                    onCompleted?(.failed(CustomError.noResponse))
                }
        }
    }
}
