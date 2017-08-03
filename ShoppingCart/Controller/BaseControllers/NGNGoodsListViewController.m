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
#import "NGNGoodsOrderService.h"
#import "NGNMenuViewController.h"
#import "NSDate+NGNformattedDate.h"
#import "NGNDataBaseRuler.h"
#import "NGNGoodTableViewCell.h"
#import "UIColor+NGNAdditionalColors.h"
#import "NGNServerDataLoader.h"
#import "NGNCoreDataObjects.h"

@interface NGNGoodsListViewController ()

@property (strong, nonatomic) NGNCatalogService *catalogService;
@property (strong, nonatomic) NGNOrderService *orderService;

#pragma mark - additional handling methods
- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)orderButtonTapped:(UIButton *)sender;

@end

@implementation NGNGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NGNGood *good = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell = [tableView dequeueReusableCellWithIdentifier:NGNControllerGoodsInListCell
                                           forIndexPath:indexPath];
    ((NGNGoodTableViewCell *)cell).nameLabel.text = good.name;
    ((NGNGoodTableViewCell *)cell).codeLabel.text = good.entityId.stringValue;
    ((NGNGoodTableViewCell *)cell).priceLabel.text = good.price.stringValue;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(){
        NSURL *imageURL = [NSURL URLWithString:good.image];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^(){
            ((NGNGoodTableViewCell *)cell).goodImageView.image = [UIImage imageWithData:imageData];
            ((NGNGoodTableViewCell *)cell).goodImageView.contentMode = UIViewContentModeScaleAspectFit;
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

- (NSFetchedResultsController<NGNGood *> *)fetchedResultsController {
    
    NSFetchRequest<NGNGood *> *fetchRequest = [NGNGood fetchRequest];
    
    // Set the batch size to a suitable number.
//    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
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
}

#pragma mark - additional handling methods

- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender {
    // Dismiss keyboard (optional)
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)orderButtonTapped:(UIButton *)sender {
    NSManagedObjectContext *context = [NGNDataBaseRuler managedObjectContext];
    NGNGoodTableViewCell *cell = (NGNGoodTableViewCell *)sender.superview.superview;
//    NGNGood *currentGood = (NGNGood *)[NGNGood ngn_entityById:@(cell.codeLabel.text.integerValue)
//                                       inManagedObjectContext:context];
    
    NGNGood *currentGood = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:cell]];
    
    [NGNGoodsOrder ngn_createEntityInManagedObjectContext:context
                                  fieldsCompletitionBlock:
     ^(NSManagedObject *object) {
         NGNOrder *cart = (NGNOrder *)[NGNOrder ngn_entityById:[self cartId]
                                        inManagedObjectContext:context];
         ((NGNGoodsOrder *)object).entityId = @foo4random();
         ((NGNGoodsOrder *)object).good = currentGood;
         ((NGNGoodsOrder *)object).order = cart;
         NGNGoodsOrderService *service = [[NGNGoodsOrderService alloc] init];
         FEMMapping *orderMapping = [NGNGoodsOrder defaultMapping];
         NSDictionary *entityAsDictionary = [FEMSerializer serializeObject:((NGNGoodsOrder *)object) usingMapping:orderMapping];
         [service addGoodsOrder:entityAsDictionary completitionBlock:^(NSDictionary *order){}];
     }];
}

@end
