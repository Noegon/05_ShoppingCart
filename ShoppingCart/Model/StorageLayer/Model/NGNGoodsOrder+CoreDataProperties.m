//
//  NGNGoodsOrder+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNGoodsOrder+CoreDataProperties.h"
#import "NGNGood+CoreDataProperties.h"
#import "NGNOrder+CoreDataProperties.h"

@implementation NGNGoodsOrder (CoreDataProperties)

+ (NSFetchRequest<NGNGoodsOrder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNGoodsOrder"];
}

@dynamic goodsOrderId;
@dynamic good;
@dynamic order;

@end

@implementation NGNGoodsOrder (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromDictionary:@{@"goodsOrderId": @"id"}];
    mapping.primaryKey = @"goodsOrderId";
    
    FEMMapping *goodMapping = [[FEMMapping alloc] initWithEntityName:[NGNGood entity].name];
    goodMapping.primaryKey = @"goodId";
    [goodMapping addAttributesFromDictionary:@{@"goodId": @"good"}];
    
    [mapping addRelationshipMapping:goodMapping forProperty:@"good" keyPath:nil];
    
    FEMMapping *orderMapping = [[FEMMapping alloc] initWithEntityName:[NGNOrder entity].name];
    orderMapping.primaryKey = @"orderId";
    [orderMapping addAttributesFromDictionary:@{@"orderId": @"order"}];
    
    [mapping addRelationshipMapping:orderMapping forProperty:@"order" keyPath:nil];
    
    return mapping;
}

@end
