//
//  NGNMenuViewController.h
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGNMenuViewController : UITableViewController

@property (copy, nonatomic) NSString *nameLabelText;

#pragma mark - helper methods
- (void)setCornerRadiusForView:(UIView *)view cornersBitmask:(UIRectCorner)corners cornerRadii:(CGSize)size;

@end
