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
        
        dispatch_semaphore_t mySemaphore = dispatch_semaphore_create(4);
        
        dispatch_queue_attr_t myAttribute = dispatch_queue_attr_make_with_qos_class(nil, QOS_CLASS_USER_INITIATED, DISPATCH_QUEUE_PRIORITY_DEFAULT);
        dispatch_queue_t myQueue = dispatch_queue_create("myQueue", myAttribute);
        

        dispatch_async(myQueue, ^{
            
            [profileService fetchUserById:@"1" completitionBlock:^(NSDictionary *user) {
                FEMMapping *userMapping = [NGNUser defaultMapping];
                NSDictionary *usersResult = [FEMDeserializer objectFromRepresentation:user
                                                                              mapping:userMapping
                                                                              context:context];
                if (!usersResult) {
                    NSLog(@"%@", @"user wasn't loaded");
                } else {
                    NSLog(@"%@", @"user was loaded successfully");
                }
                
                dispatch_semaphore_signal(mySemaphore);
            }];

            dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
            
            [catalogService fetchPhones:^(NSArray *phones) {
                FEMMapping *phonesMapping = [NGNGood defaultMapping];
                NSArray *phonesResult = [FEMDeserializer collectionFromRepresentation:phones
                                                                              mapping:phonesMapping
                                                                              context:context];
                if (!phonesResult) {
                    NSLog(@"%@", @"goods catalog wasn't loaded");
                } else {
                    NSLog(@"%@", @"goods was loaded successfully");
                }
                dispatch_semaphore_signal(mySemaphore);
            }];
            
            dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
            
            [goodsOrderService fetchGoodsOrders:^(NSArray *goodsOrders) {
                FEMMapping *goodsOrderMapping = [NGNGoodsOrder defaultMapping];
                NSArray *goodsOrdersResult = [FEMDeserializer collectionFromRepresentation:goodsOrders
                                                                                   mapping:goodsOrderMapping
                                                                                   context:context];
                if (!goodsOrdersResult) {
                    NSLog(@"%@", @"goodsOrders wasn't loaded");
                } else {
                    NSLog(@"%@", @"goodsOrders was loaded successfully");
                }
                dispatch_semaphore_signal(mySemaphore);
            }];
            
            dispatch_semaphore_wait(mySemaphore, DISPATCH_TIME_FOREVER);
            
            [orderService fetchOrders:^(NSArray *orders) {
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
                dispatch_semaphore_signal(mySemaphore);
            }];
            
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
