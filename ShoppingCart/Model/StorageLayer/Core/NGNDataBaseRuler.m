//
//  NGNDataBaseRuler.m
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNDataBaseRuler.h"
#import "NGNCommonConstants.h"

@interface NGNDataBaseRuler ()

@property (readwrite, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStorageName:(NSString *)storageName;

@end

@implementation NGNDataBaseRuler

#pragma mark - basic logic methods;
+ (instancetype)sharedInstance {
    static NGNDataBaseRuler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - core data support methods

+ (NSManagedObjectContext *)managedObjectContext {
    return [[self sharedInstance] managedObjectContext];
}

+ (void)setupCoreDataStackWithStorageName:(NSString *)storageName {
    NSPersistentStoreCoordinator *coordinator =  [[self sharedInstance] persistentStoreCoordinatorWithStorageName:storageName];
    if (coordinator != nil) {
        [[self sharedInstance] setManagedObjectContext:[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType]];
        [[[self sharedInstance] managedObjectContext] setPersistentStoreCoordinator:coordinator];
        [[[self sharedInstance] managedObjectContext] setMergePolicy:NSMergeByPropertyStoreTrumpMergePolicy];
    }
}

+ (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self.sharedInstance managedObjectContext];
    if([managedObjectContext hasChanges] &&
       ![managedObjectContext save:&error]){
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#warning do not use abort() in release!!! For debug only!!! Handle this error!!!
        abort();
    } else {
        [managedObjectContext refreshAllObjects];
    }
}

#pragma mark - core data handle helper methods

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:NGNModelAppName withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithStorageName:(NSString *)storageName {
    if(_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    if (!storageName) {
        storageName = NGNModelAppName;
    }
    NSString *fullStorageName = [NSString stringWithFormat:@"%@.sqlite", storageName];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:fullStorageName];
    NSError *error = nil;
    _persistentStoreCoordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:nil
                                                          error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
#warning do not use abort() in release!!! For debug only!!! Handle this error!!!
        abort();
    }
    return _persistentStoreCoordinator;
}

#pragma mark - additional helper methods

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end

@implementation NSManagedObject (NGNCreateUpdateDelete)

+ (NSManagedObject *)ngn_createEntityInManagedObjectContext:(NSManagedObjectContext *)context
                                    fieldsCompletitionBlock:(void(^)(NSManagedObject *object))fieldsCompletitionBlock {
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:[self entity].name
                                                            inManagedObjectContext:context];
//    [context insertObject:object];
    if (fieldsCompletitionBlock) {
        fieldsCompletitionBlock(object);
    }
    [NGNDataBaseRuler saveContext];
    return object;
}

+ (void)ngn_deleteEntityInManagedObjectContext:(NSManagedObjectContext *)context
                                 managedObject:(NSManagedObject *)object {
    NSArray *entities = [self ngn_allEntitiesInManagedObjectContext:context];
    if ([entities containsObject:object]) {
        [context deleteObject:object];
    }
    [NGNDataBaseRuler saveContext];
}

+ (NSArray *)ngn_allEntitiesInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[self entity].name];
    NSError *error = nil;
    NSArray *resultArray = [context executeFetchRequest:request error:&error];
    if (!resultArray) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
#warning do not use abort() in release!!! For debug only!!! Handle this error!!!
        abort();
    }
    return resultArray;
}

@end

@implementation NSJSONSerialization (NGNDifferentObjectsSerializationFromJSON)

+ (NSManagedObject *)ngn_serializeSingleObjectWithJSONData:(NSData *)data {
    NSError *error = nil;
    NSDictionary *objectPropertiesDictionary =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableContainers error:&error];
    if (!objectPropertiesDictionary) {
        NSLog(@"%@", error.userInfo);
#warning dont use abort in release!!! For debug only!
        abort();
    }
    NSManagedObject *object = [NSManagedObject ngn_createEntityInManagedObjectContext:[NGNDataBaseRuler managedObjectContext] fieldsCompletitionBlock:^(NSManagedObject *object){
        for (NSString *key in objectPropertiesDictionary.allKeys) {
            [object setValue:objectPropertiesDictionary[key] forKey:key];
        }
    }];
    return object;
}

@end
