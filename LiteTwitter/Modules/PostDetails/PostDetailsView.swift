//
//  PostDetailsView.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

@objc protocol PostDetailsViewActionDelegate: class {
    func actionButtonWasTapped()
}

class PostDetailsView: BaseView {
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5.0
        return stack
    }()
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.green, for: .normal)
        button.setTitle("Confirm", for: .normal)
        button.addTarget(self, action: #selector(handleConfirmButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    var titleTextField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .black
        txtField.placeholder = "Title"
        return txtField
    }()
    
    var contentTextView: UITextView = {
        let txtView = UITextView()
        txtView.textColor = .black
        return txtView
    }()
    
    public var actionDelegate: PostDetailsViewActionDelegate?
    
    override func setupView() {
        super.setupView()
        
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(contentTextView)
        stackView.addArrangedSubview(confirmButton)
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    @objc func handleConfirmButtonWasTapped() {
        actionDelegate?.actionButtonWasTapped()
    }
}
