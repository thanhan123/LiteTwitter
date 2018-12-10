//
//  CreatePostAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol CreatePostAction {
    func createPost(_ post: Post, handler: @escaping ((Result<Bool>) -> ()))
}

class CreatePostActionProvider: CreatePostAction {
    func createPost(_ post: Post, handler: @escaping ((Result<Bool>) -> ())) {
        
    }
}
