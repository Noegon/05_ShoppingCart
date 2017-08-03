//
//  NGNBasicController.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 31.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNBasicController.h"
#import "NGNCommonConstants.h"
#import "UIViewController+NGNBasicViewController.h"
#import "NGNCoreDataObjects.h"
#import "NGNDataBaseRuler.h"

@interface NGNBasicController ()

@end

@implementation NGNBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.frostedViewController.delegate = self;
    
    self.dataWasLoadedNotification =
    [[NSNotificationCenter defaultCenter] addObserverForName:NGNControllerNotificationDataWasLoaded
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notification) {
                                                      [self.tableView reloadData];
                                                  }];
    [self addFallingShadowFromNavigationBar];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_dataWasLoadedNotification];
}

#pragma mark - Table view delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
    return 12.5;
}

#pragma mark - Helper methods methods

- (NSNumber *)cartId {
    NSArray *orders = [NGNOrder ngn_allEntitiesInManagedObjectContext:[NGNDataBaseRuler managedObjectContext]];
    NSUInteger cartIndex = [orders indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
        return ((NGNOrder *)obj).state.integerValue == NGNOrderInCart;
    }];
    return ((NGNOrder *)orders[cartIndex]).entityId;
}

@end
