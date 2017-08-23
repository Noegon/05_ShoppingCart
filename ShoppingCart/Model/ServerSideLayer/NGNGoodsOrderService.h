//
//  NGNGoodsOrderService.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGNAbstractService.h"

@interface NGNGoodsOrderService : NGNAbstractService

- (void)fetchGoodsOrders:(void(^)(NSArray *goodsOrders))completitionBlock;
- (void)fetchGoodsOrderById:(NSString *)goodOrderId
     completitionBlock:(void(^)(NSDictionary *goodsOrder))completitionBlock;
- (void)addGoodsOrder:(NSDictionary *)goodsOrder completitionBlock:(void(^)(NSDictionary *goodsOrder))completitionBlock;
- (void)updateGoodsOrder:(NSDictionary *)goodsOrder completitionBlock:(void(^)(NSDictionary *goodsOrder))completitionBlock;
- (void)deleteGoodsOrder:(NSDictionary *)goodsOrder completitionBlock:(void(^)(NSDictionary *goodsOrder))completitionBlock;

@end
