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

#import <CoreData/CoreData.h>
#import <FastEasyMapping/FastEasyMapping.h>

@implementation NGNServerDataLoader

/**Returns was loading dada from DBServer successfull*/
+ (void)loadDataFromServerWithContext:(NSManagedObjectContext *)context {
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
                                                                                 context:context];
                    
                    if (!usersResult) {
                        NSLog(@"%@", @"user wasn't loaded");
                    }
                    
                    FEMMapping *phonesMapping = [NGNGood defaultMapping];
                    NSArray *phonesResult = [FEMDeserializer collectionFromRepresentation:phones
                                                                                  mapping:phonesMapping
                                                                                  context:context];
                    if (!phonesResult) {
                        NSLog(@"%@", @"goods catalog wasn't loaded");
                    }
                    
                    FEMMapping *goodsOrderMapping = [NGNGoodsOrder defaultMapping];
                    NSArray *goodsOrdersResult = [FEMDeserializer collectionFromRepresentation:goodsOrders
                                                                                       mapping:goodsOrderMapping
                                                                                       context:context];
                    if (!goodsOrdersResult) {
                        NSLog(@"%@", @"goodsOrders wasn't loaded");
                    }
                    
                    FEMMapping *orderMapping = [NGNOrder defaultMapping];
                    NSArray *ordersResult = [FEMDeserializer collectionFromRepresentation:orders
                                                                                  mapping:orderMapping
                                                                                  context:context];
                    if (!ordersResult) {
                        NSLog(@"%@", @"ordersResult wasn't loaded");
                    }
                    
                    NSNotification *notification =
                        [NSNotification notificationWithName:NGNControllerNotificationDataWasLoaded
                                                      object:nil];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                }];
            }];
        }];
    }];
}

@end
