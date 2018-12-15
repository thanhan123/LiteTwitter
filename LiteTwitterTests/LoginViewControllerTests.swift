//
//  LoginViewControllerTests.swift
//  LoginViewControllerTests
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import XCTest
@testable import LiteTwitter

class LoginViewControllerTests: XCTestCase {
    
    var vc: LoginViewController!
    let loginAction = LoginActionTest(),
    signUpAction = SignUpActionTest(),
    timeLineCreator = TimeLineCreatorTest(),
    router = RouterTest(),
    showLoaderAction = ShowLoaderActionTest(),
    showAlertAction = ShowAlertActionTest(),
    validateInputsAction = ValidateInputsActionTest()
    
    override func setUp() {
        vc = LoginViewController(
            loginAction: loginAction,
            signUpAction: signUpAction,
            timeLineCreator: timeLineCreator,
            router: router,
            showLoaderAction: showLoaderAction,
            showAlertAction: showAlertAction,
            validateInputsAction: validateInputsAction
        )
        
        vc.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginAction() {
        vc.actionButtonWasTapped()
        
        assert(validateInputsAction.hasCallValidate)
        assert(timeLineCreator.hasCalledFunction)
        assert(router.hasCalledChangeRootView)
        assert(loginAction.hasCalledLogin)
    }
    
    func testSignUpAction() {
        vc.handleSegmentWasTapped(selectedIndex: 1)
        vc.actionButtonWasTapped()
        
        assert(vc.state == .signUp)
        assert(validateInputsAction.hasCallValidate)
        assert(timeLineCreator.hasCalledFunction)
        assert(router.hasCalledChangeRootView)
        assert(signUpAction.hasCalledSignUp)
    }
    
    func testLoaderShowing() {
        vc.actionButtonWasTapped()
        
        assert(showLoaderAction.hasCalledShow)
        assert(showLoaderAction.hasCalledHide)
    }
    
    func testAlertShowing() {
        // given
        loginAction.willSuccess = false
        
        // when
        vc.actionButtonWasTapped()
        
        // then
        assert(showAlertAction.hasCalledShow)
    }
}

