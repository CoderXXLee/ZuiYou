//
//  UIWindow+le_Extension.m
//  Pods
//
//  Created by mac on 2017/8/19.
//
//

#import "UIWindow+le_Extension.h"

@implementation UIWindow (le_Extension)

/**
 获取顶部控制器
 */
- (UIViewController *)topMostController {
    UIViewController *topController = [self rootViewController];
    while ([topController presentedViewController])	{
        topController = [topController presentedViewController];
        if ([topController isKindOfClass:[UINavigationController class]]) break;
    }
    return topController;
}

/**
 获取正在显示的控制器
 */
- (UIViewController *)currentViewController {
    UIViewController *currentViewController = [self topMostController];

    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];

    return currentViewController;
}

@end
