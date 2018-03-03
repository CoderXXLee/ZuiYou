//
//  UIView+Extension.h
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

+ (instancetype)loadFromNibUsingClassName;

/**
 设置当前view的某个或者某几个角的圆角

 @param corners 需要设置的角
 @param cornerRadii 圆角的弧度
 @param rect 当前view的CGRect
 */
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii rect:(CGRect)rect;

/**
 设置当前view的某个或者某几个角的圆角

 @param corners 需要设置的角
 @param cornerRadii 圆角的弧度
 注意：自动布局下由于self.bounds获取到的不正确，故而右边圆角会设置失败
 */
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 设置当前view的某个或者某几个角的圆角

 @param corners 需要设置的角
 @param radius 圆角的弧度
 @param size 当前view的宽高
 */
- (void)setRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius size:(CGSize)size;
@end
