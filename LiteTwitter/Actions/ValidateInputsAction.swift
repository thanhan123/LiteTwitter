//
//  ValidateInputsAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/15/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

enum ValidationActionType {
    case login(username: String?, password: String?)
    case signUp(username: String?, password: String?, confirmPassword: String?)
    case postDetails(title: String?, content: String?)
}

protocol ValidateInputsAction {
    var validationFieldManager: ValidationFieldManager { get set }
    func validate(type: ValidationActionType) -> (isValid: Bool, message: String?)
}

class ValidateInputsActionProvider: ValidateInputsAction {
    var validationFieldManager: ValidationFieldManager
    
    init(validationFieldManager: ValidationFieldManager) {
        self.validationFieldManager = validationFieldManager
    }
    
    func validate(type: ValidationActionType) -> (isValid: Bool, message: String?) {
        switch type {
        case let .login(username, password):
            if validationFieldManager.validate(string: username, type: .require) != .passed {
                return (false, "username is required")
            }
            
            if validationFieldManager.validate(string: password, type: .require) != .passed {
                return (false, "password is required")
            }
            
        case let .signUp(username, password, confirmPassword):
            let validateUserNameAndPassword = validate(type: .login(username: username, password: password))
            if !validateUserNameAndPassword.isValid {
                return validateUserNameAndPassword
            }
            
            if password != confirmPassword {
                return (false, "Confirm password is required and must be same with password")
            }
            
        case let .postDetails(title, content):
            if validationFieldManager.validate(string: title, type: .require) != .passed &&
                validationFieldManager.validate(string: content, type: .require) != .passed {
                return (false, nil)
            }
        }
        
        return (true, nil)
    }
}
