//
//  NGNOrderTableViewCell.m
//  ShoppingCart
//
//  Created by Stafeyev Alexei on 03/08/2017.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNOrderTableViewCell.h"

@interface NGNOrderTableViewCell ()

@property (strong, nonatomic) IBOutlet UIView *containerView;

@end

@implementation NGNOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.containerView.layer.shadowOffset = CGSizeMake(0, 5);
    self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.containerView.layer.shadowOpacity = 0.5;
    self.containerView.layer.masksToBounds = NO;
    self.containerView.layer.shadowRadius = 5;
}

@end
