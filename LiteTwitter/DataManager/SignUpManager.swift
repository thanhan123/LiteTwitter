//
//  SignUpManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation
import Apollo

protocol SignUpManager: BaseURL {
    func signUp(with username: String, password: String, onCompleted: ((Result<User>)->())?)
}

class ApolloSignUpManager: SignUpManager {
    var baseURL: URL
    
    init(baseURL: URL = graphCoolURL) {
        self.baseURL = baseURL
    }
    
    func signUp(with username: String, password: String, onCompleted: ((Result<User>) -> ())?) {
        let apollo = ApolloClient(url: baseURL)
        apollo.perform(
            mutation: RegisterUserMutation(username: username, password: password),
            queue: DispatchQueue.main) { (result, error) in
                if let user = result?.data?.createUser?.fragments.userDetails {
                    onCompleted?(.success(user))
                } else if let error = error {
                    onCompleted?(.failed(error))
                } else if let error = result?.errors?.first {
                    onCompleted?(.failed(error))
                } else {
                    onCompleted?(.failed(CustomError.noResponse))
                }
        }
    }
}
