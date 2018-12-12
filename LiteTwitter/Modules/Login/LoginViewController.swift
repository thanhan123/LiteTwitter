//
//  LoginViewController.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController<LoginView>, LoginViewActionDelegate {

    let loginAction: LoginAction
    let signUpAction: SignUpAction
    let showLoaderAction: ShowLoaderAction
    let showAlertAction: ShowAlertAction
    let timeLineCreator: TimeLineCreator
    let router: Router
    
    lazy var actionHandler: (Result<Bool>) -> () = { [weak self] (result) in
        guard let self = self else {
            return
        }
        
        self.showLoaderAction.hide(in: self.currentView)
        switch result {
        case let .failed(error):
            self.showAlertAction.show(
                title: "Error",
                message: "\(error)",
                cancel: nil,
                buttons: ["Ok"],
                action: nil,
                sender: self)
            
        case .success:
            let vc = self.timeLineCreator.createTimeLineScreen(with: self.router.window)
            let navVC = UINavigationController(rootViewController: vc)
            self.router.changeRootView(navVC)
        }
    }
    
    init(loginAction: LoginAction,
         signUpAction: SignUpAction,
         timeLineCreator: TimeLineCreator,
         router: Router,
         showLoaderAction: ShowLoaderAction,
         showAlertAction: ShowAlertAction) {
        self.loginAction = loginAction
        self.signUpAction = signUpAction
        self.timeLineCreator = timeLineCreator
        self.router = router
        self.showLoaderAction = showLoaderAction
        self.showAlertAction = showAlertAction
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Func - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        currentView.actionDelegate = self
    }
    
    // MARK: Func - LoginViewActionDelegate
    func loginButtonWasTapped() {
        guard let username = currentView.userNameTextField.text,
            let password = currentView.passwordTextField.text else {
            return
        }
        
        showLoaderAction.show(in: currentView)
        loginAction.login(with: username, password: password, handler: actionHandler)
    }
    
    func signUpButtonWasTapped() {
        guard let username = currentView.userNameTextField.text,
            let password = currentView.passwordTextField.text else {
                return
        }
        
        signUpAction.signUp(with: username, password: password, handler: actionHandler)
    }
}
