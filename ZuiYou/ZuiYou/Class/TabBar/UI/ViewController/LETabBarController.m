//
//  LETabBarController.m
//  ZuiYou
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 le. All rights reserved.
//

#import "LETabBarController.h"
#import "LETabBarView.h"
#import <LENavigationController.h>
#import <LECommon.h>
#import "ZYFeaturedVC.h"

@interface LETabBarController ()<UITabBarControllerDelegate, LETabBarDelegate>

@property(nonatomic, weak) LETabBarView *tabBarView;

@end

@implementation LETabBarController

#pragma mark - LazyLoad
#pragma mark - Super

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self setupControllers];
    [self addTabBar];
}

#pragma mark - Init

/**
 初始化
 */
- (void)initUI {
    self.delegate = self;
    self.selectedIndex = 0;
    self.hidesBottomBarWhenPushed = NO;
    self.view.backgroundColor = [UIColor whiteColor];
}

/**
 设置控制器
 */
- (void)setupControllers {
    ZYFeaturedVC *newVC = [[ZYFeaturedVC alloc] init];
    newVC.title = @"最右";
    LENavigationController *rootNav = [[LENavigationController alloc] initWithRootViewController:newVC];

    UIViewController *person = [[UIViewController alloc] init];
    person.title = @"跟拍";
    LENavigationController *menuNav = [[LENavigationController alloc]initWithRootViewController:person];

    ///产品服务
    UIViewController *productVC = [[UIViewController alloc] init];
    productVC.title = @"话题";
    LENavigationController *serviceNav = [[LENavigationController alloc] initWithRootViewController:productVC];

    ///我的订单
    UIViewController *order = [[UIViewController alloc] init];
    order.title = @"消息";
    LENavigationController *orderNav = [[LENavigationController alloc] initWithRootViewController:order];

    ///我的订单
    UIViewController *me = [[UIViewController alloc] init];
    me.title = @"我的";
    LENavigationController *meNav = [[LENavigationController alloc] initWithRootViewController:me];

    self.viewControllers = @[rootNav, menuNav, serviceNav, orderNav, meNav];
}

/**
 添加tabbar
 */
- (void)addTabBar {
    LETabBarView *tabBarView = [[LETabBarView alloc] init];
    tabBarView.frame = self.tabBar.bounds;
    tabBarView.delegate = self;
    [self.tabBar addSubview:tabBarView];
    [self.tabBar bringSubviewToFront:tabBarView];
    self.tabBarView = tabBarView;
    tabBarView.backgroundColor = [UIColor whiteColor];

    [tabBarView addTabBarButtonWithTitle:@"最右" imageName:@"tabbar_featured" selectedImageName:@"tabbar_featured_hl" normalColor:[UIColor blackColor] selectedColor:LEColor(36, 160, 252, 1) showBadge:NO];
    [tabBarView addTabBarButtonWithTitle:@"跟拍" imageName:@"tabbar_follow" selectedImageName:@"tabbar_follow_hl" normalColor:[UIColor blackColor] selectedColor:LEColor(36, 160, 252, 1) showBadge:NO];
    [tabBarView addTabBarButtonWithTitle:@"话题" imageName:@"tabbar_explore" selectedImageName:@"tabbar_explore_hl" normalColor:[UIColor blackColor] selectedColor:LEColor(36, 160, 252, 1) showBadge:NO];
    [tabBarView addTabBarButtonWithTitle:@"消息" imageName:@"tabbar_remind" selectedImageName:@"tabbar_remind_hl" normalColor:[UIColor blackColor] selectedColor:LEColor(36, 160, 252, 1) showBadge:NO];
    [tabBarView addTabBarButtonWithTitle:@"我的" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_hl" normalColor:[UIColor blackColor] selectedColor:LEColor(36, 160, 252, 1) showBadge:NO];
}

#pragma mark - PublicMethod

/**
 设置选中的item
 */
- (void)le_setSelectedIndex:(NSUInteger)selectedIndex {
    NSAssert(selectedIndex<=(self.viewControllers.count-1), @"设置UITabBar越界");
    self.selectedIndex = selectedIndex;
    [self.tabBarView setSelectedTabBarWithIndex:selectedIndex];

    ///设置appdelegate中的rootNavi
//    UINavigationController *selectedNavi = self.viewControllers[selectedIndex];
//    ((AppDelegate *)[UIApplication sharedApplication].delegate).rootNavi = selectedNavi;
}

#pragma mark - PrivateMethod
#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate

- (BOOL)tabBar:(LETabBarView *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
//    LETabBarView *btn = tabBar.tabBarButtons[to];
////    [btn setBadge:0 key:@"nBMTabBarOrder"];
//
//    BMUser *user = [LEUserTool userData].user;
//    if ((to != 0) && !user) {
//        [self selectedLoginController];
//        return NO;
//    } else {
//        ///设置选中的控制器
//        self.selectedIndex = to;
//
//        if ([self.tabBarDelegate respondsToSelector:@selector(tabBar:didSelectTo:)]) {
//            [self.tabBarDelegate tabBar:tabBar didSelectTo:to];
//        }
//
//        NSAssert(to<=(self.viewControllers.count-1), @"设置UITabBar越界");
//        ///设置appdelegate中的rootNavi
//        UINavigationController *selectedNavi = self.viewControllers[to];
////        ((AppDelegate *)[UIApplication sharedApplication].delegate).rootNavi = selectedNavi;
//
//        return YES;
//    }
    return YES;
}

- (void)tabBar:(LETabBarView *)tabBar buttonClicked:(UIButton *)sender {

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    //    NSInteger index = [self.viewControllers indexOfObject:viewController];
}

#pragma mark - StateMachine

@end
