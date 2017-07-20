//
//  Good+CoreDataProperties.h
//  
//
//  Created by Alex on 19.07.17.
//
//

#import "Good+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Good (CoreDataProperties)

+ (NSFetchRequest<Good *> *)fetchRequest;

@property (nonatomic) BOOL avialable;
@property (nonatomic) int32_t code;
@property (nonatomic) double discount;
@property (nullable, nonatomic, retain) NSObject *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double price;
@property (nullable, nonatomic, retain) NSSet<GoodsOrder *> *goodsOrders;

@end

@interface Good (CoreDataGeneratedAccessors)

- (void)addGoodsOrdersObject:(GoodsOrder *)value;
- (void)removeGoodsOrdersObject:(GoodsOrder *)value;
- (void)addGoodsOrders:(NSSet<GoodsOrder *> *)values;
- (void)removeGoodsOrders:(NSSet<GoodsOrder *> *)values;

@end

NS_ASSUME_NONNULL_END
