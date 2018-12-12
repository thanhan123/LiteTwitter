//
//  ShowLoaderAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol ShowLoaderAction {
    func show(in view: UIView)
    func hide(in view: UIView)
}

class MBProgressHUDShowLoaderAction: ShowLoaderAction {
    func show(in view: UIView) {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    func hide(in view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
