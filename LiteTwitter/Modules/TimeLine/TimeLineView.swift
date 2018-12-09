//
//  TimeLineView.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import UIKit

@objc protocol TimeLineViewActionDelegate: AnyObject {
}

class TimeLineView: BaseView {
    
    var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    public var actionDelegate: TimeLineViewActionDelegate?
    
    override func setupView() {
        super.setupView()
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
