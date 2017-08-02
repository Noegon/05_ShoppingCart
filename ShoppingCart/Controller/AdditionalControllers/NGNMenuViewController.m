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
#import <REFrostedViewController/REFrostedViewController.h>

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
        imageView.layer.borderWidth = 10.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        [view addSubview:imageView];
        view;
    });
    
    self.tableView.layer.cornerRadius = 0;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:25];
    if (self.nameLabelText) {
        label.text = self.nameLabelText;
    } else {
        label.text = @"(none)";
    }
    [label setBackgroundColor:[UIColor clearColor]];
    
    return label;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
    return 34;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return 5;
}

//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    if (self.nameLabelText) {
//        return @[self.nameLabelText];
//    }
//    return @[@"(null)"];
//}

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
