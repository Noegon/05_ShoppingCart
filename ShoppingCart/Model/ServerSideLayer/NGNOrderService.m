//
//  NGNOrderService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 25.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNOrderService.h"
#import "NGNServerSideLayerConstants.h"
#import "NGNBasicService.h"

@interface NGNOrderService()

@property (strong, nonatomic) NGNBasicService *basicService;

@end

@implementation NGNOrderService

- (instancetype)init {
    if (self = [super init]) {
        _basicService = [[NGNBasicService alloc] init];
    }
    return self;
}

- (void)fetchOrders:(void(^)(NSArray *orders))completitionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[NGNCatalogEndpoint]
                                         completitionBlock:completitionBlock];
}

- (void)fetchOrderById:(NSString *)orderId
   completitionHandler:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[NGNCatalogEndpoint, orderId]
                                             completitionBlock:completitionBlock];
}

- (void)addOrder:(NSDictionary *)order completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService addEntity:order pathElements:@[NGNOrderEndpoint] completitionBlock:completitionBlock];
}

- (void)updateOrder:(NSDictionary *)order completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    NSString *orderId = [order[@"id"] stringValue];
    [self.basicService updateEntity:order pathElements:@[NGNOrderEndpoint, orderId] completitionBlock:completitionBlock];
}

- (void)deleteOrder:(NSDictionary *)order completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    NSString *orderId = [order[@"id"] stringValue];
    [self.basicService deleteEntity:order pathElements:@[NGNOrderEndpoint, orderId] completitionBlock:completitionBlock];
}

@end
