//
//  UpdatePostAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol UpdatePostAction {
    var updatePostManager: UpdatePostManager { get set }
    func updatePost(_ post: Post, handler: @escaping ((Result<Bool>) -> ()))
}

class UpdatePostActionProvider: UpdatePostAction {
    var updatePostManager: UpdatePostManager
    
    init(updatePostManager: UpdatePostManager) {
        self.updatePostManager = updatePostManager
    }
    
    func updatePost(_ post: Post, handler: @escaping ((Result<Bool>) -> ())) {
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
