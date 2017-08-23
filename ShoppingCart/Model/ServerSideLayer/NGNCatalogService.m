//
//  NGNCatalogService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCatalogService.h"

@implementation NGNCatalogService

- (void)fetchPhones:(void(^)(NSArray *phones))completitionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[NGNCatalogEndpoint]
                                         completitionBlock:completitionBlock];
}

- (void)fetchPhoneById:(NSString *)phoneId
     completitionBlock:(void(^)(NSDictionary *phone))completitionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[NGNCatalogEndpoint, phoneId]
                                             completitionBlock:completitionBlock];
}

@end

