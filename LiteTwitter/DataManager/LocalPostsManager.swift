//
//  LocalPostsManager.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 1/13/19.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//

import LocalDataManager

let coreDataModelURL = Bundle.main.url(forResource: "LiteTwitterCoreDataModel", withExtension: "momd")!
var storeURL: URL = try! FileManager.default.url(
    for: FileManager.SearchPathDirectory.documentDirectory,
    in: FileManager.SearchPathDomainMask.userDomainMask,
    appropriateFor: nil,
    create: true).appendingPathComponent("db.sqlite", isDirectory: false)

let coreDataManager = CoreDataManagerWrapper(coreDataManager: CoreDataManager(
    store: storeURL,
    modelURL: coreDataModelURL)
)

protocol GetPostsLocalManager {
    func getPosts(handler: @escaping ((Result<[Post]>) -> ()) )
}

protocol PostPostsLocalManager {
    func postPosts(_ posts: [Post],
                   handler: @escaping ((Result<Bool>) -> ()) )
}

class CoreDataLocalPostsManagerProvider: GetPostsLocalManager, PostPostsLocalManager {
    
    let localDataManager: CoreDataManagerProtocol
    
    init(localDataManager: CoreDataManagerProtocol = coreDataManager) {
        self.localDataManager = localDataManager
    }
    
    func getPosts(handler: @escaping ((Result<[Post]>) -> ())) {
        handler(.success(localDataManager.getObjects(
            with: PostCoreDataModel.self,
            filter: NSPredicate(value: true)))
        )
    }
    
    func postPosts(_ posts: [Post],
                   handler: @escaping ((Result<Bool>) -> ())) {
        localDataManager.saveObjects(
            with: PostCoreDataModel.self,
            atrributesDictionary: posts.map{ $0.toDictionary() }) { (succeed, error) in
                if let error = error {
                    handler(.failed(error))
                } else {
                    handler(.success(succeed))
                }
        }
    }
}

extension Post {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "title": title,
            "content": content,
            "authorId": authorId
        ]
    }
}
