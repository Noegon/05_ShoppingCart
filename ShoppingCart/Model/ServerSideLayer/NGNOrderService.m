//
//  NGNOrderService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 25.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNOrderService.h"

@implementation NGNOrderService

#warning concurrency Testing method!!!
- (void)fetchOrdersTest:(void(^)(NSArray *orders))completitionBlock {
    
    NSMutableString *finalPath = [[NSString stringWithFormat:@"%@", NGNServerURL] mutableCopy];
    NSArray *resourcePathElements = @[NGNOrderEndpoint];
    for (id element in resourcePathElements) {
        NSString *stringfiedElement = nil;
        stringfiedElement = ![element isKindOfClass:NSString.class] ? [element stringValue] : element;
        [finalPath appendString:stringfiedElement];
        if (![stringfiedElement containsString:@"/"]) {
            [finalPath appendString:@"/"];
        }
    }
    NSURL *url = [NSURL URLWithString:finalPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = NGNHTTPMethodGET;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *entitiesTask =
        [session dataTaskWithRequest:request completionHandler:
         ^(NSData *data, NSURLResponse *response, NSError *error) {
            NSArray *entities = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (completitionBlock) {
                     completitionBlock(entities);
                 }
             });
         }];
    [entitiesTask resume];
}

- (void)fetchOrders:(void(^)(NSArray *orders))completitionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[NGNOrderEndpoint]
                                         completitionBlock:completitionBlock];
}

- (void)fetchOrderById:(NSString *)orderId
   completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[NGNOrderEndpoint, orderId]
                                             completitionBlock:completitionBlock];
}

- (void)addOrder:(NSDictionary *)order completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService addEntity:order pathElements:@[NGNOrderEndpoint] completitionBlock:completitionBlock];
}

- (void)updateOrder:(NSDictionary *)order
  completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService updateEntity:order
                       pathElements:@[NGNOrderEndpoint, [order[@"id"] stringValue]]
                  completitionBlock:completitionBlock];
}

- (void)deleteOrder:(NSDictionary *)order
  completitionBlock:(void(^)(NSDictionary *order))completitionBlock {
    [self.basicService deleteEntity:order
                       pathElements:@[NGNOrderEndpoint, [order[@"id"] stringValue]]
                  completitionBlock:completitionBlock];
}

@end
