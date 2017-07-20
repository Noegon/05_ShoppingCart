//
//  GoodsOrder+CoreDataProperties.m
//  
//
//  Created by Alex on 19.07.17.
//
//

#import "GoodsOrder+CoreDataProperties.h"

@implementation GoodsOrder (CoreDataProperties)

+ (NSFetchRequest<GoodsOrder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GoodsOrder"];
}

@dynamic goodsOrderId;
@dynamic good;
@dynamic order;

@end
