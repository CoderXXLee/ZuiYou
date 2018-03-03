//
//  LEPageViewController.h
//  CreditAddressBookEE
//
//  Created by LE on 16/2/16.
//  Copyright © 2016年 Lee. All rights reserved.
//
/*!
 *  @brief  对UIPageViewController的封装使用
 */
#import <UIKit/UIKit.h>
#import "WMMenuView.h"

typedef void(^LEControllerChanged)(NSInteger selectedIndex);

@interface LESysPageVC : UIViewController

@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, strong, readonly) NSArray *controllers;

/**
 *  是否作为 NavigationBar 的 titleView 展示，默认 NO
 *  Whether to show on navigation bar, the default value is `NO`
 */
@property (assign, nonatomic) BOOL showOnNavigationBar;

/**
 *  点击的 MenuItem 是否触发滚动动画
 *  默认为NO
 */
@property (nonatomic, assign) BOOL pageAnimatable;


/** 设置是否可以滚动. Default is YES. */
@property (nonatomic, assign) BOOL scrollEnable;

/**
 以回调的形式自定义设置WMMenuView的属性
 */
@property(nonatomic, copy) void(^bSetMenuViewProperty)(WMMenuView *menuView);

/**
 WMMenuView背景色
 */
@property(nonatomic, strong) UIColor *menuViewBackgroundColor;

/**
 自定义WMMenuView的frame
 */
@property(nonatomic, assign) CGRect menuViewFrame;

/**
 弹簧效果
 默认为NO
 */
//@property(nonatomic, assign) BOOL bounces;

/**
 *  Menu view 的样式，默认为无下划线
 *  Menu view's style, now has two different styles, 'Line','default'
 */
@property (nonatomic, assign) WMMenuViewStyle menuViewStyle;

@property (nonatomic, assign) WMMenuViewLayoutMode menuViewLayoutMode;

/** 下划线进度条的高度 */
@property (nonatomic, assign) CGFloat progressHeight;

/** MenuView 内部视图与左右的间距 */
@property (nonatomic, assign) CGFloat menuViewContentMargin;

/** progressView 到 menuView 底部的距离 */
@property (nonatomic, assign) CGFloat progressViewBottomSpace;

/**
 *  定制进度条在各个 item 下的宽度
 */
@property (nonatomic, strong) NSArray *progressViewWidths;

/**
 *  Menu view items' margin / make sure it's count is equal to (controllers' count + 1),default is 0
 顶部菜单栏各个 item 的间隙，因为包括头尾两端，所以确保它的数量等于控制器数量 + 1, 默认间隙为 0
 */
@property (nonatomic, copy) NSArray<NSNumber *> *itemsMargins;

/**
 *  set itemMargin if all margins are the same, default is 0
 如果各个间隙都想同，设置该属性，默认为 0
 */
@property (nonatomic, assign) CGFloat itemMargin;

/**
 *  每个 MenuItem 的宽度
 *  The item width,when all are same,use this property
 */
@property (nonatomic, assign) CGFloat menuItemWidth;

/**
 *  各个 MenuItem 的宽度，可不等，数组内为 NSNumber.
 *  Each item's width, when they are not all the same, use this property, Put `NSNumber` in this array.
 */
@property (nonatomic, copy) NSArray<NSNumber *> *itemsWidths;

/** 是否自动通过字符串计算 MenuItem 的宽度，默认为 NO. */
@property (nonatomic, assign) BOOL automaticallyCalculatesItemWidths;

/// 调皮效果，用于实现腾讯视频新效果，请设置一个较小的 progressWidth
@property (nonatomic, assign) BOOL progressViewIsNaughty;

/** progressView's cornerRadius */
@property (nonatomic, assign) CGFloat progressViewCornerRadius;

/**
 *  标题的字体名字
 *  The name of title's font
 */
@property (nonatomic, copy) NSString *titleFontName;

/**
 *  选中时的标题尺寸
 *  The title size when selected (animatable)
 */
@property (nonatomic, assign) CGFloat titleSizeSelected;

/**
 *  非选中时的标题尺寸
 *  The normal title size (animatable)
 */
@property (nonatomic, assign) CGFloat titleSizeNormal;

/**
 *  标题选中时的颜色, 颜色是可动画的.
 *  The title color when selected, the color is animatable.
 */
@property (nonatomic, strong) UIColor *titleColorSelected;

/**
 *  标题非选择时的颜色, 颜色是可动画的.
 *  The title's normal color, the color is animatable.
 */
@property (nonatomic, strong) UIColor *titleColorNormal;

/**
 *  进度条的颜色，默认和选中颜色一致(如果 style 为 Default，则该属性无用)
 *  The progress's color,the default color is same with `titleColorSelected`.If you want to have a different color, set this property.
 */
@property (nonatomic, strong) UIColor *progressColor;

/**
 滑动回调
 */
@property(nonatomic, copy) void(^bLEPageVCDidScroll)(CGPoint contentOffset);

/**
 初始化
 */
- (instancetype)initWithControllers:(NSArray *)controllers controllerChanged:(LEControllerChanged)controllerChanged;

/**
 移动到父类控制器
 */
- (void)moveToParentViewController:(UIViewController *)parentVC;

/**
 移动到指定控制器
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

/**
 *  Update designated item's title
 更新指定序号的控制器的标题
 *
 *  @param title 新的标题
 *  @param index 目标序号
 */
- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index;

/**
 *  Update designated item's title and width
 更新指定序号的控制器的标题以及他的宽度
 *
 *  @param title 新的标题
 *  @param index 目标序号
 *  @param width 对应item的新宽度
 */
- (void)updateTitle:(NSString *)title andWidth:(CGFloat)width atIndex:(NSInteger)index;

- (void)updateAttributeTitle:(NSAttributedString *)title atIndex:(NSInteger)index;

@end
