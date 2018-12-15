//
//  Post.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 14/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol Post {
    var id: String { get }
    var title: String { get }
    var content: String { get }
    var authorId: String { get }
}

struct PostResponse: Post {
    let id: String
    let title: String
    let content: String
    let authorId: String
}

extension PostDetails: Post {
    var authorId: String {
        return author.id
    }
}
