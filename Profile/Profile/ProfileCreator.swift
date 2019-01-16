//
//  ProfileCreator.swift
//  Profile
//
//  Created by Dinh Thanh An on 16/01/2019.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//

import UIKit

public protocol ProfileCreator {
    func createTimeLineScreen(with window: UIWindow?,
                              logoutAction: @escaping LogoutAction) -> UIViewController
}

public typealias LogoutAction = () -> ()

public class ProfileCreatorProvider: ProfileCreator {
    
    public init() {}
    
    public func createTimeLineScreen(with window: UIWindow?,
                                     logoutAction: @escaping LogoutAction) -> UIViewController {
        let vc = ProfileViewController(logoutAction: logoutAction)
        
        return vc
    }
}
