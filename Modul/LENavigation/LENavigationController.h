//
//  LENavigationController.h
//  Pods
//
//  Created by mac on 2017/3/30.
//
//

#import <UIKit/UIKit.h>

//导航栏高度
#define NaivHeight 64

@interface LENavigationController : UINavigationController

/**
 设置导航栏阴影
 */
- (void)setupNaviShadow;

/**
 初始返回按钮图片
 */
- (void)initBackIndicatorImage:(UIImage *)backImage;

/*!
 *  是否禁止返回
 */
- (void)canPop:(BOOL)isCan;

/*!
 *  @brief  设置navigationBar的TintColor
 */
- (void)setNavigationBarWithTintColor:(UIColor *)color showShadow:(BOOL)show;

/**
 设置navigationBar的背景图片
 */
- (void)setNavigationBarWithBackgroundColor:(UIColor *)color showShadow:(BOOL)show;

/**
 关闭当前页面，跳转到应用内的某个页面
 */
- (void)redirectViewController:(UIViewController *)viewController animated:(BOOL)animated;

/**
 关闭level个页面，跳转到应用内的某个页面
 level：从当前页面往前推，取值范围：1~100
 */
- (void)redirectToViewController:(UIViewController *)viewController level:(NSUInteger)level animated:(BOOL)animated;

/**
 关闭当前页面以及之前的页面，跳转到应用内的某个页面
 返回时返回到rootViewController
 */
- (void)redirectAllToViewController:(UIViewController *)viewController animated:(BOOL)animated;

/*!
 *  @brief  返回到上level个控制器
 *
 *  @param level 取值范围：1~100
 *  @param animated 动画
 */
- (void)popToViewControllerOfLevel:(NSUInteger)level animated:(BOOL)animated;

@end
