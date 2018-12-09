//
//  BaseController.swift
//  ANPhotoCollection
//
//  Created by Dinh Thanh An on 11/11/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

protocol Controller {
    associatedtype ViewType
    var currentView: ViewType { get }
}

class BaseViewController<ViewType: UIView>: UIViewController, Controller {
    
    override func loadView() {
        self.view = ViewType()
    }
    
    var currentView: ViewType {
        /*
         Because of how we implemented loadView(), this cast should never fail.
         However, linters and such tools may complain if we force cast and we want
         to be good developers, so we perform Optional binding just to be safe.
         */
        if let view = self.view as? ViewType {
            return view
        } else {
            let view = ViewType()
            self.view = view
            return view
        }
    }
}
