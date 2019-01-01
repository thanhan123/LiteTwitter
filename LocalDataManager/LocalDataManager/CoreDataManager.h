//
//  CoreDataManager.h
//  Profile
//
//  Created by Dinh Thanh An on 31/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "LocalDataManagerInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager : LocalDataManagerInterface

- (instancetype)initWithStoreURL: (NSURL*)storeURL modelURL:(NSURL*)modelURL;

@property (readonly) NSManagedObjectContext *managedObjectContext;

@end

NS_ASSUME_NONNULL_END
