//
//  User+CoreDataProperties.m
//  
//
//  Created by Alex on 19.07.17.
//
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic address;
@dynamic name;
@dynamic phone;
@dynamic orders;

@end
