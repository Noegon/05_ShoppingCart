//
//  NGNDataBaseLoader.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 29.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNServerDataLoader.h"
#import "NGNCommonConstants.h"
#import "NGNCoreDataEntitiesNames.h"
#import "NGNDataBaseRuler.h"
#import "NGNCoreDataObjects.h"
#import "NGNCatalogService.h"
#import "NGNOrderService.h"
#import "NGNProfileService.h"
#import "NGNGoodsOrderService.h"
#import "NGNReachability.h"

#import <CoreData/CoreData.h>
#import <FastEasyMapping/FastEasyMapping.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation NGNServerDataLoader

+ (void)loadDataFromServerWithContext:(NSManagedObjectContext *)context {
    NGNCatalogService *catalogService = [[NGNCatalogService alloc] init];
    NGNOrderService *orderService = [[NGNOrderService alloc] init];
    NGNGoodsOrderService *goodsOrderService = [[NGNGoodsOrderService alloc] init];
    NGNProfileService *profileService = [[NGNProfileService alloc] init];
   
    if ([self checkInternetStatus] && [self checkServerStatusWithHostName:NGNServerURL]) {
        
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t myQueue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
        
        //declare uniting async thread in global queue (will be automatically separated to different threads by system)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            //1-st grouped thread
            //increase counter of group
            dispatch_group_enter(group);
            [profileService fetchUserById:@"1" completitionBlock:^(NSDictionary *user) {
                //starting this block in different thread
                dispatch_group_async(group, myQueue, ^{
                    FEMMapping *userMapping = [NGNUser defaultMapping];
                    NSDictionary *usersResult = [FEMDeserializer objectFromRepresentation:user
                                                                                  mapping:userMapping
                                                                                  context:context];
                    if (!usersResult) {
                        NSLog(@"%@", @"user wasn't loaded");
                    } else {
                        NSLog(@"%@", @"user was loaded successfully");
                    }
                    // no one of this group threads will start before counter will redused to 0
                    dispatch_group_leave(group);
                });
            }];
            //waiting for reducing group counter to 0
            dispatch_wait(group, DISPATCH_TIME_FOREVER);
            
            //2-nd grouped thread
            dispatch_group_enter(group);
            [catalogService fetchPhones:^(NSArray *phones) {
                dispatch_group_async(group, myQueue, ^{
                    FEMMapping *phonesMapping = [NGNGood defaultMapping];
                    NSArray *phonesResult = [FEMDeserializer collectionFromRepresentation:phones
                                                                                  mapping:phonesMapping
                                                                                  context:context];
                    if (!phonesResult) {
                        NSLog(@"%@", @"goods catalog wasn't loaded");
                    } else {
                        NSLog(@"%@", @"goods was loaded successfully");
                    }
                    dispatch_group_leave(group);
                });
            }];
            
            dispatch_wait(group, DISPATCH_TIME_FOREVER);
            
            //3-rd grouped thread
            dispatch_group_enter(group);
            [goodsOrderService fetchGoodsOrders:^(NSArray *goodsOrders) {
                dispatch_group_async(group, myQueue, ^{
                    FEMMapping *goodsOrderMapping = [NGNGoodsOrder defaultMapping];
                    NSArray *goodsOrdersResult = [FEMDeserializer collectionFromRepresentation:goodsOrders
                                                                                       mapping:goodsOrderMapping
                                                                                       context:context];
                    if (!goodsOrdersResult) {
                        NSLog(@"%@", @"goodsOrders wasn't loaded");
                    } else {
                        NSLog(@"%@", @"goodsOrders was loaded successfully");
                    }
                    dispatch_group_leave(group);
                });
            }];
            
            //4-th grouped thread
            dispatch_group_enter(group);
            [orderService fetchOrders:^(NSArray *orders) {
                dispatch_group_async(group, myQueue, ^{
                    FEMMapping *orderMapping = [NGNOrder defaultMapping];
                    NSArray *ordersResult = [FEMDeserializer collectionFromRepresentation:orders
                                                                                  mapping:orderMapping
                                                                                  context:context];
                    if (!ordersResult) {
                        NSLog(@"%@", @"ordersResult wasn't loaded");
                    } else {
                        [self checkCartExistingInManagedObjectContext:context];
                        NSLog(@"%@", @"orders was loaded successfully");
                    }
                    dispatch_group_leave(group);
                });
            }];
            //end of concurrent grouped threads
            [NGNDataBaseRuler saveContext];
            
            
            NSNotification *notification =
            [NSNotification notificationWithName:NGNControllerNotificationDataWasLoaded
                                          object:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            NSLog(@"%@", @"server data was loaded successfully");
        });
    }
}

+ (void)checkCartExistingInManagedObjectContext:(NSManagedObjectContext *)context {
    NGNOrderService *orderService = [[NGNOrderService alloc] init];
    NSArray<NGNOrder *> *orders = [context executeFetchRequest:[NGNOrder fetchRequest] error:nil];
    if (orders) {
        NSIndexSet *cartIndexes = [orders indexesOfObjectsPassingTest:^BOOL(NGNOrder *obj, NSUInteger idx, BOOL *stop) {
            return obj.state.integerValue == NGNOrderInCart;
        }];
        if (cartIndexes.count == 0) {
            NGNOrder *cart = [NGNOrder ngn_createEntityInManagedObjectContext:context
                                                      fieldsCompletitionBlock:^(NSManagedObject* order){
                                                          ((NGNOrder *)order).entityId = @foo4random();
                                                          ((NGNOrder *)order).state = @(NGNOrderInCart);
                                                          ((NGNOrder *)order).user =
                                                          [NGNUser ngn_allEntitiesInManagedObjectContext:context].firstObject;
                                                          ((NGNOrder *)order).orderingDate = [NSDate date];
                                                      }];
            FEMMapping *orderMapping = [NGNOrder defaultMapping];
            NSDictionary *entityAsDictionary = [FEMSerializer serializeObject:cart usingMapping:orderMapping];
            [orderService addOrder:entityAsDictionary completitionBlock:^(NSDictionary *order){}];
        }
    }
}

+ (BOOL)checkServerStatusWithHostName:(NSString *)hostName {
    NGNReachability* hostReachable = [NGNReachability reachabilityWithHostName:hostName];
    // called after network status changes
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus) {
        case NotReachable: {
            NSLog(@"A gateway to the host server is down.");
            return NO;
        }
        case ReachableViaWiFi: {
            NSLog(@"A gateway to the host server is working via WIFI.");
            return YES;
        }
        case ReachableViaWWAN: {
            NSLog(@"A gateway to the host server is working via WWAN.");
            return YES;
        }
    }
}

+ (BOOL)checkInternetStatus {
    NGNReachability* internetReachable = [NGNReachability reachabilityForInternetConnection];
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable: {
            NSLog(@"The internet is down.");
            return NO;
        }
        case ReachableViaWiFi: {
            NSLog(@"The internet is working via WIFI.");
            return YES;
        }
        case ReachableViaWWAN: {
            NSLog(@"The internet is working via WWAN.");
            return YES;
        }
    }
}

@end
