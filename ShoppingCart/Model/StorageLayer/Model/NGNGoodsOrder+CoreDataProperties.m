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

@dynamic entityId;
@dynamic good;
@dynamic order;

@end

@implementation NGNGoodsOrder (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromDictionary:@{@"entityId": @"id"}];
    mapping.primaryKey = @"entityId";
    
    FEMMapping *goodMapping = [[FEMMapping alloc] initWithEntityName:[NGNGood entity].name];
    goodMapping.primaryKey = @"entityId";
    [goodMapping addAttributesFromDictionary:@{@"entityId": @"good"}];
    
    [mapping addRelationshipMapping:goodMapping forProperty:@"good" keyPath:nil];
    
    FEMMapping *orderMapping = [[FEMMapping alloc] initWithEntityName:[NGNOrder entity].name];
    orderMapping.primaryKey = @"entityId";
    [orderMapping addAttributesFromDictionary:@{@"entityId": @"order"}];
    
    [mapping addRelationshipMapping:orderMapping forProperty:@"order" keyPath:nil];
    
    return mapping;
}

@end
