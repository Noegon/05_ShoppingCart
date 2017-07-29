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
@dynamic goodId;
@dynamic image;
@dynamic name;
@dynamic price;
@dynamic goodsOrders;

@end

@implementation NGNGood (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"avialable", @"price", @"discount", @"name"]];
    [mapping addAttributesFromDictionary:@{@"goodId": @"id"}];
    mapping.primaryKey = @"goodId";
    
    return mapping;
}

@end
