//
//  GradientImage.m
//  BankOfCommunications
//
//  Created by zhaoyang on 2018/5/28.
//  Copyright © 2018年 P&C Information. All rights reserved.
//

#import "GradientImage.h"

@implementation GradientImage

+ (UIImage *)gradientImageWithSize:(CGSize)size colors:(NSArray<UIColor *> *)colors  {
    return [self gradientImageWithSize:size colors:colors direction:GradientImageDirectionLeftToRight];
}


+ (UIImage *)gradientImageWithSize:(CGSize)size colors:(NSArray<UIColor *> *)colors direction:(GradientImageDirection)direction {
    NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:0];
    if (colors.count > 1) {
        [colorArray addObject:(UIColor *)colors[0].CGColor];
        [colorArray addObject:(UIColor *)colors[1].CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorArray, NULL);
    CGPoint start = [self setStartPointWithDirection:direction size:size];
    CGPoint end = [self setEndPointWithDirection:direction size:size];
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}


+ (CGPoint)setStartPointWithDirection:(GradientImageDirection)direction size:(CGSize)size {
    CGPoint start = CGPointZero;
    switch (direction) {
        case GradientImageDirectionLeftToRight:
            start = CGPointMake(0.0, 0.0);
            break;
        case GradientImageDirectionTopToBottom:
            start = CGPointMake(0.0, 0.0);
            break;
        case GradientImageDirectionTopLeftToBottomRight:
            start = CGPointMake(0.0, 0.0);
            break;
        case GradientImageDirectionBottoLeftToTopRight:
            start = CGPointMake(0.0, size.height);
            break;
    }
    
    return start;
    
}


+ (CGPoint)setEndPointWithDirection:(GradientImageDirection)direction size:(CGSize)size {
    CGPoint end = CGPointZero;
    switch (direction) {
        case GradientImageDirectionLeftToRight:
            end = CGPointMake(size.width, 0.0);
            break;
        case GradientImageDirectionTopToBottom:
            end = CGPointMake(0.0, size.height);
            break;
        case GradientImageDirectionTopLeftToBottomRight:
            end = CGPointMake(size.width, size.height);
            break;
        case GradientImageDirectionBottoLeftToTopRight:
            end = CGPointMake(size.width, 0.0);
            break;
    }
    return end;
}

@end
