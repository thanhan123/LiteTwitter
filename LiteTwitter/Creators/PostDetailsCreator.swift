//
//  PostDetailsCreator.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

protocol PostDetailsCreator {
    func createPostDetailsScreen(with window: UIWindow?, screenType: PostDetailsScreenType) -> PostDetailsViewController
}

class PostDetailsCreatorProvider: PostDetailsCreator {
    func createPostDetailsScreen(with window: UIWindow?, screenType: PostDetailsScreenType) -> PostDetailsViewController {
        let vc = PostDetailsViewController(
            screenType: screenType,
            updatePostAction: UpdatePostActionProvider(updatePostManager: ApolloUpdatePostManager()),
            createPostAction: CreatePostActionProvider(createPostManager: ApolloCreatePostManager()),
            deletePostAction: DeletePostActionProvider(deletePostManager: ApolloDeletePostManager()),
            showAlertAction: ShowAlertActionProvider(),
            showLoaderAction: MBProgressHUDShowLoaderAction(),
            validationFieldAction: ValidationFieldActionProvider()
        )
        
        return vc
    }
}
