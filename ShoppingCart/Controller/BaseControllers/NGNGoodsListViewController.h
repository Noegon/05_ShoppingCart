//
//  NGNGoodsListViewController.h
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCoreDataObjects.h"
#import "NGNBasicController.h"

#import <UIKit/UIKit.h>
#import <REFrostedViewController/REFrostedViewController.h>
#import <CoreData/CoreData.h>

@interface NGNGoodsListViewController : NGNBasicController

@property (strong, nonatomic) NSFetchedResultsController<NGNGood *> *fetchedResultsController;

@end
