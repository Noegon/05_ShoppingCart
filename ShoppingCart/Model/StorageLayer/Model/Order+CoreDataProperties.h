//
//  Order+CoreDataProperties.h
//  
//
//  Created by Alex on 19.07.17.
//
//

#import "Order+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Order (CoreDataProperties)

+ (NSFetchRequest<Order *> *)fetchRequest;

@property (nonatomic) int32_t orderId;
@property (nullable, nonatomic, copy) NSDate *orderingDate;
@property (nullable, nonatomic, retain) NSSet<GoodsOrder *> *goodsOrders;
@property (nullable, nonatomic, retain) User *user;

@end

@interface Order (CoreDataGeneratedAccessors)

- (void)addGoodsOrdersObject:(GoodsOrder *)value;
- (void)removeGoodsOrdersObject:(GoodsOrder *)value;
- (void)addGoodsOrders:(NSSet<GoodsOrder *> *)values;
- (void)removeGoodsOrders:(NSSet<GoodsOrder *> *)values;

@end

NS_ASSUME_NONNULL_END
