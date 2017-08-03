//
//  NGNOrderTableViewCell.h
//  ShoppingCart
//
//  Created by Stafeyev Alexei on 03/08/2017.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGNOrderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderCostLabel;

@end
