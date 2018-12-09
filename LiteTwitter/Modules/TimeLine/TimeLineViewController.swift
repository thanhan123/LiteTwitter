//
//  TimeLineViewController.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/8/18.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

class TimeLineViewController: BaseViewController<TimeLineView>, TimeLineViewActionDelegate {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentView.actionDelegate = self
    }
    
    // MARK: TimeLineViewActionDelegate
    
}
