//
//  NGNOrder+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNOrder+CoreDataProperties.h"
#import "NGNUser+CoreDataProperties.h"
#import "NGNGood+CoreDataProperties.h"
#import "NGNGoodsOrder+CoreDataProperties.h"
#import "NGNCommonConstants.h"

@implementation NGNOrder (CoreDataProperties)

+ (NSFetchRequest<NGNOrder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNOrder"];
}

@dynamic entityId;
@dynamic orderingDate;
@dynamic state;
@dynamic goodsOrders;
@dynamic user;

@end

@implementation NGNOrder (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    mapping.primaryKey = @"entityId";
    [mapping addAttributesFromArray:@[@"state"]];
    [mapping addAttributesFromDictionary:@{@"entityId": @"id"}];
    
    FEMMapping *userMapping = [[FEMMapping alloc] initWithEntityName:[NGNUser entity].name];
    userMapping.primaryKey = @"entityId";
    [userMapping addAttributesFromDictionary:@{@"entityId": @"user"}];
    
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

- (NSNumber *)totalOrderCost {
    double cost = 0;
    for (NGNGoodsOrder *goodOrder in self.goodsOrders) {
        NGNGood *currentGood = goodOrder.good;
        cost += [currentGood discountedCost].floatValue;
    }
    return @(cost);
}

@end
