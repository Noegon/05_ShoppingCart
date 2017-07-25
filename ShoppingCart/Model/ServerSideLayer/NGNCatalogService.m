//
//  NGNCatalogService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCatalogService.h"
#import "NGNServerSideLayerConstants.h"

@implementation NGNCatalogService

- (void)executeCompletitionBlock:(void(^)(id object))completitionBlock object:(id)object{
    dispatch_async(dispatch_get_main_queue(), ^() {
        if (completitionBlock) {
            completitionBlock(object);
        }
    });
}

- (void)fetchPhones:(void(^)(NSArray *phones))completitionBlock {
    NSURL *url = [self makeResourceURLWithServerUrl:NGNServerURL
                               resourcePathElements:@[NGNCatalogEndpoint]];
    [[[self createUrlSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:
     ^(NSData *data, NSURLResponse *response, NSError *error) {
         NSArray *phones = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
         [self executeCompletitionBlock:completitionBlock object:phones];
    }] resume];
}

- (void)fetchPhoneById:(NSString *)phoneId completitionHandler:(void(^)(NSDictionary *phone))completitionBlock {
    NSURL *url = [self makeResourceURLWithServerUrl:NGNServerURL
                               resourcePathElements:@[NGNCatalogEndpoint, phoneId]];
    [[[self createUrlSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:
      ^(NSData *data, NSURLResponse *response, NSError *error) {
          NSDictionary *phone = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
          [self executeCompletitionBlock:completitionBlock object:phone];
      }] resume];
}

@end

