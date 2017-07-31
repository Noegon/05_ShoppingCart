//
//  NGNDataBaseLoader.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 29.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;

@interface NGNServerDataLoader : NSObject

+ (void)loadDataFromServerWithContext:(NSManagedObjectContext *)context;

@end
