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
    let validateInputsAction: ValidateInputsAction
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
                sender: self
            )
            
        case .success:
            let vc = self.timeLineCreator.createTimeLineScreen(with: self.router.window)
            let navVC = UINavigationController(rootViewController: vc)
            self.router.changeRootView(navVC)
        }
    }
    
    enum State {
        case login
        case signUp
    }
    
    var state = State.login
    
    init(loginAction: LoginAction,
         signUpAction: SignUpAction,
         timeLineCreator: TimeLineCreator,
         router: Router,
         showLoaderAction: ShowLoaderAction,
         showAlertAction: ShowAlertAction,
         validateInputsAction: ValidateInputsAction) {
        self.loginAction = loginAction
        self.signUpAction = signUpAction
        self.timeLineCreator = timeLineCreator
        self.router = router
        self.showLoaderAction = showLoaderAction
        self.showAlertAction = showAlertAction
        self.validateInputsAction = validateInputsAction
        
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
    
    // MARK: Func
    func stateDidChange() {
        switch state {
        case .login:
            currentView.updateUIForLoginAction()
            
        case .signUp:
            currentView.updateUIForSignUpAction()
        }
    }
    
    // MARK: Func - LoginViewActionDelegate
    func actionButtonWasTapped() {
        var validateField: (isValid: Bool, message: String?)?
        switch state {
        case .login:
            validateField = validateInputsAction.validate(type: .login(
                username: currentView.username,
                password: currentView.password)
            )
        case .signUp:
            validateField = validateInputsAction.validate(type: .signUp(
                username: currentView.username,
                password: currentView.password,
                confirmPassword: currentView.confirmPassword)
            )
        }
        guard validateField?.isValid != false else {
            showAlertAction.show(
                title: "Error",
                message: validateField?.message,
                cancel: nil,
                buttons: ["Ok"],
                action: nil,
                sender: self
            )
            return
        }
        
        guard let username = currentView.username,
            let password = currentView.password else {
                return
        }
        
        showLoaderAction.show(in: currentView)
        switch state {
        case .login:
            loginAction.login(with: username, password: password, handler: actionHandler)
            
        case .signUp:
            signUpAction.signUp(with: username, password: password, handler: actionHandler)
        }
    }
    
    func handleSegmentWasTapped(selectedIndex: Int) {
        state = selectedIndex == 0 ? .login : .signUp
        stateDidChange()
    }
}
