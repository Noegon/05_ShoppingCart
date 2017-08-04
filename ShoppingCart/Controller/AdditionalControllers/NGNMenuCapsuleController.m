//
//  NGNMenuCapsuleController.m
//  ShoppingCart
//
//  Created by Stafeyev Alexei on 02/08/2017.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNMenuCapsuleController.h"
#import "NGNCommonConstants.h"
#import "UIColor+NGNAdditionalColors.h"

#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>

static NSInteger const NGNFrostedControllerOffset = 50;

@implementation NGNMenuCapsuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.alpha = 1;
    
    self.backgroundView.layer.shadowColor = [[UIColor ngn_menuShadowColor] CGColor];
    self.backgroundView.layer.shadowOffset = CGSizeMake(20, 0);
    self.backgroundView.layer.shadowRadius = 10;
    self.backgroundView.layer.shadowOpacity = 0.6;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    
    // Create a bezier path with the required corners rounded
    CGRect testRect = CGRectMake(0, 0,
                                 CGRectGetWidth(self.menuContainerView.bounds) - NGNFrostedControllerOffset,
                                 CGRectGetHeight(self.menuContainerView.bounds));
    UIBezierPath *cornersPath = [UIBezierPath bezierPathWithRoundedRect:testRect
                                                      byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                            cornerRadii:CGSizeMake(100, 100)];
    //Create a new layer to use as a mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    
    // Set the path of the layer
    maskLayer.path = cornersPath.CGPath;
    self.menuContainerView.layer.mask = maskLayer;
}

@end
