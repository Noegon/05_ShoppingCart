//
//  GoodsOrder+CoreDataProperties.h
//  
//
//  Created by Alex on 19.07.17.
//
//

#import "GoodsOrder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GoodsOrder (CoreDataProperties)

+ (NSFetchRequest<GoodsOrder *> *)fetchRequest;

@property (nonatomic) int32_t goodsOrderId;
@property (nullable, nonatomic, retain) Good *good;
@property (nullable, nonatomic, retain) Order *order;

@end

NS_ASSUME_NONNULL_END
