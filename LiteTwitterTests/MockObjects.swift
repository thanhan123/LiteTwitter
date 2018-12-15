//
//  MockObjects.swift
//  LiteTwitterTests
//
//  Created by Dinh Thanh An on 12/15/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation
import UIKit
@testable import LiteTwitter

class LoginActionTest: LoginAction {
    var saveUserLocalManager: SaveUserLocalManager
    var loginManager: LoginManager
    
    var hasCalledLogin = false
    var willSuccess = true
    
    init() {
        self.saveUserLocalManager = KeyChainSaveUserLocalManager()
        self.loginManager = ApolloLoginManager()
    }
    
    func login(with username: String, password: String, handler: @escaping (Result<Bool>) -> ()) {
        hasCalledLogin = true
        if willSuccess {
            handler(.success(true))
        } else {
            handler(.failed(CustomError.noResponse))
        }
    }
}

class SignUpActionTest: SignUpAction {
    var saveUserLocalManager: SaveUserLocalManager
    var signUpManager: SignUpManager
    
    var hasCalledSignUp = false
    var willSuccess = true
    
    init() {
        self.saveUserLocalManager = KeyChainSaveUserLocalManager()
        self.signUpManager = ApolloSignUpManager()
    }
    
    func signUp(with username: String, password: String, handler: @escaping (Result<Bool>) -> ()) {
        hasCalledSignUp = true
        if willSuccess {
            handler(.success(true))
        } else {
            handler(.failed(CustomError.noResponse))
        }
    }
}

class TimeLineCreatorTest: TimeLineCreator {
    var hasCalledFunction = false
    
    func createTimeLineScreen(with window: UIWindow?) -> TimeLineViewController {
        hasCalledFunction = true
        return TimeLineCreatorProvider().createTimeLineScreen(with: window)
    }
}

class RouterTest: Router {
    var hasCalledPresent = false
    var hasCalledPush = false
    var hasCalledChangeRootView = false
    
    var window: UIWindow?
    
    init() {
        window = nil
    }
    
    func present(_ vc: UIViewController, from sourceVC: UIViewController, animated: Bool, completion: (() -> ())?) {
        hasCalledPresent = true
    }
    
    func push(_ vc: UIViewController, from sourceVC: UIViewController, animated: Bool) {
        hasCalledPush = true
    }
    
    func changeRootView(_ vc: UIViewController) {
        hasCalledChangeRootView = true
    }
}

class ShowLoaderActionTest: ShowLoaderAction {
    var hasCalledShow = false
    var hasCalledHide = false
    
    func show(in view: UIView) {
        hasCalledShow = true
    }
    
    func hide(in view: UIView) {
        hasCalledHide = true
    }
}

class ShowAlertActionTest: ShowAlertAction {
    var hasCalledShow = false
    var doActionAtIndex = 0
    
    func show(title: String?, message: String?, cancel: String?, buttons: [String], action: ((Int) -> ())?, sender: UIViewController) {
        hasCalledShow = true
        action?(doActionAtIndex)
    }
}

class ValidateInputsActionTest: ValidateInputsAction {
    var validationFieldManager: ValidationFieldManager
    
    var hasCallValidate = false
    var willSuccess = true
    
    init() {
        validationFieldManager = ValidationFieldManagerProvider()
    }
    
    func validate(type: ValidationActionType) -> (isValid: Bool, message: String?) {
        hasCallValidate = true
        return (willSuccess, nil)
    }
}

class GetPostsActionTest: GetPostsAction {
    var getPostsManager: GetPostsManager
    
    var posts = [PostResponse(id: "123", title: "title", content: "content", authorId: "123")]
    var hasCalledGetPosts = false
    
    init() {
        getPostsManager = ApolloGetPostsManager()
    }
    
    func getPosts(handler: @escaping (([Post]) -> ())) {
        hasCalledGetPosts = true
        handler(posts)
    }
}

class GetCurrentUserActionTest: GetCurrentUserAction {
    var getCurrentLocalUser: GetUserLocalManager
    
    var hasCalledGetCurrentUser = false
    var willSuccess = true
    
    init() {
        getCurrentLocalUser = KeyChainGetUserLocalManager()
    }
    
    func getCurrentUser(handler: @escaping ((Result<User>) -> ())) {
        hasCalledGetCurrentUser = true
        if willSuccess {
            handler(.success(UserResponse(id: "123", username: "123")))
        } else {
            handler(.failed(CustomError.noResponse))
        }
    }
}

class LogoutActionTest: LogoutAction {
    var deleteUserLocalManager: DeleteUserLocalManager
    
    var hasCalledLogout = false
    var willSuccess = true
    
    init() {
        deleteUserLocalManager = KeyChainDeleteUserLocalManager()
    }
    
    func logout(handler: @escaping ((Result<Bool>) -> ())) {
        hasCalledLogout = true
        if willSuccess {
            handler(.success(true))
        } else {
            handler(.failed(CustomError.noObject))
        }
    }
}

class PostDetailsCreatorTest: PostDetailsCreator {
    var hasCalledFunction = false
    
    func createPostDetailsScreen(with window: UIWindow?, screenType: PostDetailsScreenType, delegate: PostDetailsViewDelegate?) -> PostDetailsViewController {
        hasCalledFunction = true
        return PostDetailsCreatorProvider().createPostDetailsScreen(with: window, screenType: screenType, delegate: delegate)
    }
}

class LoginCreatorTest: LoginCreator {
    var hasCalledFunction = false
    
    func createLoginScreen(with window: UIWindow?) -> LoginViewController {
        hasCalledFunction = true
        return LoginCreatorProvider().createLoginScreen(with: window)
    }
}

class PostDetailsViewDelegateTest: PostDetailsViewDelegate {
    var hasCallDidUpdatePost = false
    
    func didUpdatePost() {
        hasCallDidUpdatePost = true
    }
}

class UpdatePostActionTest: UpdatePostAction {
    var updatePostManager: UpdatePostManager
    
    init() {
        updatePostManager = ApolloUpdatePostManager()
    }
    
    var willSuccess = true
    var hasCalledUpdatePost = false
    
    func updatePost(_ post: Post, handler: @escaping ((Result<Bool>) -> ())) {
        hasCalledUpdatePost = true
        if willSuccess {
            handler(.success(true))
        } else {
            handler(.failed(CustomError.noResponse))
        }
    }
}

class CreatePostActionTest: CreatePostAction {
    var createPostManager: CreatePostManager
    
    init() {
        createPostManager = ApolloCreatePostManager()
    }
    
    var willSuccess = true
    var hasCalledCreatePost = false
    
    func createPost(content: String, title: String, authorId: String, handler: @escaping ((Result<Bool>) -> ())) {
        hasCalledCreatePost = true
        if willSuccess {
            handler(.success(true))
        } else {
            handler(.failed(CustomError.noResponse))
        }
    }
}

class DeletePostActionTest: DeletePostAction {
    var deletePostManager: DeletePostManager
    
    init() {
        deletePostManager = ApolloDeletePostManager()
    }
    
    var willSuccess = true
    var hasCalledDeletePost = false
    
    func deletePost(id: String, handler: @escaping ((Result<Bool>) -> ())) {
        hasCalledDeletePost = true
        if willSuccess {
            handler(.success(true))
        } else {
            handler(.failed(CustomError.noResponse))
        }
    }
}
