//
//  TimeLineView.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

@objc protocol TimeLineViewActionDelegate: class {
}

class TimeLineView: BaseView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public var actionDelegate: TimeLineViewActionDelegate?
    
    override func setupView() {
        super.setupView()
        
        addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0.0).isActive = true
        
        tableView.separatorStyle = .none
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
    }
}
