//
//  NGNGoodsOrder+CoreDataProperties.h
//  
//
//  Created by Alexey Stafeyev on 22.07.17.
//
//

#import "NGNGoodsOrder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNGoodsOrder (CoreDataProperties)

+ (NSFetchRequest<NGNGoodsOrder *> *)fetchRequest;

@property (nonatomic) int32_t goodsOrderId;
@property (nullable, nonatomic, retain) NGNGood *good;
@property (nullable, nonatomic, retain) NGNOrder *order;

@end

NS_ASSUME_NONNULL_END
