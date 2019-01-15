//
//  ProfileViewController.swift
//  Profile
//
//  Created by Dinh Thanh An on 15/01/2019.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//

import UIKit

public class ProfileViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Profile view"
        view.backgroundColor = UIColor.red
    }
}
