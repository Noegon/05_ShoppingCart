//
//  NGNOrder+CoreDataProperties.h
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNOrder+CoreDataClass.h"
#import <FastEasyMapping/FastEasyMapping.h>

NS_ASSUME_NONNULL_BEGIN

@interface NGNOrder (CoreDataProperties)

+ (NSFetchRequest<NGNOrder *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *entityId;
@property (nullable, nonatomic, copy) NSDate *orderingDate;
@property (nullable, nonatomic, copy) NSNumber *state;
@property (nullable, nonatomic, retain) NSSet<NGNGoodsOrder *> *goodsOrders;
@property (nullable, nonatomic, retain) NGNUser *user;

@end

@interface NGNOrder (CoreDataGeneratedAccessors)

- (void)addGoodsOrdersObject:(NGNGoodsOrder *)value;
- (void)removeGoodsOrdersObject:(NGNGoodsOrder *)value;
- (void)addGoodsOrders:(NSSet<NGNGoodsOrder *> *)values;
- (void)removeGoodsOrders:(NSSet<NGNGoodsOrder *> *)values;

@end

@interface NGNOrder (Mapping)

+ (FEMMapping *)defaultMapping;

@end

NS_ASSUME_NONNULL_END
