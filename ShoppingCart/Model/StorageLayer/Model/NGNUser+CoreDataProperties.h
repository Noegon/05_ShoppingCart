//
//  NGNUser+CoreDataProperties.h
//  
//
//  Created by Alexey Stafeyev on 22.07.17.
//
//

#import "NGNUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NGNUser (CoreDataProperties)

+ (NSFetchRequest<NGNUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t phone;
@property (nullable, nonatomic, retain) NSSet<NGNOrder *> *orders;

@end

@interface NGNUser (CoreDataGeneratedAccessors)

- (void)addOrdersObject:(NGNOrder *)value;
- (void)removeOrdersObject:(NGNOrder *)value;
- (void)addOrders:(NSSet<NGNOrder *> *)values;
- (void)removeOrders:(NSSet<NGNOrder *> *)values;

@end

NS_ASSUME_NONNULL_END
