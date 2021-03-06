//
//  NGNProfileService.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNAbstractService.h"

@interface NGNProfileService : NGNAbstractService

- (void)fetchUsers:(void(^)(NSArray *users))completitionBlock;
- (void)fetchUserById:(NSString *)userId completitionBlock:(void(^)(NSDictionary *user))completitionBlock;

@end
