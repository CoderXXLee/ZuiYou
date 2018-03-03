//
//  XXTransitionAnimation.m
//  ebm
//
//  Created by mac on 2017/5/29.
//  Copyright © 2017年 BM. All rights reserved.
//

#import "XXTransitionAnimation.h"
#import <LECommon.h>
#import "XXTransition.h"
#import <UIView+Extension.h>

///自定义Present动画
NSString *const _kXXPresentAnimation = @"kXXPresentAnimation";
NSString *const _kXXPresentScaleAnimation = @"kXXPresentScaleAnimation";
NSString *const _kXXPresentPullAnimation = @"kXXPresentPullAnimation";
NSString *const _kXXPresentPullToNavigationBarAnimation = @"kXXPresentPullToNavigationBarAnimation";

@implementation XXTransitionAnimation

/**
 初始化自定义动画
 */
+ (void)initPresentAnimation {
    [self presentAnimation];
    [self presentScaleAnimation];
    [self presentPullAnimation];
    [self presentPullToNavigationBarAnimation];
}

/**
 渐变动画
 */
+ (void)presentAnimation {
    NSString *transitionAnimation = _kXXPresentAnimation;
    [XXTransition addPresentAnimation:transitionAnimation animation:^(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration) {
        UIView *containerView = [transitionContext containerView];
        //        UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        //        UIView *tempView = [fromView snapshotViewAfterScreenUpdates:NO];
        //        fromView.hidden = YES;
        containerView.backgroundColor = [UIColor clearColor];
        //        containerView.frame = CGRectMake(0, 264, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

        //        [containerView addSubview:tempView];
        toView.alpha = 0;
        [containerView addSubview:toView];
        toView.frame = containerView.frame;

        LEMoveAnimation(^{
            toView.alpha = 1;
        }, ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        });

        //        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.5 animations:^{
        //                //                tempView.layer.transform = [weakSelf sinkTransformFirstPeriod];;
        //            }];
        //
        //            [UIView addKeyframeWithRelativeStartTime:.5 relativeDuration:.5 animations:^{
        //                //                tempView.layer.transform = [weakSelf sinkTransformSecondPeriod];
        //                toView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(toView.frame));
        //            }];
        //        } completion:^(BOOL finished) {
        //            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //        }];
    }];

    [XXTransition addDismissAnimation:transitionAnimation backGestureDirection:XXBackGestureNone animation:^(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration) {
        UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        UIView *tempView = [transitionContext containerView].subviews[0];

        LEMoveAnimation(^{
            fromView.alpha = 0;
        }, ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if (![transitionContext transitionWasCancelled]) {
                toView.hidden = NO;
                [tempView removeFromSuperview];
            }
        });

        //        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.5 animations:^{
        //                fromView.transform = CGAffineTransformIdentity;
        //                //                tempView.layer.transform = [weakSelf sinkTransformFirstPeriod];
        //            }];
        //
        //            [UIView addKeyframeWithRelativeStartTime:.5 relativeDuration:.5 animations:^{
        //                tempView.layer.transform = CATransform3DIdentity;
        //            }];
        //        } completion:^(BOOL finished) {
        //            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //            if (![transitionContext transitionWasCancelled]) {
        //                toView.hidden = NO;
        //                [tempView removeFromSuperview];
        //            }
        //        }];
    }];
}

/**
 渐变动画
 */
+ (void)presentScaleAnimation {
    NSString *transitionAnimation = _kXXPresentScaleAnimation;
    [XXTransition addPresentAnimation:transitionAnimation animation:^(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration) {
        UIView *containerView = [transitionContext containerView];
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;

        containerView.backgroundColor = [UIColor clearColor];

        toView.alpha = 0;
        [containerView addSubview:toView];
        toView.frame = containerView.frame;
        toView.transform = CGAffineTransformMakeScale(1.2, 1.2);

        LEMoveAnimation(^{
            toView.alpha = 1;
            toView.transform = CGAffineTransformIdentity;
        }, ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        });
    }];

    [XXTransition addDismissAnimation:transitionAnimation backGestureDirection:XXBackGestureNone animation:^(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration) {
        UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        UIView *tempView = [transitionContext containerView].subviews[0];

        LEMoveAnimation(^{
            fromView.alpha = 0;
            fromView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }, ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if (![transitionContext transitionWasCancelled]) {
                toView.hidden = NO;
                toView.transform = CGAffineTransformIdentity;
                [tempView removeFromSuperview];
            }
        });
    }];
}

/**
 由下往上动画
 */
