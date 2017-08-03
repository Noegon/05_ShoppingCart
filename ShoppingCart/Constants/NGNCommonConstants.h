//
//  NGNCommonConstants.h
//  ShoppingCart
//
//  Created by Alexey Stafeyev on 21.07.17.
//  Copyright © 2017 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define foo4random() (arc4random() % ((unsigned)RAND_MAX + 1))

typedef enum: NSUInteger {
    NGNOrderInCart = 0,
    NGNOrderAccepted,
    NGNOrderReceived,
    NGNOrderDeclined
} NGNOrderStatus;

static NSString *const NGNModelAppName = @"ShoppingCart";
static NSString *const NGNModelDateFormat = @"dd.MM.yyyy";

#pragma mark - controllersIds

static NSString *const NGNControllerRootController = @"rootController";
static NSString *const NGNControllerMenuController = @"menuController";
static NSString *const NGNControllerContentController = @"contentController";
static NSString *const NGNControllerGoodsController = @"goodsController";
static NSString *const NGNControllerCartCapsuleController = @"cartCapsuleController";

#pragma mark - notifications

static NSString *const NGNControllerNotificationDataWasLoaded = @"dataWasLoaded";
static NSString *const NGNControllerNotificationGoodsWasLoaded = @"goodsWasLoaded";
static NSString *const NGNControllerNotificationUserWasLoaded = @"userWasLoaded";
static NSString *const NGNControllerNotificationOrdersWasLoaded = @"ordersWasLoaded";
static NSString *const NGNControllerNotificationGoodsOrdersWasLoaded = @"goodsOrdersWasLoaded";

#pragma mark - table cells


static NSString *const NGNControllerOrderCell = @"OrderCell";
static NSString *const NGNControllerMenuCell = @"MenuCell";
static NSString *const NGNControllerGoodsInListCell = @"GoodsInListCell";
static NSString *const NGNControllerAvialableGoodsInCartCell = @"AvialableGoodsInCartCell";
static NSString *const NGNControllerNotAvialableGoodsInCartCell = @"NotAvialableGoodsInCartCell";

#pragma mark - fonts parameters
static NSString *const NGNControllerHelveticaLightFont = @"Helvetica-Light";
static NSInteger const NGNControllerMenuFontHeight = 30;

@interface NGNCommonConstants : NSObject

+ (NSArray *)menuIcons;
+ (NSArray *)menuCellTitles;

@end
