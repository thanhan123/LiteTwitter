//
//  DeletePostAction.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 12/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

import Foundation

protocol DeletePostAction {
    var deletePostManager: DeletePostManager { get set }
    func deletePost(id: String, handler: @escaping ((Result<Bool>) -> ()))
}

class DeletePostActionProvider: DeletePostAction {
    var deletePostManager: DeletePostManager
    
    init(deletePostManager: DeletePostManager) {
        self.deletePostManager = deletePostManager
    }
    
    func deletePost(id: String, handler: @escaping ((Result<Bool>) -> ())) {
        deletePostManager.deletePost(id: id) { (result) in
            switch result {
            case .success:
                handler(.success(true))
                
            case let .failed(error):
                handler(.failed(error))
            }
        }
    }
}
