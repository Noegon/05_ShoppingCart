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
@property (strong, nonatomic) NSOperationQueue *queue;

#pragma mark - additional handling methods
- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)orderButtonTapped:(UIButton *)sender;

@end

@implementation NGNGoodsListViewController

- (NSOperationQueue *)queue {
    if (_queue) {
        return _queue;
    }
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 6;
    return queue;
}

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
    NGNGood *good = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NGNGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NGNControllerGoodsInListCell
                                           forIndexPath:indexPath];
    cell.nameLabel.text = good.name;
    cell.codeLabel.text = [NSString stringWithFormat:@"Code: %@", good.entityId.stringValue];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ Rub", good.price.stringValue];
    
    NSURL *imageURL = [NSURL URLWithString:good.image];
    
    NSDictionary* params = @{@"url": imageURL, @"cell":cell};

#warning experiment with different ways of concurrency organization
#warning performing method in background - the easyest way of concurrency
//    [self performSelectorInBackground:@selector(loadImageWithParams:) withObject:params];
    
#warning NSOperationQueue - the most flexible manner of concurrency organization
#warning invocation operation - we still needs some additional methods and also we needs to create the queue
//    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self
//                                                                                      selector:@selector(loadImageWithParams:)
//                                                                                        object:params];
//    
//    [self.queue addOperation:invocationOperation];
    
#warning block operation - we don't need to write additional methods: all code is in one place (very comfortable)
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSURL* url = [NSURL URLWithString:good.image];
        UIImage* thumb = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.goodImageView.image = thumb;
            cell.goodImageView.hidden = NO;
            [cell setNeedsLayout];
        }];
    }];
    [self.queue addOperation:blockOperation];
    
#warning GCD - latest and most powerful instrument. But not so flexible as NSOperationQueue: we cannot cancel operation while it performs in queue
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSURL* url = [NSURL URLWithString:good.image];
//        UIImage* thumb = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.goodImageView.image = thumb;
//            cell.goodImageView.hidden = NO;
//            [cell setNeedsLayout];
//        });
//    });
    
#warning deadlock test - never call 'dispatch_sync(dispatch_get_main_queue()' from current queue!!!
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSURL* url = [NSURL URLWithString:good.image];
//        UIImage* thumb = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//        cell.goodImageView.image = thumb;
//        cell.goodImageView.hidden = NO;
//        [cell setNeedsLayout];
//    });
    
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
#warning do not use abort() in release!!! For debug only!!! Handle this error!!!
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

#warning methods for invocation operation or for background operations

- (void)loadImageWithParams:(NSDictionary *)params {
    NSURL* url = [params objectForKey:@"url"];
    UITableViewCell* cell = [params objectForKey:@"cell"];
    UIImage* thumb = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    NSDictionary* backParams = @{@"cell":cell, @"thumb":thumb};
    [self performSelectorOnMainThread:@selector(setImage:) withObject:backParams waitUntilDone:YES];
}

-(void)setImage:(NSDictionary*)params{
    UITableViewCell* cell = [params objectForKey:@"cell"];
    UIImage* thumb = [params objectForKey:@"thumb"];
    ((NGNGoodTableViewCell *)cell).goodImageView.image = thumb;
    ((NGNGoodTableViewCell *)cell).goodImageView.hidden = NO;
    [cell setNeedsLayout];
}

@end
