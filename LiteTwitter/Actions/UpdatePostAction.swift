//
//  UpdatePostAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol UpdatePostAction {
    func updatePost(_ post: Post, handler: @escaping ((Result<Bool>) -> ()))
}

class UpdatePostActionProvider: UpdatePostAction {
    func updatePost(_ post: Post, handler: @escaping ((Result<Bool>) -> ())) {
        
    }
}