+ (void)presentPullAnimation {
    NSString *transitionAnimation = _kXXPresentPullAnimation;
    [XXTransition addPresentAnimation:transitionAnimation animation:^(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration) {
        UIView *containerView = [transitionContext containerView];
//        UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        //        UIView *tempView = [fromView snapshotViewAfterScreenUpdates:NO];
        //        fromView.hidden = YES;
        containerView.backgroundColor = [UIColor clearColor];
//        CGFloat x = 64+40;
//        containerView.frame = CGRectMake(0, x, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-x);

        //        [containerView addSubview:tempView];
        [containerView addSubview:toView];
        toView.frame = containerView.bounds;
        toView.y = CGRectGetHeight(containerView.frame);

        LEMoveAnimation(^{
            toView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(toView.frame));
        }, ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        });

        //        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.5 animations:^{
        //                //                tempView.layer.transform = [weakSelf sinkTransformFirstPeriod];;
        //            }];
        //
        //            [UIView addKeyframeWithRelativeStartTime:.5 relativeDuration:.5 animations:^{
        //                //                tempView.layer.transform = [weakSelf sinkTransformSecondPeriod];
        //                toView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(toView.frame));
        //            }];
        //        } completion:^(BOOL finished) {
        //            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //        }];
    }];

    [XXTransition addDismissAnimation:transitionAnimation backGestureDirection:XXBackGestureNone animation:^(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration) {
        UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        UIView *tempView = [transitionContext containerView].subviews[0];

        LEMoveAnimation(^{
//            fromView.alpha = 0;
//            fromView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(fromView.frame));
            fromView.transform = CGAffineTransformIdentity;
        }, ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if (![transitionContext transitionWasCancelled]) {
                toView.hidden = NO;
                [tempView removeFromSuperview];
            }
        });

        //        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.5 animations:^{
        //                fromView.transform = CGAffineTransformIdentity;
        //                //                tempView.layer.transform = [weakSelf sinkTransformFirstPeriod];
        //            }];
        //
        //            [UIView addKeyframeWithRelativeStartTime:.5 relativeDuration:.5 animations:^{
        //                tempView.layer.transform = CATransform3DIdentity;
        //            }];
        //        } completion:^(BOOL finished) {
        //            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //            if (![transitionContext transitionWasCancelled]) {
        //                toView.hidden = NO;
        //                [tempView removeFromSuperview];
        //            }
        //        }];
    }];
}

/**
 由下往上，直至导航栏动画
 */
+ (void)presentPullToNavigationBarAnimation {
    NSString *transitionAnimation = _kXXPresentPullToNavigationBarAnimation;
    [XXTransition addPresentAnimation:transitionAnimation animation:^(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration) {
        UIView *containerView = [transitionContext containerView];
        //        UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        //        UIView *tempView = [fromView snapshotViewAfterScreenUpdates:NO];
        //        fromView.hidden = YES;
        containerView.backgroundColor = [UIColor clearColor];
//        CGFloat y = 64;
//        containerView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-y);

        //        [containerView addSubview:tempView];
        [containerView addSubview:toView];
        toView.frame = containerView.bounds;
        CGFloat y = 64;
        toView.y = CGRectGetHeight(containerView.frame);
        toView.height = CGRectGetHeight(containerView.frame) - y;

        LEMoveAnimation(^{
            toView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(toView.frame));
        }, ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        });

        //        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.5 animations:^{
        //                //                tempView.layer.transform = [weakSelf sinkTransformFirstPeriod];;
        //            }];
        //
        //            [UIView addKeyframeWithRelativeStartTime:.5 relativeDuration:.5 animations:^{
        //                //                tempView.layer.transform = [weakSelf sinkTransformSecondPeriod];
        //                toView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(toView.frame));
        //            }];
        //        } completion:^(BOOL finished) {
        //            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //        }];
    }];

    [XXTransition addDismissAnimation:transitionAnimation backGestureDirection:XXBackGestureNone animation:^(id<UIViewControllerContextTransitioning> transitionContext, NSTimeInterval duration) {
        UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
        UIView *tempView = [transitionContext containerView].subviews[0];

        LEMoveAnimation(^{
//            fromView.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(fromView.frame));
            fromView.transform = CGAffineTransformIdentity;
        }, ^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if (![transitionContext transitionWasCancelled]) {
                toView.hidden = NO;
                [tempView removeFromSuperview];
            }
        });

        //        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        //            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:.5 animations:^{
        //                fromView.transform = CGAffineTransformIdentity;
        //                //                tempView.layer.transform = [weakSelf sinkTransformFirstPeriod];
        //            }];
        //
        //            [UIView addKeyframeWithRelativeStartTime:.5 relativeDuration:.5 animations:^{
        //                tempView.layer.transform = CATransform3DIdentity;
        //            }];
        //        } completion:^(BOOL finished) {
        //            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //            if (![transitionContext transitionWasCancelled]) {
        //                toView.hidden = NO;
        //                [tempView removeFromSuperview];
        //            }
        //        }];
    }];
}

@end
