//
//  TimeLineViewController.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

class TimeLineViewController: BaseViewController<TimeLineView>, TimeLineViewActionDelegate, UITableViewDelegate {
    var dataSource: TableViewDataSource<Post>?
    
    let getPostsAction: GetPostsAction
    let getCurrentUserAction: GetCurrentUserAction
    let router: Router
    let postDetailsCreator: PostDetailsCreator
    
    init(getPostsAction: GetPostsAction,
         getCurrentUserAction: GetCurrentUserAction,
         router: Router,
         postDetailsCreator: PostDetailsCreator) {
        self.getPostsAction = getPostsAction
        self.getCurrentUserAction = getCurrentUserAction
        self.router = router
        self.postDetailsCreator = postDetailsCreator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum State {
        case onReceiveError(Error)
        case onReceiveUser(User)
        case onReceivePosts([Post])
        case onReceiveSelectedPost(Post)
    }
    
    func handleState(state: State) {
        switch state {
        case let .onReceiveError(error):
            print(error)
            
        case let .onReceiveUser(user):
            getPostsAction.getPosts(for: user.id, handler: { (posts) in
                
            })
            
        case let .onReceivePosts(posts):
            dataSource = TableViewDataSource(
                models: posts,
                reuseIdentifier: "reuseIdentifier",
                cellConfigurator: { (model, cell) in
                    cell.textLabel?.text = model.title
                    cell.detailTextLabel?.text = model.content
            })
            currentView.tableView.dataSource = dataSource
            
        case let .onReceiveSelectedPost(post):
            let postDetailsVC = postDetailsCreator.createPostDetailsScreen(with: router.window, post: post)
            router.push(postDetailsVC, from: self, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentView.actionDelegate = self
        currentView.tableView.delegate = self
        getCurrentUserAction.getCurrentUser { [weak self] (result) in
            switch result {
            case let .success(user):
                self?.handleState(state: .onReceiveUser(user))
                
            case let .failed(error):
                self?.handleState(state: .onReceiveError(error))
            }
        }
    }
    
    // MARK: TimeLineViewActionDelegate
    //
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedPost = dataSource?.models[indexPath.row] {
            handleState(state: .onReceiveSelectedPost(selectedPost))
        }
    }
}
