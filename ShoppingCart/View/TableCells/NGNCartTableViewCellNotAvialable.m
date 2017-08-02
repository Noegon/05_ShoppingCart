//
//  NGNCartTableViewCellNotAvialable.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 02.08.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCartTableViewCellNotAvialable.h"
#import "NGNCommonConstants.h"

@implementation NGNCartTableViewCellNotAvialable

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.rotatableViews enumerateObjectsUsingBlock:
     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //set point of rotation
        ((UIView *)obj).center = CGPointMake(CGRectGetMaxX(((UIView *)obj).bounds), CGRectGetMaxY(_nameLabel.bounds));
        
        //rotate rect
        ((UIView *)obj).transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(2)); //rotation in radians
    }];
    
//    [self.NotAvialableGoodsCells enumerateObjectsUsingBlock:
//     ^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//         UIView *rotatedView = ((UIView *)obj).subviews[0].subviews[1];
//         double rads = DEGREES_TO_RADIANS(5);
//         CGAffineTransform transform = CGAffineTransformRotate(CGAffineTransformIdentity, rads);
//         rotatedView.transform = transform;
//     }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
