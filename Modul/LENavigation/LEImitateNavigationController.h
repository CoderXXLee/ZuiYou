//
//  LEImitateNavigationVC.h
//  Pods
//
//  Created by mac on 2017/7/27.
//
//  使用UIViewController仿UINavigationViewController

#import <UIKit/UIKit.h>
@protocol IImitateNavigationTransitioning, IImitateNavigationBar;

///push或者pop后调用的block
typedef void(^bLECNavigationPushPop)(UIViewController *from, UIViewController *to);

@interface LEImitateNavigationController : UIViewController

/**
 子控制器
 */
@property (nonatomic, copy) NSArray<UIViewController<IImitateNavigationTransitioning> *> *viewControllers;

/**
 展示中的控制器
 */
@property (nonatomic, readonly, strong) UIViewController *visibleViewController;
//@property (nonatomic, readonly) UINavigationBar *navigationBar;

/**
 顶部控制器
 */
@property (nonatomic, readonly, strong) UIViewController *topViewController;
//@property (nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;

/**
 rootViewController
 */
@property(nonatomic, strong, readonly) UIViewController *rootViewController;

/**
 外部navigationBar控制器
 */
@property(nonatomic, weak) UIViewController *navigationBarVC;
@property(nonatomic, weak) __kindof UIView<IImitateNavigationBar> *navigationBar;

/**
 将要pop事件时的回调
 */
@property(nonatomic, copy) bLECNavigationPushPop bWillPop;

/**
 将要push事件时的回调
 */
@property(nonatomic, copy) bLECNavigationPushPop bWillPush;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;
- (void)setViewControllers:(NSArray<UIViewController<IImitateNavigationTransitioning> *> *)newViewControllers animated:(BOOL)animated;

/**
 push
 */
- (void)pushViewController:(UIViewController<IImitateNavigationTransitioning> *)viewController animated:(BOOL)animated;

/**
 pop
 */
- (UIViewController *)popViewControllerAnimated:(BOOL)animated;
- (NSArray *)popToViewController:(UIViewController<IImitateNavigationTransitioning> *)viewController animated:(BOOL)animated;
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated;

/**
 关闭当前页面，跳转到应用内的某个页面
 */
- (void)redirectViewController:(UIViewController<IImitateNavigationTransitioning> *)viewController animated:(BOOL)animated;

/**
 push时调用的block
 */
- (void)didPushWithBlock:(bLECNavigationPushPop)didPushBlock;

/**
 pop时调用的block
 */
- (void)didPopWithBlock:(bLECNavigationPushPop)didPopBlock;

@end
