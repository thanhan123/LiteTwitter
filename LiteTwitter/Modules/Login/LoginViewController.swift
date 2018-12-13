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
    let validationFieldAction: ValidationFieldAction
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
         validationFieldAction: ValidationFieldAction) {
        self.loginAction = loginAction
        self.signUpAction = signUpAction
        self.timeLineCreator = timeLineCreator
        self.router = router
        self.showLoaderAction = showLoaderAction
        self.showAlertAction = showAlertAction
        self.validationFieldAction = validationFieldAction
        
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
    
    func validateInputFields() -> (isValid: Bool, message: String?) {
        if validationFieldAction.validate(string: currentView.username, type: .require) != .passed {
            return (false, "username is required")
        }
        
        if validationFieldAction.validate(string: currentView.password, type: .require) != .passed {
            return (false, "username is required")
        }
        
        if state == .signUp &&
            (validationFieldAction.validate(string: currentView.confirmPassword, type: .require) != .passed ||
                currentView.password != currentView.confirmPassword) {
            return (false, "Confirm password is required and must be same with password")
        }
        
        return (true, nil)
    }
    
    // MARK: Func - LoginViewActionDelegate
    func actionButtonWasTapped() {
        let validateField = validateInputFields()
        guard validateField.isValid else {
            showAlertAction.show(
                title: "Error",
                message: validateField.message,
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
