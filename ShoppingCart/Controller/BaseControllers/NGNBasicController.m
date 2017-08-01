//
//  NGNBasicController.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 31.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNBasicController.h"
#import "NGNCommonConstants.h"
#import "UIViewController+NGNBasicViewController.h"

@interface NGNBasicController ()

@end

@implementation NGNBasicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.frostedViewController.delegate = self;
    
    self.dataWasLoadedNotification =
    [[NSNotificationCenter defaultCenter] addObserverForName:NGNControllerNotificationDataWasLoaded
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notification) {
                                                      [self.tableView reloadData];
                                                  }];
    [self addFallingShadowFromNavigationBar];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:_dataWasLoadedNotification];
}

@end
