//
//  NGNOrderDetailTableViewController.h
//  ShoppingCart
//
//  Created by Stafeyev Alexei on 03/08/2017.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCoreDataObjects.h"
#import "NGNBasicController.h"

#import <UIKit/UIKit.h>
#import <REFrostedViewController/REFrostedViewController.h>
#import <CoreData/CoreData.h>

@interface NGNOrderDetailTableViewController : NGNBasicController

@property (strong, nonatomic) NSFetchedResultsController<NGNGoodsOrder *> *fetchedResultsController;
@property (strong, nonatomic) NSNumber *oderId;

@end
