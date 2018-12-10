//
//  PostDetailsCreator.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

protocol PostDetailsCreator {
    func createPostDetailsScreen(with window: UIWindow?, post: Post?) -> PostDetailsViewController
}

class PostDetailsCreatorProvider: PostDetailsCreator {
    func createPostDetailsScreen(with window: UIWindow?, post: Post?) -> PostDetailsViewController {
        let vc = PostDetailsViewController(
            post: post,
            updatePostAction: UpdatePostActionProvider(),
            createPostAction: CreatePostActionProvider()
        )
        
        return vc
    }
}
