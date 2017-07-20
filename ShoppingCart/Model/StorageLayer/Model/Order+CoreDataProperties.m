//
//  Order+CoreDataProperties.m
//  
//
//  Created by Alex on 19.07.17.
//
//

#import "Order+CoreDataProperties.h"

@implementation Order (CoreDataProperties)

+ (NSFetchRequest<Order *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Order"];
}

@dynamic orderId;
@dynamic orderingDate;
@dynamic goodsOrders;
@dynamic user;

@end
