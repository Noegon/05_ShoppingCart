//
//  NGNGood+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 22.07.17.
//
//

#import "NGNGood+CoreDataProperties.h"

@implementation NGNGood (CoreDataProperties)

+ (NSFetchRequest<NGNGood *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNGood"];
}

@dynamic avialable;
@dynamic code;
@dynamic discount;
@dynamic image;
@dynamic name;
@dynamic price;
@dynamic goodsOrders;

@end
