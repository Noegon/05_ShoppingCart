//
//  NGNBasicService.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNBasicService.h"
#import "NGNServerSideLayerConstants.h"


@implementation NGNBasicService

- (NSURLSession *)createUrlSession {
    return [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (NSURL *)makeResourceURLWithServerUrl:(NSString *)servrerURL
                   resourcePathElements:(NSArray<NSString *>*)resourcePathElements {
    NSMutableString *finalPath = [[NSString stringWithFormat:@"%@", servrerURL] mutableCopy];
    for (NSString *element in resourcePathElements) {
        [finalPath appendString:element];
        if (![element containsString:@"/"]) {
            [finalPath appendString:@"/"];
        }
    }
    return [NSURL URLWithString:finalPath];
}

@end
