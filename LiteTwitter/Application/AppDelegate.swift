//
//  AppDelegate.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let getCurrentUser: GetUserLocalManager = UserDefaultGetUserLocalManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.makeKeyAndVisible()
        }
        
        IQKeyboardManager.shared().isEnabled = true
        
        getCurrentUser.getCurrentUser { [weak self] (result) in
            switch result {
            case .success:
                self?.showTimeLineScreen()
                
            case .failed:
                self?.showLoginScreen()
            }
        }
        
        return true
    }
    
    func showLoginScreen() {
        let loginCreator: LoginCreator = LoginCreatorProvider()
        let loginVC = loginCreator.createLoginScreen(with: window)
        let navVC = UINavigationController(rootViewController: loginVC)
        changeRootView(vc: navVC)
    }
    
    func showTimeLineScreen() {
        let timeLine: TimeLineCreator = TimeLineCreatorProvider()
        let timeLineVC = timeLine.createTimeLineScreen(with: window)
        let navVC = UINavigationController(rootViewController: timeLineVC)
        changeRootView(vc: navVC)
    }
    
    func changeRootView(vc: UIViewController) {
        window?.rootViewController = vc
    }
}

