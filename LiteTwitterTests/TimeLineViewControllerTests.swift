//
//  TimeLineViewControllerTests.swift
//  LiteTwitterTests
//
//  Created by Dinh Thanh An on 12/15/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import XCTest
@testable import LiteTwitter

class TimeLineViewControllerTests: XCTestCase {
    
    var vc: TimeLineViewController!
    let router = RouterTest(),
    showLoaderAction = ShowLoaderActionTest(),
    showAlertAction = ShowAlertActionTest(),
    getPostsAction = GetPostsActionTest(),
    getCurrentUserAction = GetCurrentUserActionTest(),
    logoutAction = LogoutActionTest(),
    postDetailsCreator = PostDetailsCreatorTest(),
    loginCreator = LoginCreatorTest()
    
    override func setUp() {
        vc = TimeLineViewController(
            getPostsAction: getPostsAction,
            getCurrentUserAction: getCurrentUserAction,
            logoutAction: logoutAction,
            router: router,
            postDetailsCreator: postDetailsCreator,
            loginCreator: loginCreator,
            showLoaderAction: showLoaderAction,
            showAlertAction: showAlertAction
        )
        
        vc.viewDidLoad()
    }
    
    func testGetCurrentUserAction() {
        vc.viewDidLoad()
        
        assert(vc.userId == "123")
        assert(getCurrentUserAction.hasCalledGetCurrentUser)
    }
    
    func testGetPostsAction() {
        vc.viewDidLoad()
        
        assert(getPostsAction.hasCalledGetPosts)
    }
    
    func testLogoutAction() {
        vc.handleLogoutBarButtonWasTapped()
        
        assert(logoutAction.hasCalledLogout)
    }
    
    func testRouter() {
        testLogoutAction()
        
        assert(router.hasCalledChangeRootView)
    }
    
    func testPostDetailsCreatorSuccess() {
        vc.handleAddBarButtonWasTapped()
        assert(postDetailsCreator.hasCalledFunction)
    }
    
    func testPostDetailsCreatorFailure() {
        vc.userId = nil
        vc.handleAddBarButtonWasTapped()
        assert(!postDetailsCreator.hasCalledFunction)
    }
    
    func testLoginCreator() {
        testRouter()
        
        assert(loginCreator.hasCalledFunction)
    }
    
    func testAlertShowing() {
        getCurrentUserAction.willSuccess = false
        vc.viewDidLoad()
        
        assert(showAlertAction.hasCalledShow)
    }
    
    func testLoaderAction() {
        vc.viewDidLoad()
        
        assert(showLoaderAction.hasCalledShow)
        assert(showLoaderAction.hasCalledHide)
    }
    
    func testEditPostSuccess() {
        vc.tableView(vc.currentView.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        assert(postDetailsCreator.hasCalledFunction)
        assert(router.hasCalledPush)
    }
    
    func testEditPostFailure() {
        vc.userId = "12345"
        vc.tableView(vc.currentView.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        assert(!postDetailsCreator.hasCalledFunction)
        assert(!router.hasCalledPush)
    }
    
    func testUpdatePostListSuccess() {
        getPostsAction.hasCalledGetPosts = false
        vc.didUpdatePost()
        assert(getPostsAction.hasCalledGetPosts)
    }
    
    func testUpdatePostListFailure() {
        getPostsAction.hasCalledGetPosts = false
        vc.userId = nil
        
        vc.didUpdatePost()
        assert(!getPostsAction.hasCalledGetPosts)
    }
}
