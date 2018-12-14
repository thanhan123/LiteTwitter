//
//  GetPostsManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Apollo

protocol GetPostsManager {
    func getPosts(handler: @escaping ((Result<[Post]>) -> ()) )
}

class ApolloGetPostsManager: GetPostsManager {
    
    let apollo = ApolloClient(url: URL(string: graphCoolURL)!)
    
    func getPosts(handler: @escaping ((Result<[Post]>) -> ())) {
        apollo.fetch(
            query: AllPostsQuery(),
            cachePolicy: .fetchIgnoringCacheData,
            queue: DispatchQueue.main) { (result, error) in
                if let error = error {
                    handler(.failed(error))
                } else if let result = result {
                    if let data = result.data?.allPosts.map({ $0.fragments.postDetails }) {
                        handler(.success(data))
                    } else {
                        handler(.failed(CustomError.noResponse))
                    }
                }
        }
    }
}
