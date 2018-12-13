//
//  ValidationFieldAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 13/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

enum ValidatitonFieldType {
    case require
    case maxCharacters(Int)
    case minCharacters(Int)
    case none
}

enum ValidationFieldResult {
    case passed
    case exceedMaxCharacters(Int)
    case lessThanMinCharacters(Int)
    case notFulfilledRequire
}

extension ValidationFieldResult: Equatable { }

protocol ValidationFieldAction {
    func validate(string: String?, type: ValidatitonFieldType) -> ValidationFieldResult
}

struct ValidationFieldActionProvider: ValidationFieldAction {
    func validate(string: String?, type: ValidatitonFieldType) -> ValidationFieldResult {
        guard let unwrappedString = string else {
            switch type {
            case .none:
                return .passed
                
            default:
                return .notFulfilledRequire
            }
        }
        
        switch type {
        case .require:
            if unwrappedString.count == 0 {
                return .notFulfilledRequire
            }
            
        case let .maxCharacters(max):
            if unwrappedString.count > max {
                return .exceedMaxCharacters(max)
            }
            
        case let .minCharacters(min):
            if unwrappedString.count < min {
                return .lessThanMinCharacters(min)
            }
            
        case .none:
            return .passed
        }
        
        return .passed
    }
}
