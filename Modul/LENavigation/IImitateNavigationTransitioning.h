//
//  IImitateNavigationTransitioning.h
//  Pods
//
//  Created by mac on 2017/7/27.
//
//

#import <Foundation/Foundation.h>

@protocol IImitateNavigationTransitioning <NSObject>

/**
 自定义push动画
 */
- (void)pushAnimationFromController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC duration:(NSTimeInterval)duration completion:(void(^)(void))completion;

/**
 自定义pop动画
 */
- (void)popAnimationFromController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC duration:(NSTimeInterval)duration completion:(void(^)(void))completion;

@end
