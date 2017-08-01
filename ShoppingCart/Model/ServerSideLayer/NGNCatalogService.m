//
//  NGNCatalogService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCatalogService.h"

@implementation NGNCatalogService

#warning concurrency Testing method!!!
- (void)fetchPhonesTest:(void(^)(NSArray *phones))completitionBlock {
    
    NSMutableString *finalPath = [[NSString stringWithFormat:@"%@", NGNServerURL] mutableCopy];
    NSArray *resourcePathElements = @[NGNCatalogEndpoint];
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

