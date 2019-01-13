//
//  CoreDataManager.m
//  Profile
//
//  Created by Dinh Thanh An on 31/12/2018.
//  Copyright © 2018 Dinh Thanh An. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>

@interface CoreDataManager()
@property (readwrite) NSManagedObjectContext *managedObjectContext;
@property NSURL *modelURL;
@property NSURL *storeURL;
@end

@implementation CoreDataManager

- (instancetype)initWithStoreURL: (NSURL*)storeURL modelURL:(NSURL*)modelURL {
    self = [super init];
    if (self) {
        self.modelURL = modelURL;
        self.storeURL = storeURL;
        [self setupManagedObjectContext];
    }
    return self;
}

- (void)setupManagedObjectContext {
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError* error;
    [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                       configuration:nil
                                                                                 URL:self.storeURL
                                                                             options:nil
                                                                               error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
    [self.managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
}

- (NSManagedObjectModel*)managedObjectModel
{
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

- (NSArray *)getObjectsWithType:(id)type filter:(NSPredicate *)predicate {
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(type)];
    request.predicate = predicate;
    return [self.managedObjectContext executeFetchRequest:request error:NULL];
}

- (void)saveObjectsWithType:(id)type atrributesDictionary:(NSArray<NSDictionary *> *)dicts {
    for (int i = 0; i < dicts.count; i++) {
        id item = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(type)
                                                inManagedObjectContext:self.managedObjectContext];
        NSDictionary *dict = dicts[i];
        [self setAttributes:dict for:item];
    }
    
    [self.managedObjectContext save:NULL];
}

- (void)setAttributes:(NSDictionary *)attr for:(id)object {
    NSArray *allKeys = [attr allKeys];
    for (int j = 0; j < allKeys.count; j++) {
        id key = allKeys[j];
        [object setValue:[attr valueForKey:key] forKey:key];
    }
}

- (void)updateObjectsWithType:(id)type atrributesDictionary:(NSArray<NSDictionary *> *)dicts filter:(NSPredicate *)predicate {
    NSManagedObject* objects = [self getObjectsWithType:type filter:predicate];
    [self.managedObjectContext save:NULL];
}

@end
