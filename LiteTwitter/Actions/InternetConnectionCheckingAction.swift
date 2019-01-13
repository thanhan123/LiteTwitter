//
//  InternetConnectionCheckingAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 1/5/19.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//

import Foundation
import Reachability

protocol InternetConnectionCheckingAction {
    func startChecking(reachable: @escaping () -> (),
                       unreachable: @escaping () -> ())
}

struct InternetConnectionCheckingActionProvider: InternetConnectionCheckingAction {
    
    func startChecking(reachable: @escaping () -> (),
                       unreachable: @escaping () -> ()) {
        let reachability = Reachability()!
        reachability.whenReachable = { _ in
            reachable()
            reachability.stopNotifier()
        }
        reachability.whenUnreachable = { _ in
            unreachable()
            reachability.stopNotifier()
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
