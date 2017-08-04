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

    _containerView.layer.shadowOffset = CGSizeMake(0, 5);
    _containerView.layer.shadowColor = [UIColor blackColor].CGColor;
    _containerView.layer.shadowOpacity = 0.5;
    _containerView.layer.masksToBounds = NO;
    _containerView.layer.shadowRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
