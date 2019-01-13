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
    var updatePostManager: UpdatePostManager
    var internetChecking: InternetConnectionCheckingAction
    
    init(updatePostManager: UpdatePostManager,
         internetChecking: InternetConnectionCheckingAction = InternetConnectionCheckingActionProvider()) {
        self.updatePostManager = updatePostManager
        self.internetChecking = internetChecking
    }
    
    func updatePost(_ post: Post, handler: @escaping ((Result<Bool>) -> ())) {
        internetChecking.startChecking(
            reachable: {
                
        },
            unreachable: {
                
        }
        )
        
        updatePostManager.updatePost(post) { (result) in
            switch result {
            case .success:
                handler(.success(true))
                
            case let .failed(error):
                handler(.failed(error))
            }
        }
    }
}
