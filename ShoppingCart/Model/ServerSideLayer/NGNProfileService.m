//
//  NGNProfileService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 28.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNProfileService.h"

@implementation NGNProfileService

#warning concurrency Testing method!!!
- (void)fetchUsersTest:(void(^)(NSArray *users))completitionBlock {
    
    NSMutableString *finalPath = [[NSString stringWithFormat:@"%@", NGNServerURL] mutableCopy];
    NSArray *resourcePathElements = @[NGNProfileEndpoint];
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

- (void)fetchUsers:(void(^)(NSArray *users))completitionBlock {
    [self.basicService fetchEntitiesWithEntityPathElements:@[NGNProfileEndpoint]
                                         completitionBlock:completitionBlock];
}

- (void)fetchUserById:(NSString *)userId completitionBlock:(void(^)(NSDictionary *user))completitionBlock {
    [self.basicService fetchSingleEntityWithEntityPathElements:@[NGNProfileEndpoint, userId]
                                             completitionBlock:completitionBlock];
}

@end
