//
//  AppDelegate.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let getCurrentUser: GetCurrentUserLocalManager = UserDefaultGetCurrentUserLocalManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
        }
        
        getCurrentUser.getCurrentUser { (result) in
            switch result {
            case .success:
                break
                
            case .failed:
                self.showLoginScreen()
            }
        }
        
        return true
    }
    
    func showLoginScreen() {
        let loginAction = LoginActionProvider()
        let signUpAction = SignUpActionProvider(
            signUpManager: ApolloSignUpManager(),
            userLocalManager: UserDefaultSaveCurrentUserLocalManager()
        )
        let loginVC = LoginViewController(
            loginAction: loginAction,
            signUpAction: signUpAction
        )
        let navVC = UINavigationController(rootViewController: loginVC)
        changeRootView(vc: navVC)
    }
    
    func changeRootView(vc: UIViewController) {
        window?.rootViewController = vc
    }


}

