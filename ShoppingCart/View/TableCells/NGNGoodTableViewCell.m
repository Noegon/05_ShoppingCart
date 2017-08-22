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
    
    self.orderButton.layer.shadowOffset = CGSizeMake(0, 5);
    self.orderButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.orderButton.layer.shadowOpacity = 0.5;
    self.orderButton.layer.masksToBounds = NO;
    self.orderButton.layer.shadowRadius = 5;
}

@end
