//
//  NSDate+NGNformattedDate.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 26.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NSDate+NGNformattedDate.h"
#import "NGNCommonConstants.h"

@implementation NSDate (NGNformattedDate)

+ (NSString *)ngn_formattedStringfiedDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    formatter.dateFormat = NGNModelDateFormat;
    return [formatter stringFromDate:date];
}

@end
