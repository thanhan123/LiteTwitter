//
//  CoreDataManagerWrapper.swift
//  LocalDataManager
//
//  Created by Dinh Thanh An on 1/5/19.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//

import CoreData

public protocol CoreDataManagerProtocol {
    func getObjects<T: NSManagedObject>(with type: T.Type, filter: NSPredicate) -> [T]
    func saveObjects<T: NSManagedObject>(with type: T.Type, atrributesDictionary: [[String: Any]], handler: (Bool, Error?) -> ())
}

public final class CoreDataManagerWrapper: CoreDataManagerProtocol {
    
    let coreDataManager: CoreDataManager
    
    public init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    public func getObjects<T>(with type: T.Type, filter: NSPredicate) -> [T] where T : NSManagedObject {
        return coreDataManager.getObjectsWithType(type, filter: filter) as! [T]
    }
    
    public func saveObjects<T>(with type: T.Type,
                               atrributesDictionary: [[String : Any]],
                               handler: (Bool, Error?) -> ()) where T : NSManagedObject {
        coreDataManager.saveObjects(withType: type, atrributesDictionary: atrributesDictionary)
        handler(true, nil)
    }
}
