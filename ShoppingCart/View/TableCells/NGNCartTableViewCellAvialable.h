//
//  NGNCartTableViewCellAvialable.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 02.08.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGNCartTableViewCellAvialable : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goodImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceWithDiscountLabel;

@end
