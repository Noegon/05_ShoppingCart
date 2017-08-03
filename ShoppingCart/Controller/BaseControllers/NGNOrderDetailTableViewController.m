//
//  NGNOrderDetailTableViewController.m
//  ShoppingCart
//
//  Created by Stafeyev Alexei on 03/08/2017.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNOrderDetailTableViewController.h"
#import "REFrostedViewController.h"
#import "NGNCommonConstants.h"
#import "NGNDataBaseRuler.h"
#import "NGNCartTableViewCellAvialable.h"
#import "NGNCartTableViewCellNotAvialable.h"
#import "NGNOrder+CoreDataProperties.h"

@interface NGNOrderDetailTableViewController ()

@end

@implementation NGNOrderDetailTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    UITableViewCell *cell = nil;
    NGNGoodsOrder *goodsOrder = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NGNGood *good = [self.fetchedResultsController objectAtIndexPath:indexPath].good;
    if (goodsOrder.good.avialable.boolValue) {
        cell = [tableView dequeueReusableCellWithIdentifier:NGNControllerAvialableGoodsInCartCell
                                               forIndexPath:indexPath];
        ((NGNCartTableViewCellAvialable *)cell).nameLabel.text = goodsOrder.good.name;
        ((NGNCartTableViewCellAvialable *)cell).codeLabel.text = goodsOrder.good.entityId.stringValue;
        ((NGNCartTableViewCellAvialable *)cell).priceLabel.text =
            [NSString stringWithFormat:@"%@ RUR", goodsOrder.good.price.stringValue];
        if (goodsOrder.good.discount.floatValue > 0) {
            ((NGNCartTableViewCellAvialable *)cell).priceWithDiscountLabel.text =
            [NSString stringWithFormat:@"%6.1f RUR",
             (goodsOrder.good.price.floatValue / ((goodsOrder.good.discount.floatValue * 0.01) + 1))];
            NSMutableAttributedString *attributeString =
                [[NSMutableAttributedString alloc] initWithString:
                 [NSString stringWithFormat:@"%@ RUR", goodsOrder.good.price.stringValue]];
            [attributeString addAttribute:NSStrikethroughStyleAttributeName
                                    value:@2
                                    range:NSMakeRange(0, [attributeString length])];
            ((NGNCartTableViewCellAvialable *)cell).priceLabel.attributedText = attributeString;
        } else {
            ((NGNCartTableViewCellAvialable *)cell).priceWithDiscountLabel.text = @"";
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:NGNControllerNotAvialableGoodsInCartCell
                                               forIndexPath:indexPath];
        ((NGNCartTableViewCellNotAvialable *)cell).nameLabel.text = goodsOrder.good.name;
        ((NGNCartTableViewCellNotAvialable *)cell).codeLabel.text = goodsOrder.good.entityId.stringValue;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        NSURL *imageURL = [NSURL URLWithString:good.image];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^(){
            ((NGNCartTableViewCellAvialable *)cell).goodImageView.image = [UIImage imageWithData:imageData];
            ((NGNCartTableViewCellAvialable *)cell).goodImageView.contentMode = UIViewContentModeScaleAspectFit;
            [cell setNeedsLayout];
        });
    });
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Fetched results controller

- (NSFetchedResultsController<NGNGoodsOrder *> *)fetchedResultsController {
    //    if (_fetchedResultsController != nil) {
    //        return _fetchedResultsController;
    //    }
    NSFetchRequest<NGNGoodsOrder *> *fetchRequest = [NGNGoodsOrder fetchRequest];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"order.entityId == %@", self.oderId];
    // Set the batch size to a suitable number.
    //    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"good.name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    //    NSArray *goods = [[NGNDataBaseRuler managedObjectContext] executeFetchRequest:fetchRequest error:nil];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<NGNGoodsOrder *> *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:[NGNDataBaseRuler managedObjectContext]
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
#warning do not use abort() in release!!! For debug only!!! Handle this error!!!
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - Fetched results controller delegate methods


@end
