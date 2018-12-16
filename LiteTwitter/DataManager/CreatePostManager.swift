//
//  CreatePostManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 11/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Apollo

protocol CreatePostManager: BaseURL {
    func createPost(content: String, title: String, authorId: String, handler: @escaping ((Result<Post>) -> ()))
}

class ApolloCreatePostManager: CreatePostManager {
    var baseURL: URL
    
    init(baseURL: URL = graphCoolURL) {
        self.baseURL = baseURL
    }
    
    func createPost(content: String, title: String, authorId: String, handler: @escaping ((Result<Post>) -> ())) {
        let apollo = ApolloClient(url: baseURL)
        apollo.perform(
            mutation: CreatePostMutation(
                title: title,
                content: content,
                authorId: authorId
            ),
            queue: DispatchQueue.main) { (result, error) in
                if let error = error {
                    handler(.failed(error))
                } else if let post = result?.data?.createPost?.fragments.postDetails {
                    handler(.success(post))
                } else {
                    handler(.failed(CustomError.noResponse))
                }
        }
    }
}
