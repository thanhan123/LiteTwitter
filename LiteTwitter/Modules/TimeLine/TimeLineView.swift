//
//  TimeLineView.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

@objc protocol TimeLineViewActionDelegate: class {
    func handleAddBarButtonWasTapped()
    func handleLogoutBarButtonWasTapped()
}

class TimeLineView: BaseView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        return barButton
    }()
    
    var logoutBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Logout", style: .plain, target: nil, action: nil)
        return barButton
    }()
    
    public var actionDelegate: TimeLineViewActionDelegate?
    
    override func setupView() {
        super.setupView()
        
        addBarButton.target = self
        addBarButton.action = #selector(addButtonWasTapped)
        
        logoutBarButton.target = self
        logoutBarButton.action = #selector(logoutButtonWasTapped)
        
        addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
    @objc func addButtonWasTapped() {
        actionDelegate?.handleAddBarButtonWasTapped()
    }
    
    @objc func logoutButtonWasTapped() {
        actionDelegate?.handleLogoutBarButtonWasTapped()
    }
}
