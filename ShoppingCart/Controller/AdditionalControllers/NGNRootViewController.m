//
//  NGNRootViewController.m
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNRootViewController.h"

@interface NGNRootViewController ()

@end

@implementation NGNRootViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuController"];
    self.blurRadius = 0;
    self.blurSaturationDeltaFactor = 0;
    self.liveBlur = NO;
    self.view.backgroundColor = [UIColor clearColor];
    self.blurTintColor = [UIColor clearColor];
    self.backgroundFadeAmount = 0;
}

@end
