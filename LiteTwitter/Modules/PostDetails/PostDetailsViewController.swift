//
//  PostDetailsViewController.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 10/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

class PostDetailsViewController: BaseViewController<PostDetailsView>, PostDetailsViewActionDelegate {
    let post: Post?
    let updatePostAction: UpdatePostAction
    let createPostAction: CreatePostAction
    
    init(post: Post?,
         updatePostAction: UpdatePostAction,
         createPostAction: CreatePostAction) {
        self.post = post
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
    }
    
    func setupUI() {
        currentView.contentTextView.text = post?.content
        currentView.titleTextField.text = post?.title
        if post != nil {
            currentView.confirmButton.setTitle("Edit post", for: .normal)
        } else {
            currentView.confirmButton.setTitle("Create post", for: .normal)
        }
    }
    
    // MARK: PostDetailsViewActionDelegate
    func actionButtonWasTapped() {
        if post != nil {
            
        } else {
            
        }
        
        navigationController?.popViewController(animated: true)
    }
}
