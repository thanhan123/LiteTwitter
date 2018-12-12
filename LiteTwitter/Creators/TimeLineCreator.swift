//
//  TimeLineCreator.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

protocol TimeLineCreator {
    func createTimeLineScreen(with window: UIWindow?) -> TimeLineViewController
}

class TimeLineCreatorProvider: TimeLineCreator {
    func createTimeLineScreen(with window: UIWindow?) -> TimeLineViewController {
        let vc = TimeLineViewController(
            getPostsAction: GetPostsActionProvider(getPostsManager: ApolloGetPostsManager()),
            getCurrentUserAction: GetCurrentUserActionProvider(getCurrentLocalUser: UserDefaultGetUserLocalManager()),
            logoutAction: LogoutActionProvider(deleteUserLocalManager: UserDefaultDeleteUserLocalManager()),
            router: RouterProvider(window: window),
            postDetailsCreator: PostDetailsCreatorProvider(),
            loginCreator: LoginCreatorProvider(),
            showLoaderAction: MBProgressHUDShowLoaderAction(),
            showAlertAction: ShowAlertActionProvider()
        )
        
        return vc
    }
}
