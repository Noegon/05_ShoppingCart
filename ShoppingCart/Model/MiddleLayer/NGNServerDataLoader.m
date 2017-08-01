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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_group_enter(group);
            [profileService fetchUserById:@"1" completitionBlock:^(NSDictionary *user) {
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
                    dispatch_group_leave(group);
                });
            }];
            
            dispatch_wait(group, DISPATCH_TIME_FOREVER);
            
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
                        NSLog(@"%@", @"orders was loaded successfully");
                    }
                    dispatch_group_leave(group);
                });
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