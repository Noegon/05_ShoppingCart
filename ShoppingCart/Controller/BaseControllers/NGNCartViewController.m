//
//  NGNCartViewController.m
//  ShoppingCart
//
//  Created by Alex on 19.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNCartViewController.h"
#import "REFrostedViewController.h"
#import "NGNCommonConstants.h"
#import "NGNDataBaseRuler.h"
#import "NGNCartTableViewCellAvialable.h"
#import "NGNCartTableViewCellNotAvialable.h"
#import "NGNOrder+CoreDataProperties.h"
#import "NGNGoodsOrderService.h"

@interface NGNCartViewController ()

@end

@implementation NGNCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.oderId) {
        self.oderId = [self cartId];
    }
}

#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"
                                                                          handler:
                                          ^(UITableViewRowAction *action, NSIndexPath *indexPath) {

                                              dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                  NGNGoodsOrder *goodsOrder = [self.fetchedResultsController objectAtIndexPath:indexPath];
                                                  
                                                  NGNGoodsOrderService *service = [[NGNGoodsOrderService alloc] init];
                                                  FEMMapping *goodsOrderMapping = [NGNGoodsOrder defaultMapping];
                                                  NSDictionary *goodsOrderAsDictionary = [FEMSerializer serializeObject:goodsOrder usingMapping:goodsOrderMapping];
                                                  [service deleteGoodsOrder:goodsOrderAsDictionary completitionBlock:^(NSDictionary *goodsOrder) {}];
                                                  
                                                  [NGNGoodsOrder ngn_deleteEntityInManagedObjectContext:[NGNDataBaseRuler managedObjectContext]
                                                                                          managedObject:goodsOrder];
                                                  [NGNDataBaseRuler saveContext];
                                              });
                                          }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, error.userInfo);
            abort();
        }
    }
}

#pragma mark - Fetched results controller delegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
