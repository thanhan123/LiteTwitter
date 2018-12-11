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

struct PostReponse: Post {
    let id: String
    let title: String
    let content: String
}

extension PostDetails: Post {}

protocol GetPostsManager {
    func getPosts(for userId: String, handler: @escaping ((Result<[Post]>) -> ()) )
}

class ApolloGetPostsManager: GetPostsManager {
    
    let apollo = ApolloClient(url: URL(string: graphCoolURL)!)
    
    func getPosts(for userId: String, handler: @escaping ((Result<[Post]>) -> ())) {
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
