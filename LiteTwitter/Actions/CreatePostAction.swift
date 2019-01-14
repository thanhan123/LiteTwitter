//
//  CreatePostAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol CreatePostAction {
    func createPost(content: String, title: String, authorId: String, handler: @escaping ((Result<Bool>) -> ()))
}

class CreatePostActionProvider: CreatePostAction {
    var createPostManager: CreatePostManager
    var savePostManager: PostPostsLocalManager
    var internetChecking: InternetConnectionCheckingAction
    
    init(createPostManager: CreatePostManager,
         savePostManager: PostPostsLocalManager = CoreDataLocalPostsManagerProvider(),
         internetChecking: InternetConnectionCheckingAction = InternetConnectionCheckingActionProvider()) {
        self.createPostManager = createPostManager
        self.savePostManager = savePostManager
        self.internetChecking = internetChecking
    }
    
    func createPost(content: String, title: String, authorId: String, handler: @escaping ((Result<Bool>) -> ())) {
        internetChecking.startChecking(
            reachable: { [weak self] in
                self?.createPostManager.createPost(
                    content: content,
                    title: title,
                    authorId: authorId) { (result) in
                        switch result {
                        case let .success(post):
                            self?.savePostManager.postPosts([post], handler: { _ in })
                            handler(.success(true))
                            
                        case let .failed(error):
                            handler(.failed(error))
                        }
                }
            },
            unreachable: {
                
            }
        )
        
    }
}
