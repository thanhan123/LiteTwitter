//
//  LoginView.swift
//  ANPhotoCollection
//
//  Created by Dinh Thanh An on 11/11/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

@objc protocol LoginViewActionDelegate: AnyObject {
    func confirmButtonWasTapped()
    func signUpButtonWasTapped()
}

class LoginView: BaseView {
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5.0
        return stack
    }()
    
    private var userNameTextField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .black
        txtField.placeholder = "User name"
        return txtField
    }()
    
    private var passwordTextField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .black
        txtField.placeholder = "Password"
        return txtField
    }()
    
    private var confirmPasswordTextField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .black
        txtField.placeholder = "Confirm Password"
        return txtField
    }()
    
    private var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.green, for: .normal)
        button.setTitle("Confirm", for: .normal)
        button.addTarget(self, action: #selector(handleConfirmButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    private var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(handleSignUpButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    public weak var actionDelegate: LoginViewActionDelegate?
    
    override func setupView() {
        super.setupView()
        
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
//        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(confirmButton)
//        stackView.addArrangedSubview(signUpButton)
        addSubview(stackView)
        
        confirmPasswordTextField.isHidden = true
        
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func handleConfirmButtonWasTapped() {
        actionDelegate?.confirmButtonWasTapped()
    }
    
    @objc func handleSignUpButtonWasTapped() {
        confirmPasswordTextField.isHidden.toggle()
    }
}
