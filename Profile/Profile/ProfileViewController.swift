//
//  ProfileViewController.swift
//  Profile
//
//  Created by Dinh Thanh An on 15/01/2019.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let logoutAction: LogoutAction
    
    var logoutBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
        return barButton
    }()
    
    init(logoutAction: @escaping LogoutAction) {
        self.logoutAction = logoutAction
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile view"
        view.backgroundColor = UIColor.red
        
        navigationItem.rightBarButtonItem = logoutBarButton
        logoutBarButton.target = self
        logoutBarButton.action = #selector(logoutButtonWasTapped)
    }
    
    @objc func logoutButtonWasTapped() {
        logoutAction()
    }
}
