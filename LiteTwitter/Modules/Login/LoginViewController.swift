//
//  LoginViewController.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController<LoginView>, LoginViewActionDelegate {

    let loginActionDelegate: LoginAction
    let signUpActionDelegate: SignUpAction
    let timeLineCreator: TimeLineCreator
    var router: Router
    
    init(loginAction: LoginAction,
         signUpAction: SignUpAction,
         timeLineCreator: TimeLineCreator,
         router: Router) {
        loginActionDelegate = loginAction
        signUpActionDelegate = signUpAction
        self.timeLineCreator = timeLineCreator
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Func - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        currentView.actionDelegate = self
    }
    
    // MARK: Func - LoginViewActionDelegate
    func confirmButtonWasTapped() {
        guard let username = currentView.userNameTextField.text,
            let password = currentView.passwordTextField.text else {
            return
        }
        
        loginActionDelegate.login(with: username, password: password) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case let .failed(error):
                print(error)
                
            case .success:
                let vc = self.timeLineCreator.createTimeLineScreen(with: self.router.window)
                let navVC = UINavigationController(rootViewController: vc)
                self.router.changeRootView(navVC)
            }
        }
    }
    
    func signUpButtonWasTapped() {
        guard let username = currentView.userNameTextField.text,
            let password = currentView.passwordTextField.text else {
                return
        }
        
        signUpActionDelegate.signUp(with: username, password: password) { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case let .failed(error):
                print(error)
                
            case .success:
                let vc = self.timeLineCreator.createTimeLineScreen(with: self.router.window)
                let navVC = UINavigationController(rootViewController: vc)
                self.router.changeRootView(navVC)
            }
        }
    }
}
