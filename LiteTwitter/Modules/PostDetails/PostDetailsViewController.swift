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

class PostDetailsViewController: BaseViewController<PostDetailsView>, PostDetailsViewActionDelegate {
    let screenType: PostDetailsScreenType
    let updatePostAction: UpdatePostAction
    let createPostAction: CreatePostAction
    
    init(screenType: PostDetailsScreenType,
         updatePostAction: UpdatePostAction,
         createPostAction: CreatePostAction) {
        self.screenType = screenType
        self.updatePostAction = updatePostAction
        self.createPostAction = createPostAction
        
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
            currentView.contentTextView.text = post.content
            currentView.titleTextField.text = post.title
            currentView.confirmButton.setTitle("Edit post", for: .normal)
            
        case .createPost:
            currentView.confirmButton.setTitle("Create post", for: .normal)
        }
    }
    
    // MARK: PostDetailsViewActionDelegate
    func actionButtonWasTapped() {
        guard let title = currentView.titleTextField.text,
            let content = currentView.contentTextView.text else {
            return
        }
        
        let handler: ((Result<Bool>) -> ()) = { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
                
            case let .failed(error):
                print(error)
            }
        }
        switch screenType {
        case let .edit(post):
            let newPost = PostReponse(
                id: post.id,
                title: title,
                content: content
            )
            updatePostAction.updatePost(newPost, handler: handler)
            
        case let .createPost(authorId):
            createPostAction.createPost(
                content: content,
                title: title,
                authorId: authorId,
                handler: handler
            )
        }
    }
}
