//
//  UIViewController+NGNBasicViewController.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 01.08.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "UIViewController+NGNBasicViewController.h"

@implementation UIViewController (NGNBasicViewController)

- (void)addFallingShadowFromNavigationBar {
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.93f green:0.95f blue:0.96f alpha:1.0f];
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 5);
    self.navigationController.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.5;
    self.navigationController.navigationBar.layer.masksToBounds = NO;
    self.navigationController.navigationBar.layer.shadowRadius = 5;
}

@end
