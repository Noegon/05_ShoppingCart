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
#import "NGNCoreDataObjects.h"
#import "NSDate+NGNformattedDate.h"
#import "NGNDataBaseRuler.h"
#import "NGNServerDataLoader.h"

#import "NGNMenuViewController.h"
#import "NGNCartCapsuleViewController.h"
#import "NGNGoodTableViewCell.h"
#import "UIColor+NGNAdditionalColors.h"


@interface NGNGoodsListViewController ()

@property (strong, nonatomic) NGNCatalogService *catalogService;
@property (strong, nonatomic) NGNOrderService *orderService;

#pragma mark - additional handling methods
- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)orderButtonTapped:(UIButton *)sender;

@end

@implementation NGNGoodsListViewController

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
    NGNGood *good = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NGNGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NGNControllerGoodsInListCell
                                           forIndexPath:indexPath];
    cell.nameLabel.text = good.name;
    cell.codeLabel.text = [NSString stringWithFormat:@"Code: %@", good.entityId.stringValue];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ Rub", good.price.stringValue];
    
    dispatch_queue_attr_t attribute = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_CONCURRENT, QOS_CLASS_USER_INTERACTIVE, 0);
    dispatch_queue_t myQueue = dispatch_queue_create("myQueue", attribute);
    
    dispatch_async(myQueue, ^{
        NSURL* url = [NSURL URLWithString:good.image];
        UIImage* thumb = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.goodImageView.image = thumb;
            cell.goodImageView.hidden = NO;
            [cell setNeedsLayout];
        });
    });
    
    return cell;
}

#pragma mark - navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *toController = [segue destinationViewController];
    NSLog(@"%@", [toController class]);
    if ([toController isKindOfClass:[NGNCartCapsuleViewController class]]) {
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconmonstr-arrow-left"]
                                                                    style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(backButtonTapped:)];
        toController.navigationItem.leftBarButtonItem = backButton;
        backButton.tintColor = [UIColor ngn_navigationBarTintColor];
    }
}

- (void)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Fetched results controller

- (NSFetchedResultsController<NGNGood *> *)fetchedResultsController {
    
    NSFetchRequest<NGNGood *> *fetchRequest = [NGNGood fetchRequest];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    fetchRequest.fetchBatchSize = 6;
    
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

- (IBAction)orderButtonTapped:(UIButton *)sender {
    NSManagedObjectContext *context = [NGNDataBaseRuler managedObjectContext];
    NGNGoodTableViewCell *cell = (NGNGoodTableViewCell *)sender.superview.superview;
    
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
