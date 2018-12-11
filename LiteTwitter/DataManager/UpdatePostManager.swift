//
//  UpdatePostManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 11/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Apollo

protocol UpdatePostManager {
    func updatePost(_ post: Post, handler: @escaping ((Result<Post>) -> ()))
}

class UpdatePostManagerProvider: UpdatePostManager {
    let apollo = ApolloClient(url: URL(string: graphCoolURL)!)
    
    func updatePost(_ post: Post, handler: @escaping ((Result<Post>) -> ())) {
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
