//
//  NGNCartCapsuleViewController.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 30.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCartCapsuleViewController.h"
#import <REFrostedViewController/REFrostedViewController.h>

@interface NGNCartCapsuleViewController ()

@property (strong, nonatomic) IBOutlet UIButton *makeOrderButton;

- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)makeOrderButtonTapped:(UIButton *)sender;

@end

@implementation NGNCartCapsuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.makeOrderButton.layer.shadowOffset = CGSizeMake(5, 5);
    self.makeOrderButton.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.makeOrderButton.layer.shadowOpacity = 0.5;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)makeOrderButtonTapped:(UIButton *)sender {
#warning debug message!!! Handle making order!
    NSLog(@"%@", @"order was made");
}
@end
