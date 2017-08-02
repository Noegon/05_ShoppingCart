//
//  NGNCartTableViewCellNotAvialable.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 02.08.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGNCartTableViewCellNotAvialable : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goodImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet UILabel *notAvialableLabel;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *rotatableViews;

@end
