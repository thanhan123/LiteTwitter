//
//  CoreDataManager.h
//  Profile
//
//  Created by Dinh Thanh An on 31/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
NS_ASSUME_NONNULL_BEGIN

@interface CoreDataManager: NSObject

- (instancetype)initWithStoreURL: (NSURL*)storeURL modelURL:(NSURL*)modelURL;

- (NSArray *)getObjectsWithType:(id)type filter:(NSPredicate *)predicate;
- (void)saveObjectsWithType:(id)type atrributesDictionary:(NSArray<NSDictionary *> *)dicts;

@end

NS_ASSUME_NONNULL_END
