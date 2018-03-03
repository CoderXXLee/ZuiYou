//
//  LETabBarView.h
//  ZuiYou
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 le. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LETabBarView;

@protocol LETabBarDelegate <NSObject>

@optional
- (BOOL)tabBar:(LETabBarView *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to;

- (void)tabBar:(LETabBarView *)tabBar buttonClicked:(UIButton *)sender;

@end

@interface LETabBarView : UIView

@property (nonatomic, weak) id<LETabBarDelegate> delegate;

/**
 *  设置选中的按钮
 */
@property (nonatomic ,assign) NSInteger selectedIndex;

/**
 所有的按钮
 */
@property(nonatomic, strong, readonly) NSArray *tabBarButtons;

/**
 添加tabbar按钮
 */
- (void)addTabBarButtonWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selImageName normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor showBadge:(BOOL)show;

/**
 添加tabbar按钮
 */
- (void)addTabBarButtonWithTitles:(NSArray *)titles titleColor:(UIColor *)color selectedColor:(UIColor *)selColor andFont:(UIFont *)font;

/**
 按下标选中
 */
- (void)setSelectedTabBarWithIndex:(NSInteger)index;

@end
