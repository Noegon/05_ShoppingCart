//
//  NGNUser+CoreDataProperties.h
//  
//
//  Created by Alexey Stafeyev on 27.07.17.
//
//

#import "NGNUser+CoreDataClass.h"
#import <FastEasyMapping/FastEasyMapping.h>

NS_ASSUME_NONNULL_BEGIN

@interface NGNUser (CoreDataProperties)

+ (NSFetchRequest<NGNUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *entityId;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSNumber *phone;
@property (nullable, nonatomic, retain) NSSet<NGNOrder *> *orders;

@end

@interface NGNUser (CoreDataGeneratedAccessors)

- (void)addOrdersObject:(NGNOrder *)value;
- (void)removeOrdersObject:(NGNOrder *)value;
- (void)addOrders:(NSSet<NGNOrder *> *)values;
- (void)removeOrders:(NSSet<NGNOrder *> *)values;

@end

@interface NGNUser (Mapping)

+ (FEMMapping *)defaultMapping;

@end

NS_ASSUME_NONNULL_END
