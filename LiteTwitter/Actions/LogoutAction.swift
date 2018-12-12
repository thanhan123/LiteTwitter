//
//  LogoutAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol LogoutAction {
    var deleteUserLocalManager: DeleteUserLocalManager { get set }
    func logout(handler: @escaping ((Result<Bool>) -> ()))
}

class LogoutActionProvider: LogoutAction {
    var deleteUserLocalManager: DeleteUserLocalManager
    
    init(deleteUserLocalManager: DeleteUserLocalManager) {
        self.deleteUserLocalManager = deleteUserLocalManager
    }
    
    func logout(handler: @escaping ((Result<Bool>) -> ())) {
        deleteUserLocalManager.deleteUser(handler: handler)
    }
}
