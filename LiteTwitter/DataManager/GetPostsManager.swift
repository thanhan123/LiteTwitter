//
//  GetPostsManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Apollo

protocol Post {
    var id: String { get }
    var title: String { get }
    var content: String { get }
}

protocol GetPostsManager {
    func getPosts(for userId: String, handler: @escaping ((Result<[Post]>) -> ()) )
}

class ApolloGetPostsManager: GetPostsManager {
    
    let apollo = ApolloClient(url: URL(string: graphCoolURL)!)
    
    func getPosts(for userId: String, handler: @escaping ((Result<[Post]>) -> ())) {
        
    }
}
