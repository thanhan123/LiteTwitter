//
//  GetCurrentUserAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol GetCurrentUserAction {
    var getCurrentLocalUser: GetUserLocalManager { get set }
    func getCurrentUser(handler: @escaping ((Result<User>) -> ()))
}

class GetCurrentUserActionProvider: GetCurrentUserAction {
    var getCurrentLocalUser: GetUserLocalManager
    
    init(getCurrentLocalUser: GetUserLocalManager) {
        self.getCurrentLocalUser = getCurrentLocalUser
    }
    
    func getCurrentUser(handler: @escaping ((Result<User>) -> ())) {
        getCurrentLocalUser.getCurrentUser(handler: handler)
    }
}
