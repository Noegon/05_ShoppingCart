//
//  NGNOrdersTableViewController.m
//  ShoppingCart
//
//  Created by Stafeyev Alexei on 03/08/2017.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNOrdersTableViewController.h"
#import "NGNCommonConstants.h"
#import "NGNCatalogService.h"
#import "NGNOrderService.h"
#import "NGNGoodsOrderService.h"
#import "NGNCoreDataObjects.h"
#import "NSDate+NGNformattedDate.h"
#import "NGNDataBaseRuler.h"
#import "NGNServerDataLoader.h"

#import "NGNOrderDetailTableViewController.h"
#import "NGNMenuViewController.h"
#import "NGNOrderTableViewCell.h"
#import "UIColor+NGNAdditionalColors.h"

@interface NGNOrdersTableViewController ()

- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender;

@end

@implementation NGNOrdersTableViewController

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numOfSections = [[self.fetchedResultsController sections] count];
    return numOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    NSInteger numOfRows = [sectionInfo numberOfObjects];
    return numOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NGNOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NGNOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NGNControllerOrderCell
                                                                  forIndexPath:indexPath];
    cell.orderNumberLabel.text = [NSString stringWithFormat:@"№%@", order.entityId.stringValue];
    cell.orderStatusLabel.text = [self orderStatusFromEnum:order.state.integerValue];
    cell.orderDateLabel.text = [NSDate ngn_formattedStringfiedDate:order.orderingDate];
    cell.orderCostLabel.text = [NSString stringWithFormat:@"%@ Rub", order.totalOrderCost.stringValue];
    return cell;
}

 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     NGNOrderDetailTableViewController *orderDetailController = [segue destinationViewController];
     NGNOrderTableViewCell *cell = sender;
     NGNOrder *currentOrder = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:cell]];
     orderDetailController.oderId = currentOrder.entityId;
     orderDetailController.navigationItem.title = cell.orderNumberLabel.text;
 }



#pragma mark - Fetched results controller

- (NSFetchedResultsController<NGNOrder *> *)fetchedResultsController {
    
    NSFetchRequest<NGNOrder *> *fetchRequest = [NGNOrder fetchRequest];
    
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"state != 0"];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"orderingDate" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    fetchRequest.fetchBatchSize = 6;
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<NGNOrder *> *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:[NGNDataBaseRuler managedObjectContext]
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - additional handling methods

- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender {
    // Dismiss keyboard (optional)
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    [self.frostedViewController presentMenuViewController];
}

- (NSString *)orderStatusFromEnum:(NSInteger)orderStatus {
    switch (orderStatus) {
        case NGNOrderAccepted:
            return @"Accepted";
        case NGNOrderReceived:
            return @"Received";
        case NGNOrderDeclined:
            return @"Declined";
    }
    return @"";
}

@end
