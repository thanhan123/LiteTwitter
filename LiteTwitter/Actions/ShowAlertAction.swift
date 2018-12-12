//
//  ShowAlertAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

protocol ShowAlertAction {
    func show(title: String?, message: String?, cancel: String?, buttons: [String], action: ((Int) -> ())?, sender: UIViewController)
}

class ShowAlertActionProvider: ShowAlertAction {
    func show(title: String?, message: String?, cancel: String?, buttons: [String], action: ((Int) -> ())?, sender: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, button) in buttons.enumerated() {
            alertController.addAction(UIAlertAction(
                title: button,
                style: .default,
                handler: { _ in
                    action?(index)
            }))
        }
        
        if let cancel = cancel {
            alertController.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { _ in
                action?(buttons.count)
            }))
        }
        
        sender.present(alertController, animated: true)
    }
}
