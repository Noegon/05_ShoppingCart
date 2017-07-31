//
//  NGNBasicController.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 31.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController/REFrostedViewController.h>
#import <CoreData/CoreData.h>
#import "NGNGood+CoreDataProperties.h"

@interface NGNBasicController : UITableViewController <REFrostedViewControllerDelegate,
                                                       NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) id<NSObject> dataWasLoadedNotification;

@end
