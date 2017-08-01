//
//  NGNCatalogService.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGNAbstractService.h"

@interface NGNCatalogService : NGNAbstractService

#warning concurrency Testing method!!!
- (void)fetchPhonesTest:(void(^)(NSArray *phones))completitionBlock;

- (void)fetchPhones:(void(^)(NSArray *phones))completitionBlock;
- (void)fetchPhoneById:(NSString *)phoneId completitionBlock:(void(^)(NSDictionary *phone))completitionBlock;

@end
