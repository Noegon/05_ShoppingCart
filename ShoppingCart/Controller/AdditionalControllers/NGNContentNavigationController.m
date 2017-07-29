//
//  NGNContentNavigationController.m
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNContentNavigationController.h"
#import "REFrostedViewController.h"

@interface NGNContentNavigationController ()

@end

@implementation NGNContentNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(panGestureRecognized:)]];
}

#pragma mark - Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController panGestureRecognized:sender];
}

@end
