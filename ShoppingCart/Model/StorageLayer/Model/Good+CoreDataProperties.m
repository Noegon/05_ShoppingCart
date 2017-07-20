//
//  Good+CoreDataProperties.m
//  
//
//  Created by Alex on 19.07.17.
//
//

#import "Good+CoreDataProperties.h"

@implementation Good (CoreDataProperties)

+ (NSFetchRequest<Good *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Good"];
}

@dynamic avialable;
@dynamic code;
@dynamic discount;
@dynamic image;
@dynamic name;
@dynamic price;
@dynamic goodsOrders;

@end
