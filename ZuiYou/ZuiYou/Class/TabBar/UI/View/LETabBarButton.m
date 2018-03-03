//
//  LETabBarButton.m
//  ZuiYou
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 le. All rights reserved.
//

#import "LETabBarButton.h"

static const CGFloat LETabBarButtonImageRatio = 0.6;

@implementation LETabBarButton

#pragma mark - LazyLoad
#pragma mark - Super

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = LETabBarTitleFont;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = LETabBarTitleFont;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width/2;
    CGFloat imageH = (contentRect.size.height + 4) * LETabBarButtonImageRatio;
    return CGRectMake((contentRect.size.width-imageW)/2.f, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleW = contentRect.size.width;
    CGFloat imageH = (contentRect.size.height) * LETabBarButtonImageRatio;
    CGFloat titleY = imageH;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

#pragma mark - Init
#pragma mark - PublicMethod
#pragma mark - PrivateMethod
#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end
