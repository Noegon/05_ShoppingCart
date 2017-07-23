//
//  NGNOrder+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 22.07.17.
//
//

#import "NGNOrder+CoreDataProperties.h"

@implementation NGNOrder (CoreDataProperties)

+ (NSFetchRequest<NGNOrder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNOrder"];
}

@dynamic orderId;
@dynamic orderingDate;
@dynamic goodsOrders;
@dynamic user;

@end
