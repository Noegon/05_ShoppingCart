//
//  NGNCatalogService.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGNBasicService.h"

@interface NGNCatalogService : NGNBasicService

- (void)fetchPhones:(void(^)(NSArray *phones))completitionBlock;
- (void)fetchPhoneById:(NSString *)phoneId completitionHandler:(void(^)(NSDictionary *phone))completitionBlock;

@end
