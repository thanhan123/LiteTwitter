//
//  DeletePostManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Apollo

protocol DeletePostManager: BaseURL {
    func deletePost(id: String, handler: @escaping ((Result<String>) -> ()))
}

class ApolloDeletePostManager: DeletePostManager {
    var baseURL: URL
    
    init(baseURL: URL = graphCoolURL) {
        self.baseURL = baseURL
    }
    
    func deletePost(id: String, handler: @escaping ((Result<String>) -> ())) {
        let apolloClient = ApolloClient(url: baseURL)
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
