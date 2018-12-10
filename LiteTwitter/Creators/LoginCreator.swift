//
//  LoginCreator.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

protocol LoginCreator {
    func createLoginScreen(with window: UIWindow?) -> LoginViewController
}

class LoginCreatorProvider: LoginCreator {
    func createLoginScreen(with window: UIWindow?) -> LoginViewController {
        let loginAction = LoginActionProvider(
            saveUserLocalManager: UserDefaultSaveUserLocalManager(),
            loginManager: ApolloLoginManager()
        )
        let signUpAction = SignUpActionProvider(
            signUpManager: ApolloSignUpManager(),
            userLocalManager: UserDefaultSaveUserLocalManager()
        )
        let loginVC = LoginViewController(
            loginAction: loginAction,
            signUpAction: signUpAction,
            timeLineCreator: TimeLineCreatorProvider(),
            router: RouterProvider(window: window)
        )
        
        return loginVC
    }
}
