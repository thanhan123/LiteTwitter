//
//  Networking.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol Networking {
    func request(endPoint: Endpoint, action type: RequestType, onCompleted: ((Data?) -> ())?)
}

enum Endpoint {
    case login(username: String, password: String)
    case signUp(username: String, password: String)
    case createPost
    case getPosts
    case deletePost
    case editPost
}

enum RequestType {
    case get
    case post
    case delete
    case put
}
