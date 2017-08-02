//
//  NGNGoodsListViewController.h
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController/REFrostedViewController.h>
#import <CoreData/CoreData.h>
#import "NGNGood+CoreDataProperties.h"
#import "NGNBasicController.h"

@interface NGNGoodsListViewController : NGNBasicController

@property (strong, nonatomic) NSFetchedResultsController<NGNGood *> *fetchedResultsController;

@end
