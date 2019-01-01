//
//  PostCoreDataModel+CoreDataProperties.swift
//  LiteTwitter
//
//  Created by Dinh Thanh An on 1/1/19.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//
//

import Foundation
import CoreData


extension PostCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCoreDataModel> {
        return NSFetchRequest<PostCoreDataModel>(entityName: "PostCoreDataModel")
    }

    @NSManaged public var title: String
    @NSManaged public var content: String
    @NSManaged public var id: String
    @NSManaged public var authorId: String

}

extension PostCoreDataModel: Post {}
