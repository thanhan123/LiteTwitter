//
//  ValidateInputsTest.swift
//  LiteTwitterTests
//
//  Created by Dinh Thanh An on 12/15/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

import XCTest
@testable import LiteTwitter

class ValidateInputsTest: XCTestCase {
    
    let validateInputs = ValidateInputsActionProvider(validationFieldManager: ValidationFieldManagerProvider())
    
    func testValidLoginInput() {
        let result = validateInputs.validate(type: .login(username: "1", password: "1"))
        assert(result.isValid)
        XCTAssertNil(result.message)
    }
    
    func testInvalidLoginInput() {
        var result = validateInputs.validate(type: .login(username: "", password: "1"))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        
        result = validateInputs.validate(type: .login(username: "1", password: ""))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        
        result = validateInputs.validate(type: .login(username: nil, password: ""))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        
        result = validateInputs.validate(type: .login(username: nil, password: nil))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        
        result = validateInputs.validate(type: .login(username: "1", password: nil))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
    }
    
    func testValidSignUpInput() {
        let result = validateInputs.validate(type: .signUp(username: "123", password: "123", confirmPassword: "123"))
        assert(result.isValid)
        XCTAssertNil(result.message)
    }
    
    func testInvalidSignUpInput() {
        var result = validateInputs.validate(type: .signUp(username: "123", password: "123", confirmPassword: "1234"))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        
        result = validateInputs.validate(type: .signUp(username: "123", password: "", confirmPassword: ""))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        
        result = validateInputs.validate(type: .signUp(username: "123", password: nil, confirmPassword: ""))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        
        result = validateInputs.validate(type: .signUp(username: nil, password: "123", confirmPassword: "123"))
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
    }
}
