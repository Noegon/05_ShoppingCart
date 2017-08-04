//
//  NGNCartCapsuleViewController.m
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 30.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCartCapsuleViewController.h"
#import "NGNCartViewController.h"
#import "UIViewController+NGNBasicViewController.h"
#import "NGNServerDataLoader.h"
#import "NGNDataBaseRuler.h"
#import "NGNCoreDataObjects.h"
#import "NGNCommonConstants.h"
#import "NGNOrderService.h"

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
    
    [self addFallingShadowFromNavigationBar];
}

- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender {
    // Dismiss keyboard (optional)
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    [self.frostedViewController presentMenuViewController];
}

- (IBAction)makeOrderButtonTapped:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NGNCartViewController *cartController = self.childViewControllers[0];
        NGNOrder *cart = (NGNOrder *)[NGNOrder ngn_entityById:cartController.oderId inManagedObjectContext:[NGNDataBaseRuler managedObjectContext]];
        cart.state = @(NGNOrderAccepted);
        NGNOrderService *service = [[NGNOrderService alloc] init];
        FEMMapping *cartMapping = [NGNOrder defaultMapping];
        NSDictionary *entityAsDictionary = [FEMSerializer serializeObject:cart usingMapping:cartMapping];
        [service updateOrder:entityAsDictionary completitionBlock:^(NSDictionary *order){}];
        
        [NGNServerDataLoader checkCartExistingInManagedObjectContext:[NGNDataBaseRuler managedObjectContext]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:NGNControllerRootController];
            [self presentViewController:vc animated:YES completion:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:NGNControllerNotificationDataWasLoaded object:nil];
            NSLog(@"%@", @"order was made");
        });
        [NGNDataBaseRuler saveContext];
    });
}
@end
