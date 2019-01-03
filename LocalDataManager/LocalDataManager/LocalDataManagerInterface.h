//
//  LocalDataManagerInterface.h
//  LocalDataManager
//
//  Created by Dinh Thanh An on 1/1/19.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalDataManagerInterface<__covariant ObjectType> : NSObject

- (NSArray<ObjectType>*)getObjectsWithType:(Class)type filter:(NSPredicate*)predicate;
- (void)saveObjectWithType:(Class)type atrributesDictionary:(nullable NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
