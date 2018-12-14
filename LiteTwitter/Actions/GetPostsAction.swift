//
//  GetPostsManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol GetPostsAction {
    var getPostsManager: GetPostsManager { get set }
    func getPosts(handler: @escaping (([Post]) -> ()))
}

class GetPostsActionProvider: GetPostsAction {
    var getPostsManager: GetPostsManager
    
    init(getPostsManager: GetPostsManager) {
        self.getPostsManager = getPostsManager
    }
    
    func getPosts(handler: @escaping (([Post]) -> ())) {
        getPostsManager.getPosts { (result) in
            switch result {
            case let .success(posts):
                handler(posts)
                
            case .failed:
                handler([])
            }
        }
    }
}
