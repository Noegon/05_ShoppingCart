//
//  NGNGoodsListViewController.m
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNGoodsListViewController.h"
#import "NGNCommonConstants.h"
#import "NGNCatalogService.h"
#import "NGNOrderService.h"
#import "NGNMenuViewController.h"
#import "NSDate+NGNformattedDate.h"
#import "NGNDataBaseRuler.h"
#import "NGNGoodTableViewCell.h"
#import "NGNFirstGoodTableViewCell.h"

@interface NGNGoodsListViewController ()

@property (strong, nonatomic) NGNCatalogService *catalogService;
@property (strong, nonatomic) NGNOrderService *orderService;

#pragma mark - additional handling methods
- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender;

@end

@implementation NGNGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                 style:UIBarButtonItemStylePlain
//                                                                target:nil
//                                                                action:nil];
//    
//    [self.navigationItem setBackBarButtonItem:backItem];
    
//    self.TestShadowButton.layer.shadowOffset = CGSizeMake(5, 5);
//    self.TestShadowButton.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.TestShadowButton.layer.shadowOpacity = 0.5;
    
//    self.catalogService = [[NGNCatalogService alloc] init];
//    self.orderService = [[NGNOrderService alloc] init];
//    
//    [self.catalogService fetchPhones:^(NSArray *phones){
//        NSLog(@"%@", phones);
//    }];
//    [self.catalogService fetchPhoneById:@"1" completitionBlock:^(NSDictionary *phone) {
//        NSLog(@"%@", phone);
//    }];
//    
//    NSMutableDictionary *testOrder =
//        [@{@"date": [NSDate ngn_formattedStringfiedDate:[NSDate date]],@"catalog": @[@{@"id": @2}], @"id": @2} mutableCopy];
//    
//    [self.orderService addOrder:testOrder completitionBlock:
//     ^(NSDictionary *order){
//        NSLog(@"%@", order);
//    }];
//    
//    testOrder[@"date"] = @"29.07.2017";
//
//    [self.orderService updateOrder:testOrder completitionBlock:
//     ^(NSDictionary *order){
//        NSLog(@"%@", order);
//    }];
//    
//    [self.orderService deleteOrder:testOrder completitionBlock:
//     ^(NSDictionary *order){
//        NSLog(@"%@", order);
//    }];
//    
//    [self.orderService deleteOrderById:@"2" completitionBlock:
//     ^(NSDictionary *order){
////         NSLog(@"%@", order);
//     }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 170;
    }
    return 160;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    NSInteger numOfSections = [[self.fetchedResultsController sections] count];
//    return numOfSections;
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    NSInteger numOfRows = [sectionInfo numberOfObjects];
    return numOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    NGNGood *good = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsInFirstListCell"
                                               forIndexPath:indexPath];
        ((NGNFirstGoodTableViewCell *)cell).nameLabel.text = good.name;
        ((NGNFirstGoodTableViewCell *)cell).codeLabel.text = good.goodId.stringValue;
        ((NGNFirstGoodTableViewCell *)cell).priceLabel.text = good.price.stringValue;
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsInListCell"
                                               forIndexPath:indexPath];
        ((NGNGoodTableViewCell *)cell).nameLabel.text = good.name;
        ((NGNGoodTableViewCell *)cell).codeLabel.text = good.goodId.stringValue;
        ((NGNGoodTableViewCell *)cell).priceLabel.text = good.price.stringValue;
    }
#warning make transformable object for image!!!
//    cell.imageView.image = good.image;
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

- (NSFetchedResultsController<NGNGood *> *)fetchedResultsController {
//    if (_fetchedResultsController != nil) {
//        return _fetchedResultsController;
//    }
    
    NSFetchRequest<NGNGood *> *fetchRequest = [NGNGood fetchRequest];
    
    // Set the batch size to a suitable number.
//    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
//    NSArray *goods = [[NGNDataBaseRuler managedObjectContext] executeFetchRequest:fetchRequest error:nil];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<NGNGood *> *aFetchedResultsController =
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



#pragma mark - REFrostedViewControllerDelegate methods

- (void)frostedViewController:(REFrostedViewController *)frostedViewController
    willShowMenuViewController:(UIViewController *)menuViewController {
    // This will be called on the main thread, so that
    // you can update the UI, for example.
//    NGNMenuViewController *testController = ((NGNMenuViewController *)menuViewController);
//    testController.nameLabelText = @"test";
//    testController.view.backgroundColor = [UIColor grayColor];
//    testController.view.layer.cornerRadius = 0;
////    [testController setCornerRadiusForView:testController.view
////                            cornersBitmask:(UIRectCornerTopRight | UIRectCornerBottomRight)
////                               cornerRadii:CGSizeMake(50, 50)];
//    NSArray *subviews = testController.view.subviews[2].subviews;
//    UILabel *label = subviews[1];
//    label.text = @"test";
//    NSLog(@"%@", label.text);
//    
//    testController.view.layer.shadowOffset = CGSizeMake(5, 5);
}

#pragma mark - additional handling methods

- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

@end
