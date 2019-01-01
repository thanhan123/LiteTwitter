//
//  LocalDataManagerInterface.m
//  LocalDataManager
//
//  Created by Dinh Thanh An on 1/1/19.
//  Copyright © 2019 Dinh Thanh An. All rights reserved.
//

#import "LocalDataManagerInterface.h"

@implementation LocalDataManagerInterface

- (NSArray *)getObjectsWithType:(id)type filter:(NSPredicate *)predicate {
    [NSException raise:@"InitNotImplemented" format:@"Subclasses must implement a valid init method"];
    return NULL;
}

@end
