//
//  NGNDataBaseRuler.h
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NGNDataBaseRuler : NSObject

+ (NSManagedObjectContext *) managedObjectContext;
+ (void)setupCoreDataStackWithStorageName:(NSString *)storageName;
+ (void)saveContext;

@end

@interface NSManagedObject (NGNCreateUpdateDelete)

+ (NSManagedObject *)ngn_createEntityInManagedObjectContext:(NSManagedObjectContext *)context
                                    fieldsCompletitionBlock:(void(^)(NSManagedObject *object))fieldsCompletitionBlock;
+ (void)ngn_deleteEntityInManagedObjectContext:(NSManagedObjectContext *)context
                                 managedObject:(NSManagedObject *)object;
+ (NSArray *)ngn_allEntitiesInManagedObjectContext:(NSManagedObjectContext *)context;

@end

@interface NSJSONSerialization (NGNDifferentObjectsSerializationFromJSON)

+ (NSManagedObject *)ngn_serializeSingleObjectWithJSONData:(NSData *)data;

@end
