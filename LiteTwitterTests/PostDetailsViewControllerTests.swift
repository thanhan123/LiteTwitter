//
//  PostDetailsViewControllerTests.swift
//  LiteTwitterTests
//
//  Created by Dinh Thanh An on 12/15/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import XCTest
@testable import LiteTwitter

class PostDetailsViewControllerTests: XCTestCase {
    var vc: PostDetailsViewController!
    let screenType1: PostDetailsScreenType = .edit(PostResponse(id: "123", title: "title", content: "content", authorId: "123")),
    screenType2: PostDetailsScreenType = .createPost(author: "123"),
    updatePostAction = UpdatePostActionTest(),
    createPostAction = CreatePostActionTest(),
    deletePostAction = DeletePostActionTest(),
    showAlertAction = ShowAlertActionTest(),
    showLoaderAction = ShowLoaderActionTest(),
    validateInputsAction = ValidateInputsActionTest(),
    delegate = PostDetailsViewDelegateTest()
    
    override func setUp() {
        vc = PostDetailsViewController(
            screenType: screenType1,
            updatePostAction: updatePostAction,
            createPostAction: createPostAction,
            deletePostAction: deletePostAction,
            showAlertAction: showAlertAction,
            showLoaderAction: showLoaderAction,
            validateInputsAction: validateInputsAction,
            delegate: delegate
        )
        
        vc.viewDidLoad()
    }
    
    func testUpdatePostAction() {
        vc.actionButtonWasTapped()
        
        assert(updatePostAction.hasCalledUpdatePost)
    }
    
    func testDeletePost() {
        vc.deleteButtonWasTapped()
        
        showAlertAction.doActionAtIndex = 0
        assert(showAlertAction.hasCalledShow)
        
        assert(deletePostAction.hasCalledDeletePost)
    }
    
    func testAlertShowing() {
        updatePostAction.hasCalledUpdatePost = false
        updatePostAction.willSuccess = false
        vc.actionButtonWasTapped()
        assert(showAlertAction.hasCalledShow)
    }
    
    func testLoaderShowing() {
        showLoaderAction.hasCalledShow = false
        showLoaderAction.hasCalledHide = false
        
        vc.actionButtonWasTapped()
        
        assert(showLoaderAction.hasCalledShow)
        assert(showLoaderAction.hasCalledHide)
    }
    
    func testValidateInputs() {
        vc.handleInputFieldChanged()
        
        assert(validateInputsAction.hasCallValidate)
    }
    
    func testDelegate() {
        vc.actionButtonWasTapped()
        
        assert(delegate.hasCallDidUpdatePost)
    }
    
    func testCreatePostAction() {
        vc.screenType = screenType2
        vc.actionButtonWasTapped()
        
        assert(createPostAction.hasCalledCreatePost)
    }
}
