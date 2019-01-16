//
//  TimeLineViewController.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit
import Profile

class TimeLineViewController: BaseViewController<TimeLineView>, TimeLineViewActionDelegate, UITableViewDelegate {
    private var dataSource: TableViewDataSource<Post>?
    private var heights = [String: CGFloat]()
    private lazy var receivePostsHandler: (Result<[Post]>) -> () = { [weak self] (result) in
        switch result {
        case let .success(posts):
            self?.handleEvent(event: .onReceivePosts(posts))
            
        case let .failed(error):
            self?.handleEvent(event: .onReceiveError(error))
        }
    }
    
    private let logicController: TimeLineLogicController
    private let logoutAction: LogoutAction
    private let showLoaderAction: ShowLoaderAction
    private let showAlertAction: ShowAlertAction
    private let router: Router
    private let postDetailsCreator: PostDetailsCreator
    private let loginCreator: LoginCreator
    private let profileCreator: ProfileCreator
    
    init(logicController: TimeLineLogicController,
         logoutAction: LogoutAction,
         router: Router,
         postDetailsCreator: PostDetailsCreator,
         loginCreator: LoginCreator,
         showLoaderAction: ShowLoaderAction,
         showAlertAction: ShowAlertAction,
         profileCreator: ProfileCreator) {
        self.logicController = logicController
        self.router = router
        self.postDetailsCreator = postDetailsCreator
        self.loginCreator = loginCreator
        self.logoutAction = logoutAction
        self.showLoaderAction = showLoaderAction
        self.showAlertAction = showAlertAction
        self.profileCreator = profileCreator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Event {
        case onReceiveError(Error)
        case onReceivePosts([Post])
        case onReceiveSelectedPost(Post)
        case onSuccessfullyLogout
    }
    
    func handleEvent(event: Event) {
        showLoaderAction.hide(in: currentView)
        
        switch event {
        case let .onReceiveError(error):
            showAlertAction.show(
                title: "Error",
                message: "\(error)",
                cancel: nil,
                buttons: ["Ok"],
                action: nil,
                sender: self
            )
            
        case let .onReceivePosts(posts):
            if dataSource == nil {
                dataSource = TableViewDataSource(
                    models: posts,
                    reuseIdentifier: PostTableViewCell.identifier,
                    cellConfigurator: { [weak self] (model, cell) in
                        if let cell = cell as? PostTableViewCell {
                            cell.titleLabel.text = model.title
                            cell.contentLabel.text = model.content
                            cell.editIncon.isHidden = model.authorId != self?.logicController.userId
                        }
                })
                currentView.tableView.dataSource = dataSource
            } else {
                dataSource?.models = posts
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.currentView.finsishLoading()
                self?.currentView.tableView.reloadData()
            }
            
        case let .onReceiveSelectedPost(post):
            let postDetailsVC = postDetailsCreator.createPostDetailsScreen(
                with: router.window,
                screenType: .edit(post),
                delegate: self
            )
            router.push(postDetailsVC, from: self, animated: true)
            
        case .onSuccessfullyLogout:
            let vc = loginCreator.createLoginScreen(with: router.window)
            let navVC = UINavigationController(rootViewController: vc)
            router.changeRootView(navVC)
        }
    }
    
    // MARK: Func - override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Time Line"
        navigationItem.leftBarButtonItem = currentView.profileBarButton
        navigationItem.rightBarButtonItem = currentView.addBarButton
        currentView.actionDelegate = self
        currentView.tableView.delegate = self
        
        showLoaderAction.show(in: currentView)
        logicController.loadPosts(handler: receivePostsHandler)
    }
    
    // MARK: Private
    private func logout() {
        logoutAction.logout { [weak self] (result) in
            switch result {
            case .success:
                self?.handleEvent(event: .onSuccessfullyLogout)
                
            case let .failed(error):
                self?.handleEvent(event: .onReceiveError(error))
            }
        }
    }
    
    // MARK: TimeLineViewActionDelegate
    func handleAddBarButtonWasTapped() {
        if let userId = logicController.userId {
            let postDetailsVC = postDetailsCreator.createPostDetailsScreen(
                with: router.window,
                screenType: .createPost(author: userId),
                delegate: self
            )
            router.push(postDetailsVC, from: self, animated: true)
        }
    }
    
    func handleProfileBarButtonWasTapped() {
        let profileVC = profileCreator.createTimeLineScreen(
            with: router.window,
            logoutAction: logout
        )
        router.push(profileVC, from: self, animated: true)
    }
    
    func refreshControlWasTriggered() {
        didUpdatePost()
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedPost = dataSource?.models[indexPath.row],
            selectedPost.authorId == logicController.userId {
            handleEvent(event: .onReceiveSelectedPost(selectedPost))
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let postId = dataSource?.models[indexPath.row].id,
            let height = heights[postId] {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let postId = dataSource?.models[indexPath.row].id {
            heights[postId] = cell.frame.height
        }
    }
}

extension TimeLineViewController: PostDetailsViewDelegate {
    func didUpdatePost() {
        logicController.loadPosts(handler: receivePostsHandler)
    }
}
