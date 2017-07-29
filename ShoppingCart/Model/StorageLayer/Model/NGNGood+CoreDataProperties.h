//
//  NGNGood+CoreDataProperties.h
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNGood+CoreDataClass.h"
#import <FastEasyMapping/FastEasyMapping.h>


NS_ASSUME_NONNULL_BEGIN

@interface NGNGood (CoreDataProperties)

+ (NSFetchRequest<NGNGood *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *avialable;
@property (nullable, nonatomic, copy) NSNumber *discount;
@property (nullable, nonatomic, copy) NSNumber *goodId;
@property (nullable, nonatomic, retain) NSObject *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *price;
@property (nullable, nonatomic, retain) NSSet<NGNGoodsOrder *> *goodsOrders;

@end

@interface NGNGood (CoreDataGeneratedAccessors)

- (void)addGoodsOrdersObject:(NGNGoodsOrder *)value;
- (void)removeGoodsOrdersObject:(NGNGoodsOrder *)value;
- (void)addGoodsOrders:(NSSet<NGNGoodsOrder *> *)values;
- (void)removeGoodsOrders:(NSSet<NGNGoodsOrder *> *)values;

@end

@interface NGNGood (Mapping)

+ (FEMMapping *)defaultMapping;

@end

NS_ASSUME_NONNULL_END
