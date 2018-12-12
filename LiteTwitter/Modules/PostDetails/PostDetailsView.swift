//
//  PostDetailsView.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit
import AloeStackView

@objc protocol PostDetailsViewActionDelegate: class {
    func actionButtonWasTapped()
    func deleteButtonWasTapped()
}

class PostDetailsView: BaseView {
    
    private var stackView: AloeStackView = {
        let stackView = AloeStackView()
        stackView.hidesSeparatorsByDefault = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var deleteBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .trash, target: nil, action: nil)
        return button
    }()
    
    var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.green, for: .normal)
        button.setTitle("Confirm", for: .normal)
        button.addTarget(self, action: #selector(handleConfirmButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Post title"
        return label
    }()
    
    var titleTextField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .black
        txtField.placeholder = "Title"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Post content"
        return label
    }()
    
    var contentTextView: UITextView = {
        let txtView = UITextView()
        txtView.textColor = .black
        txtView.isScrollEnabled = false
        txtView.layer.borderColor = UIColor.black.cgColor
        txtView.layer.borderWidth = 0.2
        txtView.layer.cornerRadius = 1
        return txtView
    }()
    
    public var actionDelegate: PostDetailsViewActionDelegate?
    
    override func setupView() {
        super.setupView()
        
        stackView.addRow(titleLabel)
        stackView.addRow(titleTextField)
        stackView.addRow(contentLabel)
        stackView.addRow(contentTextView)
        
        let buttonStackView = UIStackView(arrangedSubviews: [confirmButton])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 5
        buttonStackView.alignment = .center
        stackView.addRow(buttonStackView)
        
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        deleteBarButton.target = self
        deleteBarButton.action = #selector(handleDeleteButtonWasTapped)
        titleTextField.addTarget(self, action: #selector(handleInputFieldChanged), for: .allEditingEvents)
        contentTextView.delegate = self
    }
    
    @objc func handleDeleteButtonWasTapped() {
        actionDelegate?.deleteButtonWasTapped()
    }
    
    @objc func handleConfirmButtonWasTapped() {
        actionDelegate?.actionButtonWasTapped()
    }
    
    @objc func handleInputFieldChanged() {
        confirmButton.isEnabled = contentTextView.text.count > 0 &&
            titleTextField.text != nil &&
            titleTextField.text!.count > 0
    }
}

extension PostDetailsView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        handleInputFieldChanged()
    }
}
