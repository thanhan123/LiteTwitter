//
//  CustomError.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case noResponse
    case noObject
    case userNameOrPasswordWrong
}

extension CustomError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noResponse:
            return "There is no reponse"
            
        case .noObject:
            return "There is no reponse"
            
        case .userNameOrPasswordWrong:
            return "Username or password was wrong"
        }
    }
}
