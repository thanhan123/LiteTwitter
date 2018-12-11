//
//  CreatePostAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol CreatePostAction {
    var createPostManager: CreatePostManager { get set }
    func createPost(content: String, title: String, authorId: String, handler: @escaping ((Result<Bool>) -> ()))
}

class CreatePostActionProvider: CreatePostAction {
    var createPostManager: CreatePostManager
    
    init(createPostManager: CreatePostManager) {
        self.createPostManager = createPostManager
    }
    
    func createPost(content: String, title: String, authorId: String, handler: @escaping ((Result<Bool>) -> ())) {
        createPostManager.createPost(
            content: content,
            title: title,
            authorId: authorId) { (result) in
                switch result {
                case .success:
                    handler(.success(true))
                    
                case let .failed(error):
                    handler(.failed(error))
                }
        }
    }
}
