//
//  LEPageViewController.h
//  ebm_driver
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 ebm. All rights reserved.
//

#import "WMPageController.h"
@class BMSegmentView;

typedef void(^LEControllerChanged)(NSInteger selectedIndex);

@interface LEPageViewController : WMPageController

/**
 调用initDefaultWithController:titles:subControllers:controllerChanged
 创建的pagevc带有的segmentView
 */
@property(nonatomic, weak, readonly) BMSegmentView *segmentView;

/**
 按下标选中对应子控制器
 */
@property(nonatomic, assign) int selectedIndex;

/**
 子控制器
 */
@property(nonatomic, strong, readonly) NSArray *controllers;

/**
 滑动回调
 */
@property(nonatomic, copy) void(^bLEPageVCDidScroll)(CGPoint contentOffset);

/**
 设置背景色
 默认透明
 */
@property(nonatomic, strong) UIColor *backgroundColor;

/**
 创建
 */
- (instancetype)initWithControllers:(NSArray *)controllers controllerChanged:(LEControllerChanged)controllerChanged;

/**
 创建
 */
- (instancetype)initWithControllers:(NSArray *)controllers menuViewStyle:(WMMenuViewStyle)menuViewStyle controllerChanged:(LEControllerChanged)controllerChanged;

/**
 创建带有BMSegmentView的pageVC
 */
- (instancetype)initBMWithController:(UIViewController *)vc titles:(NSArray *)titles subControllers:(NSArray *)controllers controllerChanged:(LEControllerChanged)controllerChanged;

/**
 移动到父类控制器
 */
- (void)moveToParentViewController:(UIViewController *)parentVC;

@end
