//
//  NGNDataBaseLoader.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 29.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NGNReachability;
@class NSManagedObjectContext;

@interface NGNServerDataLoader : NSObject

@property (strong, nonatomic) NGNReachability* internetReachable;
@property (strong, nonatomic) NGNReachability* hostReachable;

+ (void)loadDataFromServerWithContext:(NSManagedObjectContext *)context;

#pragma mark - networking

/*Returns YES if it is avialable connection with current server, NO in other case**/
+ (BOOL)checkServerStatusWithHostName:(NSString *)hostName;

/*Returns YES if it is avialable internet connection, NO in other case**/
+ (BOOL)checkInternetStatus;

#pragma mark - additional helper methods

+ (void)checkCartExistingInManagedObjectContext:(NSManagedObjectContext *)context;


@end
