//
//  DeletePostManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Apollo

protocol DeletePostManager {
    func deletePost(id: String, handler: @escaping ((Result<String>) -> ()))
}

class ApolloDeletePostManager: DeletePostManager {
    let apolloClient = ApolloClient(url: URL(string: graphCoolURL)!)
    
    func deletePost(id: String, handler: @escaping ((Result<String>) -> ())) {
        apolloClient.perform(
            mutation: DeletePostMutation(id: id),
            queue: DispatchQueue.main) { (result, error) in
                if let error = error {
                    handler(.failed(error))
                } else if let id = result?.data?.deletePost?.id {
                    handler(.success(id))
                } else {
                    handler(.failed(CustomError.noResponse))
                }
        }
    }
}
