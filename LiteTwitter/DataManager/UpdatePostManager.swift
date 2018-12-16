//
//  UpdatePostManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 11/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Apollo

protocol UpdatePostManager: BaseURL {
    func updatePost(_ post: Post, handler: @escaping ((Result<Post>) -> ()))
}

class ApolloUpdatePostManager: UpdatePostManager {
    var baseURL: URL
    
    init(baseURL: URL = graphCoolURL) {
        self.baseURL = baseURL
    }
    
    func updatePost(_ post: Post, handler: @escaping ((Result<Post>) -> ())) {
        let apollo = ApolloClient(url: baseURL)
        apollo.perform(
            mutation: UpdatePostMutation(
                title: post.title,
                content: post.content,
                id: post.id
            ),
            queue: DispatchQueue.main) { (result, error) in
                if let error = error {
                    handler(.failed(error))
                } else if let post = result?.data?.updatePost?.fragments.postDetails {
                    handler(.success(post))
                } else {
                    handler(.failed(CustomError.noResponse))
                }
        }
    }
}
