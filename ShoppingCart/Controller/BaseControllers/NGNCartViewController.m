//
//  NGNCartViewController.m
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCartViewController.h"
#import "REFrostedViewController.h"
#import "NGNCommonConstants.h"
#import "NGNDataBaseRuler.h"
#import "NGNCartTableViewCellAvialable.h"
#import "NGNCartTableViewCellNotAvialable.h"
#import "NGNOrder+CoreDataProperties.h"

@interface NGNCartViewController ()

@end

@implementation NGNCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.oderId = [self cartId];
}

@end
