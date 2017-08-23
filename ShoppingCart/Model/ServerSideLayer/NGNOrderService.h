//
//  NGNOrderService.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 25.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGNAbstractService.h"

@interface NGNOrderService : NGNAbstractService

- (void)fetchOrders:(void(^)(NSArray *orders))completitionBlock;
- (void)fetchOrderById:(NSString *)orderId
     completitionBlock:(void(^)(NSDictionary *order))completitionBlock;
- (void)addOrder:(NSDictionary *)order completitionBlock:(void(^)(NSDictionary *order))completitionBlock;
- (void)updateOrder:(NSDictionary *)order completitionBlock:(void(^)(NSDictionary *order))completitionBlock;
- (void)deleteOrder:(NSDictionary *)order completitionBlock:(void(^)(NSDictionary *order))completitionBlock;

@end
