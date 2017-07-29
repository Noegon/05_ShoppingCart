//
//  NGNGoodsListViewController.m
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNGoodsListViewController.h"
#import "REFrostedViewController.h"
#import "NGNCommonConstants.h"
#import "NGNCatalogService.h"
#import "NGNOrderService.h"
#import "NSDate+NGNformattedDate.h"

@interface NGNGoodsListViewController ()

@property (strong, nonatomic) IBOutlet UIButton *TestShadowButton;

@property (strong, nonatomic) NGNCatalogService *catalogService;
@property (strong, nonatomic) NGNOrderService *orderService;

#pragma mark - additional methods
- (IBAction)profileBarButtonTapped:(UIBarButtonItem *)sender;

@end

@implementation NGNGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
//    self.TestShadowButton.layer.shadowOffset = CGSizeMake(5, 5);
//    self.TestShadowButton.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.TestShadowButton.layer.shadowOpacity = 0.5;
    
//    self.catalogService = [[NGNCatalogService alloc] init];
//    self.orderService = [[NGNOrderService alloc] init];
//    
//    [self.catalogService fetchPhones:^(NSArray *phones){
//        NSLog(@"%@", phones);
//    }];
//    [self.catalogService fetchPhoneById:@"1" completitionBlock:^(NSDictionary *phone) {
//        NSLog(@"%@", phone);
//    }];
//    
//    NSMutableDictionary *testOrder =
//        [@{@"date": [NSDate ngn_formattedStringfiedDate:[NSDate date]],@"catalog": @[@{@"id": @2}], @"id": @2} mutableCopy];
//    
//    [self.orderService addOrder:testOrder completitionBlock:
//     ^(NSDictionary *order){
//        NSLog(@"%@", order);
//    }];
//    
//    testOrder[@"date"] = @"29.07.2017";
//
//    [self.orderService updateOrder:testOrder completitionBlock:
//     ^(NSDictionary *order){
//        NSLog(@"%@", order);
//    }];
//    
//    [self.orderService deleteOrder:testOrder completitionBlock:
//     ^(NSDictionary *order){
//        NSLog(@"%@", order);
//    }];
//    
//    [self.orderService deleteOrderById:@"2" completitionBlock:
//     ^(NSDictionary *order){
////         NSLog(@"%@", order);
//     }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 2;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
@end
