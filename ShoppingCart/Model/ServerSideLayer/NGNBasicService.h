//
//  NGNBasicService.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 24.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGNBasicService : NSObject

- (NSURLSession *)createUrlSession;
- (NSURL *)makeResourceURLWithServerUrl:(NSString *)servrerURL
                   resourcePathElements:(NSArray<NSString *>*)resourcePathElements;

@end
