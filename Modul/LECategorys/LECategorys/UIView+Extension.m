//
//  UIView+Extension.m
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 Lee. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

+ (instancetype)loadFromNibUsingClassName {
    NSString *nibName = [[NSStringFromClass(self) componentsSeparatedByString:@"."] firstObject];
    id view = [[[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil] lastObject];
    if (!view) {
        NSBundle *crrentBundle = [NSBundle bundleForClass:[self class]];
        view = [[crrentBundle loadNibNamed:nibName owner:nil options:nil] lastObject];
    }
    return view;
}

/**
 设置当前view的某个或者某几个角的圆角

 @param corners 需要设置的角
 @param cornerRadii 圆角的弧度
 @param rect 当前view的CGRect
 */
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii rect:(CGRect)rect {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 设置当前view的某个或者某几个角的圆角

 @param corners 需要设置的角
 @param cornerRadii 圆角的弧度
 注意：自动布局下由于self.bounds获取到的不正确，故而右边圆角会设置失败
 */
- (void)setRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    [self setRoundingCorners:corners cornerRadii:cornerRadii rect:self.bounds];
}

/**
 设置当前view的某个或者某几个角的圆角

 @param corners 需要设置的角
 @param radius 圆角的弧度
 @param size 当前view的宽高
 */
- (void)setRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius size:(CGSize)size {
    [self setRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius) rect:(CGRect){CGPointZero, size}];
}
@end
