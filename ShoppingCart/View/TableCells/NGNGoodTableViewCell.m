//
//  NGNGoodTableViewCell.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 31.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNGoodTableViewCell.h"

@implementation NGNGoodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _orderButton.layer.shadowOffset = CGSizeMake(0, 5);
    _orderButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _orderButton.layer.shadowOpacity = 0.5;
    _orderButton.layer.masksToBounds = NO;
    _orderButton.layer.shadowRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
