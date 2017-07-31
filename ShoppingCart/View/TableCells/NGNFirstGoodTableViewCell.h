//
//  NGNFirstGoodTableViewCell.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 31.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNGoodTableViewCell.h"

@interface NGNFirstGoodTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goodImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIButton *orderButton;

@end
