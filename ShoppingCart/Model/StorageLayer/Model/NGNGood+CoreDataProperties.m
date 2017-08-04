//
//  NGNGood+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNGood+CoreDataProperties.h"

@implementation NGNGood (CoreDataProperties)

+ (NSFetchRequest<NGNGood *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNGood"];
}

@dynamic avialable;
@dynamic discount;
@dynamic entityId;
@dynamic image;
@dynamic name;
@dynamic price;
@dynamic goodsOrders;

@end

@implementation NGNGood (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"avialable", @"price", @"discount", @"name", @"image"]];
    [mapping addAttributesFromDictionary:@{@"entityId": @"id"}];
    mapping.primaryKey = @"entityId";
    
    return mapping;
}

- (NSNumber *)discountedCost {
    if (self.avialable.boolValue) {
        return self.discount.floatValue == 0 ? self.price : @((self.price.floatValue - (self.price.floatValue * 0.01 * self.discount.floatValue)));
    }
    return @(0);
}

@end
