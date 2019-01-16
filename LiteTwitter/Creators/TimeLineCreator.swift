//
//  TimeLineCreator.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit
import Profile

protocol TimeLineCreator {
    func createTimeLineScreen(with window: UIWindow?) -> TimeLineViewController
}

class TimeLineCreatorProvider: TimeLineCreator {
    func createTimeLineScreen(with window: UIWindow?) -> TimeLineViewController {
        let vc = TimeLineViewController(
            logicController: TimeLineLogicControllerProvider(
                getCurrentUserAction: GetCurrentUserActionProvider(getCurrentLocalUser: KeyChainGetUserLocalManager()),
                getPostsAction: GetPostsActionProvider(
                    getPostsManager: ApolloGetPostsManager(),
                    postsLocalManager: CoreDataLocalPostsManagerProvider()
                )
            ),
            logoutAction: LogoutActionProvider(deleteUserLocalManager: KeyChainDeleteUserLocalManager()),
            router: RouterProvider(window: window),
            postDetailsCreator: PostDetailsCreatorProvider(),
            loginCreator: LoginCreatorProvider(),
            showLoaderAction: MBProgressHUDShowLoaderAction(),
            showAlertAction: ShowAlertActionProvider(),
            profileCreator: ProfileCreatorProvider()
        )
        
        return vc
    }
}
