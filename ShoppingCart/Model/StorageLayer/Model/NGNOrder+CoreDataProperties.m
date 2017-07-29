//
//  NGNOrder+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNOrder+CoreDataProperties.h"
#import "NGNUser+CoreDataProperties.h"
#import "NGNCommonConstants.h"

@implementation NGNOrder (CoreDataProperties)

+ (NSFetchRequest<NGNOrder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNOrder"];
}

@dynamic orderId;
@dynamic orderingDate;
@dynamic state;
@dynamic goodsOrders;
@dynamic user;

@end

@implementation NGNOrder (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    mapping.primaryKey = @"orderId";
    [mapping addAttributesFromArray:@[@"state"]];
    [mapping addAttributesFromDictionary:@{@"orderId": @"id"}];
    
    FEMMapping *userMapping = [[FEMMapping alloc] initWithEntityName:[NGNUser entity].name];
    userMapping.primaryKey = @"userId";
    [userMapping addAttributesFromDictionary:@{@"userId": @"user"}];
    
    [mapping addRelationshipMapping:userMapping forProperty:@"user" keyPath:nil];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en"]];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:NGNModelDateFormat];
    
    FEMAttribute *orderingDate = [[FEMAttribute alloc] initWithProperty:@"orderingDate" keyPath:@"orderingDate" map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [formatter dateFromString:value];
        }
        return nil;
    } reverseMap:^id(id value) {
        return [formatter stringFromDate:value];
    }];
    
    [mapping addAttribute:orderingDate];
    
    return mapping;
}

@end
