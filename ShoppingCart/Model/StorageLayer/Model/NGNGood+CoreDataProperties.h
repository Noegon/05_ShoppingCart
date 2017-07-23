//
//  NGNGood+CoreDataProperties.h
//  
//
//  Created by Alexey Stafeyev on 22.07.17.
//
//

#import "NGNGood+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNGood (CoreDataProperties)

+ (NSFetchRequest<NGNGood *> *)fetchRequest;

@property (nonatomic) BOOL avialable;
@property (nonatomic) int32_t code;
@property (nonatomic) double discount;
@property (nullable, nonatomic, retain) NSObject *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double price;
@property (nullable, nonatomic, retain) NSSet<NGNGoodsOrder *> *goodsOrders;

@end

@interface NGNGood (CoreDataGeneratedAccessors)

- (void)addGoodsOrdersObject:(NGNGoodsOrder *)value;
- (void)removeGoodsOrdersObject:(NGNGoodsOrder *)value;
- (void)addGoodsOrders:(NSSet<NGNGoodsOrder *> *)values;
- (void)removeGoodsOrders:(NSSet<NGNGoodsOrder *> *)values;

@end

NS_ASSUME_NONNULL_END
