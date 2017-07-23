//
//  NGNUser+CoreDataProperties.m
//  
//
//  Created by Alexey Stafeyev on 22.07.17.
//
//

#import "NGNUser+CoreDataProperties.h"

@implementation NGNUser (CoreDataProperties)

+ (NSFetchRequest<NGNUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"NGNUser"];
}

@dynamic address;
@dynamic name;
@dynamic phone;
@dynamic orders;

@end
