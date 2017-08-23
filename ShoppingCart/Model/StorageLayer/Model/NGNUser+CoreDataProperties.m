//
//  NGNUser+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNUser+CoreDataProperties.h"
#import "NGNOrder+CoreDataProperties.h"

@implementation NGNUser (CoreDataProperties)

+ (NSFetchRequest<NGNUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNUser"];
}

@dynamic entityId;
@dynamic address;
@dynamic name;
@dynamic phone;
@dynamic orders;

@end

@implementation NGNUser (Mapping)

+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:[self entity].name];
    [mapping addAttributesFromArray:@[@"name", @"phone", @"address"]];
    [mapping addAttributesFromDictionary:@{@"entityId": @"id"}];
    mapping.primaryKey = @"entityId";
    
    return mapping;
}

@end
