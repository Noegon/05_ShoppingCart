//
//  AppDelegate.m
//  ShoppingCart
//
//  Created by Alex on 18.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "AppDelegate.h"
#import "NGNCommonConstants.h"
#import "NGNCoreDataEntitiesNames.h"
#import "NGNDataBaseRuler.h"
#import "NGNCoreDataObjects.h"
#import "NGNCatalogService.h"
#import "NGNOrderService.h"
#import "NGNProfileService.h"
#import "NGNGoodsOrderService.h"

#import <FastEasyMapping/FastEasyMapping.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#warning delete datasource for debug
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                                   inDomains:NSUserDomainMask] lastObject];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"ShoppingCart.sqlite"];
    [manager removeItemAtURL:storeURL error:nil];

    [NGNDataBaseRuler setupCoreDataStackWithStorageName:NGNModelAppName];
    
    NGNCatalogService *catalogService = [[NGNCatalogService alloc] init];
    NGNOrderService *orderService = [[NGNOrderService alloc] init];
    NGNGoodsOrderService *goodsOrderService = [[NGNGoodsOrderService alloc] init];
    NGNProfileService *profileService = [[NGNProfileService alloc] init];
    
    [orderService fetchOrders:^(NSArray *orders) {
        [goodsOrderService fetchGoodsOrders:^(NSArray *goodsOrders) {
            [catalogService fetchPhones:^(NSArray *phones) {
                [profileService fetchUsers:^(NSArray *users) {
                    
                    FEMMapping *userMapping = [NGNUser defaultMapping];
                    NSArray *usersResult = [FEMDeserializer collectionFromRepresentation:users
                                                                                 mapping:userMapping
                                                                                 context:[NGNDataBaseRuler managedObjectContext]];
//                    NSLog(@"%@", usersResult);
                    
                    FEMMapping *phonesMapping = [NGNGood defaultMapping];
                    NSArray *phonesResult = [FEMDeserializer collectionFromRepresentation:phones
                                                                                  mapping:phonesMapping
                                                                                  context:[NGNDataBaseRuler managedObjectContext]];
                    
//                    NSLog(@"%@", phonesResult);
                    
                    FEMMapping *goodsOrderMapping = [NGNGoodsOrder defaultMapping];
                    NSArray *goodsOrdersResult = [FEMDeserializer collectionFromRepresentation:goodsOrders
                                                                                       mapping:goodsOrderMapping
                                                                                       context:[NGNDataBaseRuler managedObjectContext]];
//                    NSLog(@"%@", goodsOrdersResult);
                    
                    FEMMapping *orderMapping = [NGNOrder defaultMapping];
                    NSArray *ordersResult = [FEMDeserializer collectionFromRepresentation:orders
                                                                                  mapping:orderMapping
                                                                                  context:[NGNDataBaseRuler managedObjectContext]];
                    
                    NSLog(@"%@", [ordersResult[0] valueForKey:@"user"]);
                    NSLog(@"%@", ordersResult[0]);
                    
//                    NSArray *usersTest = [[NGNDataBaseRuler managedObjectContext] executeFetchRequest:[NGNUser fetchRequest] error:nil];
//                    NSLog(@"%@", usersTest);
                    
//                    NSArray *phonesTest = [[NGNDataBaseRuler managedObjectContext]
//                                           executeFetchRequest:[NGNGood fetchRequest] error:nil];
//                    NSLog(@"%@", phonesTest);
                    
//                    NSArray *ordersTest = [[NGNDataBaseRuler managedObjectContext]
//                                           executeFetchRequest:[NGNOrder fetchRequest] error:nil];
//                    NSLog(@"%@", ordersTest[1]);
                    
//                    NSArray *goodsOrdersTest = [[NGNDataBaseRuler managedObjectContext]
//                                           executeFetchRequest:[NGNGoodsOrder fetchRequest] error:nil];
//                    NSLog(@"%@", goodsOrdersTest);
                }];
            }];
        }];
    }];

    
//    [catalogService fetchPhones:^(NSArray *phones) {
//        FEMMapping *phonesMapping = [NGNGood defaultMapping];
//        NSArray *phonesResult = [FEMDeserializer collectionFromRepresentation:phones
//                                                                      mapping:phonesMapping
//                                                                      context:[NGNDataBaseRuler managedObjectContext]];
//        NSLog(@"%@", phonesResult);
//    }];
    

    
    
    
//    [orderService fetchOrders:^(NSArray *orders) {
//        
//        FEMMapping *orderMapping = [NGNOrder defaultMapping];
//        NSArray *ordersResult = [FEMDeserializer collectionFromRepresentation:orders
//                                                                      mapping:orderMapping
//                                                                      context:[NGNDataBaseRuler managedObjectContext]];
//        NSLog(@"%@", ordersResult[0]);
//    }];

//    NSManagedObjectContext *context = [NGNDataBaseRuler managedObjectContext];
//    NGNUser *user1 = (NGNUser *)[NGNUser ngn_createEntityInManagedObjectContext:context];
//    user1.name = @"Alex";
//    [NGNDataBaseRuler saveContext];
//    NSLog(@"%@", user1.name);
//    NGNUser *user2 = (NGNUser *)[NGNUser ngn_createEntityInManagedObjectContext:context];
//    user2.name = @"Tanya";
//    [NGNDataBaseRuler saveContext];
//    NSLog(@"%@", user2.name);
//    NSArray *allUsers = [NGNUser ngn_allEntitiesInManagedObjectContext:context];
//    NSLog(@"%@", ((NGNUser *)allUsers[0]).name);
//    NSLog(@"%@", ((NGNUser *)allUsers[1]).name);
//    NGNUser *testUser = ((NGNUser *)allUsers[0]);
//    testUser.name = @"Beckket";
//    [NGNDataBaseRuler saveContext];
//    allUsers = [NGNUser ngn_allEntitiesInManagedObjectContext:context];
//    NSLog(@"%@", ((NGNUser *)allUsers[0]).name);
//    [NGNUser ngn_deleteEntityInManagedObjectContext:context managedObject:testUser];
//    allUsers = [NGNUser ngn_allEntitiesInManagedObjectContext:context];
//    NSLog(@"%ld", allUsers.count);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ShoppingCart"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
