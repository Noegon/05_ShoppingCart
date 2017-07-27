//
//  NGNCatalogService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCatalogService.h"
#import "NGNServerSideLayerConstants.h"
#import "NGNBasicService.h"

@interface NGNCatalogService()

@property (strong, nonatomic) NGNBasicService *basicService;

@end

@implementation NGNCatalogService

- (instancetype)init {
    if (self = [super init]) {
        _basicService = [[NGNBasicService alloc] init];
    }
    return self;
}

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

