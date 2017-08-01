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
#import "NGNUser+CoreDataProperties.h"
#import "NGNDataBaseRuler.h"
#import "NGNProfileService.h"
#import "NGNCommonConstants.h"

@interface NGNMenuViewController ()

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
                                                      self.nameLabelText = @"test";
                                                      [self.tableView reloadData];
                                                  }];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 284.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 200, 200)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"avatar.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 100.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 20.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, 0, 24)];
        label.text = self.nameLabelText;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
//    self.frostedViewController.menuViewController.view.layer.cornerRadius = 20;
//    self.frostedViewController.menuViewController.view.layer.shadowOffset = CGSizeMake(5, 5);
//    self.frostedViewController.menuViewController.view.layer.shadowColor = [UIColor greenColor].CGColor;
//    self.frostedViewController.blurRadius = 20;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_dataWasLoadedNotification];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:25];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NGNContentNavigationController *navigationController =
        [self.storyboard instantiateViewControllerWithIdentifier:NGNControllerContentController];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        NGNGoodsListViewController *goodsListViewController = [self.storyboard instantiateViewControllerWithIdentifier:NGNControllerGoodsController];
        navigationController.viewControllers = @[goodsListViewController];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        NGNCartCapsuleViewController *cartCapsuleViewController = [self.storyboard instantiateViewControllerWithIdentifier:NGNControllerCartCapsuleController];
        navigationController.viewControllers = @[cartCapsuleViewController];
    }
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 71;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return 5;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.nameLabelText) {
        return @[self.nameLabelText];
    }
    return @[@"(noname)"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSArray *titles = @[@"Home", @"Orders", @"Cart", @"Settings", @"Sign out"];
    cell.textLabel.text = titles[indexPath.row];
    
    return cell;
}

#pragma mark - rounded corners helper

-(void) setCornerRadiusForView:(UIView *)view cornersBitmask:(UIRectCorner)corners cornerRadii:(CGSize)size {
    
    // Create a bezier path with the required corners rounded
    UIBezierPath *cornersPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                      byRoundingCorners:corners
                                                            cornerRadii:size];
    
    //Create a new layer to use as a mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    // Set the path of the layer
    maskLayer.path = cornersPath.CGPath;
    view.layer.mask = maskLayer;
}

@end
