//
//  NGNGoodsOrder+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 22.07.17.
//
//

#import "NGNGoodsOrder+CoreDataProperties.h"

@implementation NGNGoodsOrder (CoreDataProperties)

+ (NSFetchRequest<NGNGoodsOrder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNGoodsOrder"];
}

@dynamic goodsOrderId;
@dynamic good;
@dynamic order;

@end
