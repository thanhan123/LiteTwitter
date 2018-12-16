//
//  LoginManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/9/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation
import Apollo

protocol BaseURL {
    var baseURL: URL { get set }
}

protocol LoginManager: BaseURL {
    func login(with username: String, password: String, onCompleted: ((Result<User>)->())?)
}

class ApolloLoginManager: LoginManager {
    var baseURL: URL
    
    init(baseURL: URL = graphCoolURL) {
        self.baseURL = baseURL
    }
    
    func login(with username: String, password: String, onCompleted: ((Result<User>) -> ())?) {
        let apollo = ApolloClient(url: baseURL)
        apollo.fetch(
            query: GetUserQuery(username: username, password: password),
            cachePolicy: .fetchIgnoringCacheData,
            queue: DispatchQueue.main) { (result, error) in
                if let user = result?.data?.allUsers.first?.fragments.userDetails {
                    onCompleted?(.success(user))
                } else if let error = error {
                    onCompleted?(.failed(error))
                } else if let error = result?.errors?.first {
                    onCompleted?(.failed(error))
                } else {
                    onCompleted?(.failed(CustomError.userNameOrPasswordWrong))
                }
        }
    }
}
