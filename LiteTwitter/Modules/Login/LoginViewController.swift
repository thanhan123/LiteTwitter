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
        loginActionDelegate.login(with: "", password: "") { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case let .failed(error):
                print(error)
                
            case .success:
                let vc = self.timeLineCreator.createTimeLineScreen(with: self.router.window)
                self.router.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func signUpButtonWasTapped() {
        signUpActionDelegate.signUp(with: "", password: "") { [weak self] (result) in
            guard let self = self else {
                return
            }
            
            switch result {
            case let .failed(error):
                print(error)
                
            case .success:
                let vc = self.timeLineCreator.createTimeLineScreen(with: self.router.window)
                self.router.present(vc, animated: true, completion: nil)
            }
        }
    }
}

protocol TimeLineCreator {
    func createTimeLineScreen(with window: UIWindow?) -> TimeLineViewController
}

class TimeLineCreatorProvider: TimeLineCreator {
    func createTimeLineScreen(with window: UIWindow?) -> TimeLineViewController {
        let vc = TimeLineViewController()
        
        return vc
    }
}

protocol Router {
    var currentViewController: UIViewController? { get set }
    var window: UIWindow { get set }
    
    func present(_ vc: UIViewController, animated: Bool, completion: (() -> ())?)
    func push(_ vc: UIViewController, animated: Bool)
    func changeRootView(_ vc: UIViewController)
}

class RouterProvider: Router {
    weak var currentViewController: UIViewController?
    var window: UIWindow
    
    init(currentViewController: UIViewController,
         window: UIWindow) {
        self.currentViewController = currentViewController
        self.window = window
    }
    
    func present(_ vc: UIViewController, animated: Bool, completion: (() -> ())?) {
        currentViewController?.present(vc, animated: animated, completion: completion)
    }
    
    func push(_ vc: UIViewController, animated: Bool) {
        currentViewController?.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func changeRootView(_ vc: UIViewController) {
        window.rootViewController = vc
    }
}
