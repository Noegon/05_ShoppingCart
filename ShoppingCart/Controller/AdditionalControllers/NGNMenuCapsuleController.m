//
//  NGNMenuCapsuleController.m
//  ShoppingCart
//
//  Created by Stafeyev Alexei on 02/08/2017.
//  Copyright © 2017 Alex. All rights reserved.
//

#import "NGNMenuCapsuleController.h"
#import "NGNCommonConstants.h"

#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>

static inline CIImage* ngn_contextCreateRoundedMask(CGRect rect, CGFloat radius_tl, CGFloat radius_tr, CGFloat radius_bl, CGFloat radius_br) {
    
    CGContextRef context;
    CGColorSpaceRef colorSpace;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a bitmap graphics context the size of the image
    context = CGBitmapContextCreate( NULL, rect.size.width, rect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast );
    
    // free the rgb colorspace
    CGColorSpaceRelease(colorSpace);
    
    if ( context == NULL ) {
        return NULL;
    }
    
    // cerate mask
    
    CGFloat minx = CGRectGetMinX(rect), midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect), midy = CGRectGetMidY(rect), maxy = CGRectGetMaxY(rect);
    
    CGContextBeginPath(context);
    CGContextSetGrayFillColor(context, 1.0, 0.0 );
    CGContextAddRect(context, rect);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetGrayFillColor( context, 1.0, 1.0 );
    CGContextBeginPath( context );
    CGContextMoveToPoint( context, minx, midy );
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius_bl);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius_br);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius_tr);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius_tl);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill );
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef bitmapContext = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // convert the finished resized image to a UIImage
    CIImage *theImage = [CIImage imageWithCGImage:bitmapContext];
    // image is retained by the property setting above, so we can
    // release the original
    CGImageRelease(bitmapContext);
    
    // return the image
    return theImage;
}

@implementation NGNMenuCapsuleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.alpha = 1;
    
    self.backgroundView.layer.shadowColor = [[UIColor colorWithRed:0.31 green:0.84 blue:0.92 alpha:1.0] CGColor];
    self.backgroundView.layer.shadowOffset = CGSizeMake(20, 0);
    self.backgroundView.layer.shadowRadius = 10;
    self.backgroundView.layer.shadowOpacity = 0.6;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView.layer.cornerRadius = 100;
    
    self.menuContainerView.backgroundColor = [UIColor clearColor];
    
//    // that works, but it is not what I need
//    CAGradientLayer *gradientMask = [CAGradientLayer layer];
//    gradientMask.frame = self.backgroundView.bounds;
//    gradientMask.colors = @[(id)[UIColor clearColor].CGColor,
//                            (id)[UIColor whiteColor].CGColor,
//                            (id)[UIColor whiteColor].CGColor,
//                            (id)[UIColor clearColor].CGColor];
//    gradientMask.locations = @[@0.0, @0.50, @0.50, @1.0];
//    self.backgroundView.layer.mask = gradientMask;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.menuContainerView.bounds;
    gradient.colors = @[(id)[UIColor whiteColor].CGColor,
                            (id)[UIColor redColor].CGColor,
                            (id)[UIColor redColor].CGColor,
                            (id)[UIColor whiteColor].CGColor];
    gradient.locations = @[@0.0, @0.50, @0.50, @1.0];
    gradient.cornerRadius = 100;
    [self.backgroundView.layer insertSublayer:gradient below:self.menuContainerView.layer];
    
    
    
//    // Create the mask image you need calling the previous function
//    CIImage *mask = ngn_contextCreateRoundedMask(self.menuContainerView.bounds, 0.0, 150.0, 0.0, 150.0);
//    
//    // Create a new layer that will work as a mask
//    CALayer *layerMask = [CALayer layer];
//    layerMask.frame = self.menuContainerView.bounds;
//    // Put the mask image as content of the layer
//    layerMask.contents = (id)mask.CGImage;
//    // set the mask layer as mask of the view layer
//    self.menuContainerView.layer.mask = layerMask;

    
//    // Create a bezier path with the required corners rounded
//    UIBezierPath *cornersPath = [UIBezierPath bezierPathWithRoundedRect:self.menuContainerView.bounds
//                                                      byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
//                                                            cornerRadii:CGSizeMake(50, 50)];
//    
//    //Create a new layer to use as a mask
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    
//    // Set the path of the layer
//    maskLayer.path = cornersPath.CGPath;
//    self.menuContainerView.layer.mask = maskLayer;
}

@end
