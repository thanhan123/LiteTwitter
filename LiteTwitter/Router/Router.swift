//
//  Router.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

protocol Router {
    var window: UIWindow? { get set }
    
    func present(_ vc: UIViewController, from sourceVC: UIViewController, animated: Bool, completion: (() -> ())?)
    func push(_ vc: UIViewController, from sourceVC: UIViewController, animated: Bool)
    func changeRootView(_ vc: UIViewController)
}

class RouterProvider: Router {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func present(_ vc: UIViewController, from sourceVC: UIViewController, animated: Bool, completion: (() -> ())?) {
        sourceVC.present(vc, animated: animated, completion: completion)
    }
    
    func push(_ vc: UIViewController, from sourceVC: UIViewController, animated: Bool) {
        sourceVC.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func changeRootView(_ vc: UIViewController) {
        window?.rootViewController = vc
    }
}
