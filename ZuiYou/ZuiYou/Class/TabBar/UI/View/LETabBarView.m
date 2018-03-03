//
//  LETabBarView.m
//  ZuiYou
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 le. All rights reserved.
//

#import "LETabBarView.h"
#import "LETabBarButton.h"
#import "LEButton.h"
#import "UIView+LEBadge.h"

@interface LETabBarView ()

@property (nonatomic, weak) UIButton *selectedBtn;
@property(nonatomic, strong) NSMutableArray *subTabBarButtons;///按钮数组

@end

@implementation LETabBarView

#pragma mark - LazyLoad

- (NSMutableArray *)subTabBarButtons {
    if (!_subTabBarButtons) {
        _subTabBarButtons = [NSMutableArray array];
    }
    return _subTabBarButtons;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;

    if (self.subviews.count > 0) {
        [self selectButtonWithIndex:selectedIndex - 1];
    }
}

- (NSArray *)tabBarButtons {
    return [self.subTabBarButtons mutableCopy];
}

#pragma mark - Super

/**
 *  使用addsubview方法时调用该方法,设置tabBarButton的frame,ios9中当所有子view添加完成后才调用
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat count = self.subviews.count;
    CGFloat tabBarW = self.frame.size.width/count;
    CGFloat tabBarH = self.frame.size.height;
    CGFloat tabBarY = 0;
    for (int i = 0; i < count; i++) {
        UIButton *tabBtn = self.subviews[i];
        tabBtn.tag = i;
        CGFloat tabBarX = tabBarW * i;
        tabBtn.frame = CGRectMake(tabBarX, tabBarY, tabBarW, tabBarH);
    }
}

#pragma mark - Init
#pragma mark - PublicMethod

/**
 添加tabbar按钮
 */
- (void)addTabBarButtonWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selImageName normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor showBadge:(BOOL)show {
    LETabBarButton *tabBtn = [[LETabBarButton alloc] init];
    [tabBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selImageName) {
        [tabBtn setImage:[UIImage imageNamed:selImageName] forState:UIControlStateSelected];
    }
    [tabBtn setTitle:title forState:UIControlStateNormal];
    [tabBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [tabBtn setTitleColor:selectedColor  forState:UIControlStateSelected];
    [tabBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tabBtn];
    [self layoutSubviews];
    [self.subTabBarButtons addObject:tabBtn];

    if (_selectedIndex < 1) {
        _selectedIndex = 1;//设置默认选中第2个按钮
    }
    if (self.subviews.count == _selectedIndex) {
        [self buttonClicked:tabBtn];
    }
    if (show) {
        [tabBtn addBadgeHUDWithScale:.3 point:CGPointMake(-CGRectGetWidth(tabBtn.frame)/2, 2) NotificationKey:@"nBMTabBarOrder"];
        [[tabBtn notificationHubWithKey:@"nBMTabBarOrder"] setCircleColor:[UIColor redColor] labelColor:[UIColor redColor]];
    }
}

/**
 添加tabbar按钮
 */
- (void)addTabBarButtonWithTitles:(NSArray *)titles titleColor:(UIColor *)color selectedColor:(UIColor *)selColor andFont:(UIFont *)font {
    //    CGFloat count = titles.count;
    //    CGFloat tabBarW = self.frame.size.width/count;
    //    CGFloat tabBarH = self.frame.size.height;
    for (NSString *title in titles) {
        LEButton *btn = [[LEButton alloc] init];
        btn.titleLabel.font = font;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:selColor forState:UIControlStateSelected];
        [btn setTitleColor:color forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self layoutSubviews];

        if (_selectedIndex < 1) {
            _selectedIndex = 1;
        }
        if (self.subviews.count == _selectedIndex) {
            [self buttonClicked:btn];
        }
    }
}

/**
 按下标选中
 */
- (void)setSelectedTabBarWithIndex:(NSInteger)index {
    UIButton *btn = [self viewWithTag:index];
    if (btn) {
        self.selectedBtn.selected = NO;
        btn.selected = YES;
        self.selectedBtn = btn;
    }
//    for (UIButton *btn in self.subviews) {
//        if (btn.tag == index) {
//            self.selectedBtn.selected = NO;
//            btn.selected = YES;
//            self.selectedBtn = btn;
//        }
//    }
}

#pragma mark - PrivateMethod

/**
 按钮点击代理回调
 */
- (void)selectButtonWithIndex:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:self.selectedBtn.tag to:index];
    }
}

#pragma mark - Events

/**
 按钮点击事件
 */
- (void)buttonClicked:(UIButton *)sender {
    BOOL result = NO;
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        result = [self.delegate tabBar:self didSelectButtonFrom:self.selectedBtn.tag to:sender.tag];
    }
    if (result) {
        //设置按钮选中状态
        self.selectedBtn.selected = NO;
        sender.selected = YES;
        self.selectedBtn = sender;
    }
}

#pragma mark - LoadFromService
#pragma mark - Delegate


@end
