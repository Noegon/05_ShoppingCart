//
//  NGNGoodsOrderService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNGoodsOrderService.h"

@implementation NGNGoodsOrderService

- (void)fetchGoodsOrders:(void(^)(NSArray *goodsOrders))completitionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[NGNGoodsOrderEndpoint]
                                         completitionBlock:completitionBlock];
}

- (void)fetchGoodsOrderById:(NSString *)goodOrderId
          completitionBlock:(void(^)(NSDictionary *goodsOrder))completitionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[NGNGoodsOrderEndpoint, goodOrderId]
                                             completitionBlock:completitionBlock];
}

- (void)addGoodsOrder:(NSDictionary *)goodsOrder
    completitionBlock:(void(^)(NSDictionary *goodsOrder))completitionBlock {
    [self.basicService addEntity:goodsOrder
                    pathElements:@[NGNGoodsOrderEndpoint]
               completitionBlock:completitionBlock];
}

- (void)updateGoodsOrder:(NSDictionary *)goodsOrder
       completitionBlock:(void(^)(NSDictionary *goodsOrder))completitionBlock {
    [self.basicService updateEntity:goodsOrder
                       pathElements:@[NGNOrderEndpoint, [goodsOrder[@"id"] stringValue]]
                  completitionBlock:completitionBlock];
}

- (void)deleteGoodsOrder:(NSDictionary *)goodsOrder
       completitionBlock:(void(^)(NSDictionary *goodsOrder))completitionBlock {
    [self.basicService deleteEntity:goodsOrder
                       pathElements:@[NGNOrderEndpoint, [goodsOrder[@"id"] stringValue]]
                  completitionBlock:completitionBlock];
}

@end
