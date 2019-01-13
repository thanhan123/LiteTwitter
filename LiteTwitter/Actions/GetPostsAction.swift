//
//  GetPostsManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol GetPostsAction {
    func getPosts(handler: @escaping (([Post]) -> ()))
}

class GetPostsActionProvider: GetPostsAction {
    var getPostsManager: GetPostsManager
    var postsLocalManager: GetPostsLocalManager & PostPostsLocalManager
    var internetChecking: InternetConnectionCheckingAction
    
    init(getPostsManager: GetPostsManager,
         postsLocalManager: GetPostsLocalManager & PostPostsLocalManager,
         internetChecking: InternetConnectionCheckingAction = InternetConnectionCheckingActionProvider()) {
        self.getPostsManager = getPostsManager
        self.postsLocalManager = postsLocalManager
        self.internetChecking = internetChecking
    }
    
    func getPosts(handler: @escaping (([Post]) -> ())) {
        var hasCalledRemote = false
        let getPostsHandler: (Result<[Post]>) -> () = { [weak self] (result) in
            switch result {
            case let .success(posts):
                handler(posts)
                if hasCalledRemote {
                    self?.postsLocalManager.postPosts(posts, handler: { _ in })
                }
                
            case .failed:
                handler([])
            }
        }
        
        internetChecking.startChecking(
            reachable: { [weak self] in
                hasCalledRemote = true
                self?.getPostsManager.getPosts(handler: getPostsHandler)
            },
            unreachable: { [weak self] in
                hasCalledRemote = false
                self?.postsLocalManager.getPosts(handler: getPostsHandler)
            }
        )
    }
}
