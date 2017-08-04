//
//  NGNMenuViewController.m
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNMenuViewController.h"
#import "NGNContentNavigationController.h"
#import "REFrostedViewController.h"
#import "NGNGoodsListViewController.h"
#import "NGNCartCapsuleViewController.h"
#import "NGNOrdersTableViewController.h"

#import "NGNUser+CoreDataProperties.h"
#import "NGNDataBaseRuler.h"
#import "NGNProfileService.h"
#import "NGNCommonConstants.h"

#import "UIColor+NGNAdditionalColors.h"
#import "NGNMenuTableViewCell.h"

#import <REFrostedViewController/REFrostedViewController.h>

@interface NGNMenuViewController ()

@property (copy, nonatomic) NSString *nameLabelText;
@property (strong, nonatomic) id<NSObject> dataWasLoadedNotification;

@end

@implementation NGNMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataWasLoadedNotification =
        [[NSNotificationCenter defaultCenter] addObserverForName:NGNControllerNotificationDataWasLoaded
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notification) {
                                                      NGNUser *user = [NGNUser ngn_allEntitiesInManagedObjectContext:[NGNDataBaseRuler managedObjectContext]][0];
                                                      if (user) {
                                                            self.nameLabelText = user.name;
                                                      }
                                                      [self.tableView reloadData];
                                                  }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 260.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 200, 200)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"avatar.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 100.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 7.0;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        [view addSubview:imageView];
        view;
    });
    
    self.tableView.layer.cornerRadius = 0;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    CGRect rect = CGRectMake(0, -250,
                             CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)+500);
    gradient.frame = rect;
    gradient.colors = @[(id)[UIColor ngn_menuGradientEdgeColor].CGColor,
                        (id)[UIColor ngn_menuGradientCentralColor].CGColor,
                        (id)[UIColor ngn_menuGradientCentralColor].CGColor,
                        (id)[UIColor ngn_menuGradientEdgeColor].CGColor];
    gradient.locations = @[@0.0, @0.50, @0.50, @1.0];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_dataWasLoadedNotification];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor ngn_menuTextColor];
    cell.textLabel.font = [UIFont fontWithName:NGNControllerHelveticaLightFont size:NGNControllerMenuFontHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 110)];
    parentView.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor ngn_menuTextColor];
    label.font = [UIFont fontWithName:NGNControllerHelveticaLightFont size:NGNControllerMenuFontHeight];
    if (self.nameLabelText) {
        label.text = self.nameLabelText;
    } else {
        label.text = @"(none)";
    }
    label.backgroundColor = [UIColor clearColor];
    [parentView addSubview:label];
    
    return parentView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NGNContentNavigationController *navigationController =
        [self.storyboard instantiateViewControllerWithIdentifier:NGNControllerContentController];
    if (indexPath.row != 3) {
        if (indexPath.row == 0) {
            NGNGoodsListViewController *goodsListViewController = [self.storyboard instantiateViewControllerWithIdentifier:NGNControllerGoodsController];
            navigationController.viewControllers = @[goodsListViewController];
        } else if (indexPath.row == 1) {
            NGNOrdersTableViewController *ordersViewController = [self.storyboard instantiateViewControllerWithIdentifier:NGNControllerOrdersController];
            navigationController.viewControllers = @[ordersViewController];
        } else if (indexPath.row == 2) {
            NGNCartCapsuleViewController *cartCapsuleViewController = [self.storyboard instantiateViewControllerWithIdentifier:NGNControllerCartCapsuleController];
            navigationController.viewControllers = @[cartCapsuleViewController];
        } else if (indexPath.row == 4) {
            NSLog(@"%@", @"Exit");
            exit(0);
        }
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
    } else {
        NSLog(@"%@", @"Functionality was not realized");
    }
}

#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
    return 110;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NGNControllerMenuCell;
    
    NGNMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.menuTextLabel.text = [NGNCommonConstants menuCellTitles][indexPath.row];
    cell.menuImageView.image = [UIImage imageNamed:[NGNCommonConstants menuIcons][indexPath.row]];
    
    return cell;
}

@end
