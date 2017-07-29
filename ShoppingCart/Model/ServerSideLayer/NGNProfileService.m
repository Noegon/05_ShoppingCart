//
//  NGNProfileService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNProfileService.h"

@implementation NGNProfileService

- (void)fetchUsers:(void(^)(NSArray *users))completitionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[NGNProfileEndpoint]
                                         completitionBlock:completitionBlock];
}

- (void)fetchUserById:(NSString *)userId completitionBlock:(void(^)(NSDictionary *user))completitionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[NGNProfileEndpoint, userId]
                                             completitionBlock:completitionBlock];
}

@end
