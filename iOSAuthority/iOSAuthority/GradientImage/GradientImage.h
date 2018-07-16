//
//  GradientImage.h
//  BankOfCommunications
//
//  Created by zhaoyang on 2018/5/28.
//  Copyright © 2018年 P&C Information. All rights reserved.
//
// 用来生成渐变色图片
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GradientImageDirection) {
    GradientImageDirectionLeftToRight,          // 从左到右
    GradientImageDirectionTopToBottom,          // 从上到下
    GradientImageDirectionTopLeftToBottomRight, // 从左上到右下
    GradientImageDirectionBottoLeftToTopRight   // 从左下到右上
};

@interface GradientImage : NSObject


/** 生成渐变图片, 默认方向 从左到右
 *  @param size 图片大小
 *  @param colors 渐变颜色数组(两种)
 */
+ (UIImage *)gradientImageWithSize:(CGSize)size colors:(NSArray<UIColor *>*)colors;


/** 生成渐变图片
 *  @param size         图片大小
 *  @param colors       渐变颜色数组(两种)
 *  @param direction    渐变颜色方向
 */
+ (UIImage *)gradientImageWithSize:(CGSize)size colors:(NSArray<UIColor *>*)colors direction:(GradientImageDirection)direction;
@end
