//
//  NGNGoodsOrder+CoreDataProperties.h
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNGoodsOrder+CoreDataClass.h"
#import <FastEasyMapping/FastEasyMapping.h>


NS_ASSUME_NONNULL_BEGIN

@interface NGNGoodsOrder (CoreDataProperties)

+ (NSFetchRequest<NGNGoodsOrder *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *goodsOrderId;
@property (nullable, nonatomic, retain) NGNGood *good;
@property (nullable, nonatomic, retain) NGNOrder *order;

@end

@interface NGNGoodsOrder (Mapping)

+ (FEMMapping *)defaultMapping;

@end

NS_ASSUME_NONNULL_END
