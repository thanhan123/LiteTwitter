//
//  TimeLineView.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

protocol TimeLineViewActionDelegate: class {
    func handleAddBarButtonWasTapped()
    func handleProfileBarButtonWasTapped()
    func refreshControlWasTriggered()
}

class TimeLineView: BaseView {
    
    var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshControlWasTriggered), for: .valueChanged)
        return control
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        return barButton
    }()
    
    var profileBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Profile", style: .plain, target: nil, action: nil)
        return barButton
    }()
    
    public var actionDelegate: TimeLineViewActionDelegate?
    
    override func setupView() {
        super.setupView()
        
        addBarButton.target = self
        addBarButton.action = #selector(addButtonWasTapped)
        
        profileBarButton.target = self
        profileBarButton.action = #selector(profileButtonWasTapped)
        
        addSubview(tableView)
        
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.addSubview(refreshControl)
    }
    
    @objc func addButtonWasTapped() {
        actionDelegate?.handleAddBarButtonWasTapped()
    }
    
    @objc func profileButtonWasTapped() {
        actionDelegate?.handleProfileBarButtonWasTapped()
    }
    
    @objc func refreshControlWasTriggered() {
        actionDelegate?.refreshControlWasTriggered()
    }
    
    func finsishLoading() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}
