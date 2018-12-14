//
//  LoginView.swift
//  ANPhotoCollection
//
//  Created by Dinh Thanh An on 11/11/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

@objc protocol LoginViewActionDelegate: AnyObject {
    func actionButtonWasTapped()
    func handleSegmentWasTapped(selectedIndex: Int)
}

class LoginView: BaseView {
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5.0
        return stack
    }()
    
    var userNameTextField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .black
        txtField.placeholder = "User name"
        txtField.borderStyle = .roundedRect
        txtField.autocapitalizationType = .none
        return txtField
    }()
    
    var passwordTextField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .black
        txtField.placeholder = "Password"
        txtField.isSecureTextEntry = true
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private var confirmPasswordTextField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .black
        txtField.placeholder = "Confirm Password"
        txtField.isSecureTextEntry = true
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.lightBlue
        button.addTarget(self, action: #selector(handleConfirmButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    private var segment: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Login", "Sign Up"])
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(handleSegmentWasTapped), for: .valueChanged)
        return segment
    }()
    
    public weak var actionDelegate: LoginViewActionDelegate?
    public var username: String? {
        return userNameTextField.text
    }
    public var password: String? {
        return passwordTextField.text
    }
    public var confirmPassword: String? {
        return confirmPasswordTextField.text
    }
    
    override func setupView() {
        super.setupView()
        
        stackView.addArrangedSubview(segment)
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(confirmButton)
        addSubview(stackView)
        
        confirmPasswordTextField.isHidden = true
        
        stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 30.0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
    }
    
    @objc func handleConfirmButtonWasTapped() {
        actionDelegate?.actionButtonWasTapped()
    }
    
    @objc func handleSegmentWasTapped() {
        userNameTextField.text = nil
        passwordTextField.text = nil
        confirmPasswordTextField.text = nil
        actionDelegate?.handleSegmentWasTapped(selectedIndex: segment.selectedSegmentIndex)
    }
    
    func updateUIForLoginAction() {
        confirmPasswordTextField.isHidden = true
        confirmButton.setTitle("Login", for: .normal)
    }
    
    func updateUIForSignUpAction() {
        confirmPasswordTextField.isHidden = false
        confirmButton.setTitle("Sign Up", for: .normal)
    }
}
