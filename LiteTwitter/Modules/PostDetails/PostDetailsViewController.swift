//
//  PostDetailsViewController.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

enum PostDetailsScreenType {
    case edit(Post)
    case createPost(author: String)
}

protocol PostDetailsViewDelegate: class {
    func didUpdatePost()
}

class PostDetailsViewController: BaseViewController<PostDetailsView>, PostDetailsViewActionDelegate {
    var screenType: PostDetailsScreenType
    let updatePostAction: UpdatePostAction
    let createPostAction: CreatePostAction
    let deletePostAction: DeletePostAction
    let showAlertAction: ShowAlertAction
    let showLoaderAction: ShowLoaderAction
    let validateInputsAction: ValidateInputsAction
    weak var delegate: PostDetailsViewDelegate?
    
    lazy var actionHandler: ((Result<Bool>) -> ()) = { [weak self] result in
        guard let self = self else {
            return
        }
        
        self.showLoaderAction.hide(in: self.currentView)
        switch result {
        case .success:
            self.delegate?.didUpdatePost()
            
        case let .failed(error):
            self.showAlertAction.show(
                title: "Error",
                message: "\(error)",
                cancel: nil,
                buttons: ["Ok"],
                action: nil,
                sender: self
            )
        }
    }
    
    init(screenType: PostDetailsScreenType,
         updatePostAction: UpdatePostAction,
         createPostAction: CreatePostAction,
         deletePostAction: DeletePostAction,
         showAlertAction: ShowAlertAction,
         showLoaderAction: ShowLoaderAction,
         validateInputsAction: ValidateInputsAction,
         delegate: PostDetailsViewDelegate?) {
        self.screenType = screenType
        self.updatePostAction = updatePostAction
        self.createPostAction = createPostAction
        self.deletePostAction = deletePostAction
        self.showAlertAction = showAlertAction
        self.showLoaderAction = showLoaderAction
        self.validateInputsAction = validateInputsAction
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentView.actionDelegate = self
        setupUI()
    }
    
    func setupUI() {
        switch screenType {
        case let .edit(post):
            currentView.updateContent(post.content)
            currentView.updateTitle(post.title)
            title = "Edit post"
            navigationItem.rightBarButtonItem = currentView.deleteBarButton
            
        case .createPost:
            title = "Create post"
        }
    }
    
    // MARK: PostDetailsViewActionDelegate
    func actionButtonWasTapped() {
        guard let title = currentView.titleString else {
            return
        }
        
        let content = currentView.contentString
        
        showLoaderAction.show(in: currentView)
        switch screenType {
        case let .edit(post):
            let newPost = PostResponse(
                id: post.id,
                title: title,
                content: content,
                authorId: post.authorId
            )
            updatePostAction.updatePost(newPost, handler: actionHandler)
            
        case let .createPost(authorId):
            createPostAction.createPost(
                content: content,
                title: title,
                authorId: authorId,
                handler: actionHandler
            )
        }
    }
    
    func deleteButtonWasTapped() {
        switch screenType {
        case let .edit(post):
            showAlertAction.show(
                title: "Alert",
                message: "Do you want to delete this post?",
                cancel: "Cancel",
                buttons: ["Ok"],
                action: { [weak self] index in
                    guard let self = self else {
                        return
                    }
                    
                    if index == 0 {
                        self.showLoaderAction.show(in: self.currentView)
                        self.deletePostAction.deletePost(id: post.id, handler: self.actionHandler)
                    }
                },
                sender: self
            )
            
        default:
            break
        }
    }
    
    func handleInputFieldChanged() {
        let isInputValid = validateInputsAction.validate(type: .postDetails(
            title: currentView.titleString,
            content: currentView.contentString)
        ).isValid
        currentView.updateConfirmButton(isEnabled: isInputValid)
    }
}
