//
//  NGNOrderService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 25.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNOrderService.h"

@implementation NGNOrderService

- (void)fetchOrders:(void(^)(NSArray *orders))completitionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[NGNOrderEndpoint]
                                         completitionBlock:completitionBlock];
}

- (void)fetchOrderById:(NSString *)orderId
   completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[NGNOrderEndpoint, orderId]
                                             completitionBlock:completitionBlock];
}

- (void)addOrder:(NSDictionary *)order completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService addEntity:order pathElements:@[NGNOrderEndpoint] completitionBlock:completitionBlock];
}

- (void)updateOrder:(NSDictionary *)order
  completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService updateEntity:order
                       pathElements:@[NGNOrderEndpoint, [order[@"id"] stringValue]]
                  completitionBlock:completitionBlock];
}

- (void)deleteOrder:(NSDictionary *)order
  completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService deleteEntity:order
                       pathElements:@[NGNOrderEndpoint, [order[@"id"] stringValue]]
                  completitionBlock:completitionBlock];
}

@end
