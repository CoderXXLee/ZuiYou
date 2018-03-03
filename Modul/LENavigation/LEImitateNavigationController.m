//
//  LEImitateNavigationController.m
//  Pods
//
//  Created by mac on 2017/7/27.
//
//

#import "LEImitateNavigationController.h"
#import "IImitateNavigationTransitioning.h"
#import "IImitateNavigationBar.h"
#import <UIView+AutoLayout.h>

///切换到主线程
#define dispatch_main_sync_safe_Navi(block)\
if ([NSThread isMainThread]) {\
block();\
}\
else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

///地图延长的长度
CGFloat LEMapExtendLength = 200;

@interface LEImitateNavigationController ()

@property(nonatomic, copy) bLECNavigationPushPop bDidPush;
@property(nonatomic, copy) bLECNavigationPushPop bDidPop;

@end

@implementation LEImitateNavigationController  {
    UIViewController *_rootViewController;
    UIViewController<IImitateNavigationTransitioning> *_visibleViewController;///目前正在显示的控制器
    BOOL _needsDeferredUpdate;
    BOOL _isUpdating;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    NSAssert(rootViewController, @"rootViewController不能为空");
    if ((self = [super initWithNibName:nil bundle:nil])) {
        //        self.viewControllers = @[rootViewController];
        _rootViewController = rootViewController;
    }
    return self;
}

- (void)dealloc {

}

- (void)loadView {
    [super loadView];

    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.view.clipsToBounds = YES;

    [_rootViewController willMoveToParentViewController:self];
    [self addChildViewController:_rootViewController];
    [self.view addSubview:_rootViewController.view];
    [_rootViewController didMoveToParentViewController:self];
//        _rootViewController.view.frame = self.view.bounds;
//        _rootViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_rootViewController.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(-LEMapExtendLength, 0, -LEMapExtendLength, 0)];

    //    CGRect navbarRect;
    //    CGRect contentRect;
    //    CGRect toolbarRect;
    //    [self _getNavbarRect:&navbarRect contentRect:&contentRect toolbarRect:&toolbarRect forBounds:self.view.bounds];

    //    _navigationBar.frame = navbarRect;
    //    _visibleViewController.view.frame = contentRect;

    //    _navigationBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    //    _visibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    //    [self.view addSubview:_visibleViewController.view];
    //    [self.view addSubview:_navigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_rootViewController beginAppearanceTransition:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_rootViewController endAppearanceTransition];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_rootViewController beginAppearanceTransition:NO animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_rootViewController endAppearanceTransition];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)_setNeedsDeferredUpdate {
    _needsDeferredUpdate = YES;
    [self.view setNeedsLayout];
}

- (void)_getNavbarRect:(CGRect *)navbarRect contentRect:(CGRect *)contentRect toolbarRect:(CGRect *)toolbarRect forBounds:(CGRect)bounds {

    //    const CGRect navbar = CGRectMake(CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetWidth(bounds), _navigationBar.frame.size.height);
    CGRect content = bounds;

    //    if (!self.navigationBarHidden) {
    //        content.origin.y += CGRectGetHeight(navbar);
    //        content.size.height -= CGRectGetHeight(navbar);
    //    }

    //    if (navbarRect)  *navbarRect = navbar;
    if (contentRect) *contentRect = content;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (_needsDeferredUpdate) {
        _needsDeferredUpdate = NO;
        [self _updateVisibleViewController:NO];
    }
}

- (void)setViewControllers:(NSArray<UIViewController<IImitateNavigationTransitioning> *> *)newViewControllers animated:(BOOL)animated {
    assert([newViewControllers count] >= 1);

    if (![newViewControllers isEqualToArray:self.viewControllers]) {
        // find the controllers we used to have that we won't be using anymore
        NSMutableArray *removeViewControllers = [self.viewControllers mutableCopy];
        [removeViewControllers removeObjectsInArray:newViewControllers];
        [removeViewControllers removeObject:_rootViewController];

        // these view controllers are not in the new collection, so we must remove them as children
        // I'm pretty sure the real UIKit doesn't attempt to be so clever..
        for (UIViewController *controller in removeViewControllers) {
            [controller willMoveToParentViewController:nil];
            [controller removeFromParentViewController];
        }

        // reset the nav bar
        //        _navigationBar.items = nil;

        // add them back in one-by-one and only apply animation to the last one (if any)
        for (UIViewController<IImitateNavigationTransitioning> *controller in newViewControllers) {
            [self pushViewController:controller animated:(animated && (controller == [newViewControllers lastObject]))];
        }
    }
}

- (NSArray<UIViewController<IImitateNavigationTransitioning> *> *)viewControllers {
    return [self.childViewControllers copy];
}

- (void)setViewControllers:(NSArray<UIViewController<IImitateNavigationTransitioning> *> *)newViewControllers {
    [self setViewControllers:newViewControllers animated:NO];
}

- (UIViewController *)topViewController {
    return [self.childViewControllers lastObject];
}

- (void)_updateVisibleViewController:(BOOL)animated {
    UIViewController<IImitateNavigationTransitioning> *oldVisibleViewController = _visibleViewController;
    const BOOL isPushing = (_visibleViewController == nil || oldVisibleViewController.parentViewController != nil);
    [self _updateVisibleViewControllerWithPush:isPushing animated:animated completion:^{}];
}

- (void)_updateVisibleViewControllerWithPush:(BOOL)isPush animated:(BOOL)animated completion:(void(^)(void))completion {
    _isUpdating = YES;

    //    UIViewController<IImitateNavigationTransitioning> *newVisibleViewController = isPush?(UIViewController<IImitateNavigationTransitioning> *)self.topViewController:(UIViewController<IImitateNavigationTransitioning> *)self.childViewControllers[self.childViewControllers.count-2];
    UIViewController<IImitateNavigationTransitioning> *newVisibleViewController = (UIViewController<IImitateNavigationTransitioning> *)self.topViewController;
    UIViewController<IImitateNavigationTransitioning> *oldVisibleViewController = _visibleViewController;

    //    const BOOL isPushing = (_visibleViewController == nil || oldVisibleViewController.parentViewController != nil);

    newVisibleViewController.view.userInteractionEnabled = NO;
    oldVisibleViewController.view.userInteractionEnabled = NO;

    _visibleViewController = newVisibleViewController;

    [oldVisibleViewController beginAppearanceTransition:NO animated:animated];
    [newVisibleViewController beginAppearanceTransition:YES animated:animated];

    if (newVisibleViewController == _rootViewController) {
        [newVisibleViewController endAppearanceTransition];
        newVisibleViewController = nil;
    }
    if (oldVisibleViewController == _rootViewController) {
        [oldVisibleViewController endAppearanceTransition];
        oldVisibleViewController = nil;
    }


    newVisibleViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:newVisibleViewController.view atIndex:2];

    if (isPush) {
        if ([newVisibleViewController respondsToSelector:@selector(pushAnimationFromController:toViewController:duration:completion:)]) {
            [newVisibleViewController pushAnimationFromController:oldVisibleViewController toViewController:newVisibleViewController duration:animated?0.33:0 completion:^{
                dispatch_main_sync_safe_Navi(^{
                    newVisibleViewController.view.userInteractionEnabled = YES;
                    oldVisibleViewController.view.userInteractionEnabled = YES;

                    //                         _navigationBar.hidden = _navigationBarHidden;
                    [oldVisibleViewController endAppearanceTransition];
                    [newVisibleViewController endAppearanceTransition];

                    ///不知为何
                    if (!oldVisibleViewController) {
                        //                    [newVisibleViewController viewDidAppear:animated];
                    }
                    //                [oldVisibleViewController viewDidDisappear:animated];

                    [oldVisibleViewController.view removeFromSuperview];
                    [oldVisibleViewController didMoveToParentViewController:nil];
                    [newVisibleViewController didMoveToParentViewController:self];
                    //                if (oldVisibleViewController && isPushing) {
                    //                    [oldVisibleViewController didMoveToParentViewController:nil];
                    //                } else {
                    //                    [newVisibleViewController didMoveToParentViewController:self];
                    //                }
                    _isUpdating = NO;
                    completion();
                });
            }];
        } else {
            dispatch_main_sync_safe_Navi(^{
                newVisibleViewController.view.userInteractionEnabled = YES;
                oldVisibleViewController.view.userInteractionEnabled = YES;

                [oldVisibleViewController endAppearanceTransition];
                [newVisibleViewController endAppearanceTransition];

                ///不知为何
                if (!oldVisibleViewController) {
                    //                    [newVisibleViewController viewDidAppear:animated];
                }
                //                [oldVisibleViewController viewDidDisappear:animated];

                [oldVisibleViewController.view removeFromSuperview];
                [oldVisibleViewController didMoveToParentViewController:nil];
                [newVisibleViewController didMoveToParentViewController:self];
                _isUpdating = NO;
            });
        }
    } else {
        if ([oldVisibleViewController respondsToSelector:@selector(popAnimationFromController:toViewController:duration:completion:)]) {
            [oldVisibleViewController popAnimationFromController:oldVisibleViewController toViewController:newVisibleViewController duration:animated?0.33:0 completion:^{
                dispatch_main_sync_safe_Navi(^{
                    newVisibleViewController.view.userInteractionEnabled = YES;
                    oldVisibleViewController.view.userInteractionEnabled = YES;

                    //                         _navigationBar.hidden = _navigationBarHidden;
                    [oldVisibleViewController endAppearanceTransition];
                    [newVisibleViewController endAppearanceTransition];

                    //                [newVisibleViewController viewDidAppear:animated];
                    //                [oldVisibleViewController viewDidDisappear:animated];

                    [oldVisibleViewController.view removeFromSuperview];
                    //                [oldVisibleViewController removeFromParentViewController];
                    [oldVisibleViewController didMoveToParentViewController:nil];
                    [newVisibleViewController didMoveToParentViewController:self];
                    //                if (oldVisibleViewController && isPushing) {
                    //                    [oldVisibleViewController didMoveToParentViewController:nil];
                    //                } else {
                    //                    [newVisibleViewController didMoveToParentViewController:self];
                    //                }
                    _isUpdating = NO;
                    completion();
                });
            }];
        } else {
            dispatch_main_sync_safe_Navi(^{
                newVisibleViewController.view.userInteractionEnabled = YES;
                oldVisibleViewController.view.userInteractionEnabled = YES;

                //                         _navigationBar.hidden = _navigationBarHidden;
                [oldVisibleViewController endAppearanceTransition];
                [newVisibleViewController endAppearanceTransition];

                //                [newVisibleViewController viewDidAppear:animated];
                //                [oldVisibleViewController viewDidDisappear:animated];

                [oldVisibleViewController.view removeFromSuperview];
                //                [oldVisibleViewController removeFromParentViewController];
                [oldVisibleViewController didMoveToParentViewController:nil];
                [newVisibleViewController didMoveToParentViewController:self];
                //                if (oldVisibleViewController && isPushing) {
                //                    [oldVisibleViewController didMoveToParentViewController:nil];
                //                } else {
                //                    [newVisibleViewController didMoveToParentViewController:self];
                //                }
                _isUpdating = NO;
            });
        }
        //        if (!animated) {
        //            [oldVisibleViewController removeFromParentViewController];
        //        }
    }
}

- (void)pushViewController:(UIViewController<IImitateNavigationTransitioning> *)viewController animated:(BOOL)animated {
    assert(![viewController isKindOfClass:[UITabBarController class]]);
    assert(![self.viewControllers containsObject:viewController]);
    assert(viewController.parentViewController == nil || viewController.parentViewController == self);

    ///上一个push还未完成，不能进行push
    if (_isUpdating && animated) return;

    ///设置title
    id<IImitateNavigationBar> bar = self.navigationBar;
    if (bar && viewController.title) {
        bar.title = viewController.title;
    }

    UIViewController *tempVC = _visibleViewController;
    if (self.bWillPush) {
        self.bWillPush(tempVC, viewController);
    }

    //    UIViewController *newController = newController;
    //    [newController willMoveToParentViewController:self];
    //    [self addChildViewController:newController];
    //    [self.contentView addSubview:newController.view];
    //    [newController didMoveToParentViewController:self];

    if (viewController.parentViewController != self) {
        [viewController willMoveToParentViewController:self];
        [self addChildViewController:viewController];
    }

    if (animated) {
        [self _updateVisibleViewControllerWithPush:YES animated:animated completion:^{
            if (self.bDidPush) {
                self.bDidPush(tempVC, viewController);
            }
        }];
    } else {
        [self.view setNeedsLayout];
        [self _updateVisibleViewControllerWithPush:YES animated:animated completion:^{
            if (self.bDidPush) {
                self.bDidPush(tempVC, viewController);
            }
        }];
        //        [self _setNeedsDeferredUpdate];
    }

    //    [_navigationBar pushNavigationItem:viewController.navigationItem animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if ([self.viewControllers count] <= 1) {
        return nil;
    }
    ///上一个pop还未完成，不能进行pop
    if (_isUpdating && animated) return nil;

    UIViewController *formerTopViewController = self.topViewController;

    UIViewController *toVC = nil;
    if (self.viewControllers.count > 1) {
        toVC = self.viewControllers[self.viewControllers.count-2];
    }
    ///将要pop时的回调
    if (self.bWillPop) {
        self.bWillPop(formerTopViewController, toVC);
    }

    if (formerTopViewController == _visibleViewController) {
        [formerTopViewController willMoveToParentViewController:nil];
    }

    [formerTopViewController removeFromParentViewController];

    if (animated) {
        [self _updateVisibleViewControllerWithPush:NO animated:animated completion:^{
            //            [formerTopViewController removeFromParentViewController];
            if (self.bDidPop) {
                self.bDidPop(formerTopViewController, self.topViewController);
            }
        }];
    } else {
        //        [self _setNeedsDeferredUpdate];
        [self.view setNeedsLayout];
        [self _updateVisibleViewControllerWithPush:NO animated:animated completion:^{
            if (self.bDidPop) {
                self.bDidPop(formerTopViewController, self.topViewController);
            }
        }];
    }

    return formerTopViewController;
}

- (NSArray *)popToViewController:(UIViewController<IImitateNavigationTransitioning> *)viewController animated:(BOOL)animated {
    NSMutableArray *popped = [[NSMutableArray alloc] init];

    if (self.viewControllers.count > 1 && [self.viewControllers containsObject:viewController]) {
        //        NSUInteger index = [self.viewControllers indexOfObject:viewController];
        //        UIViewController *lastVC = self.viewControllers[index + 1];
        UIViewController *firstVC = self.topViewController;
        while (self.topViewController != viewController) {
            UIViewController *poppedController = [self popViewControllerAnimated:(self.topViewController != firstVC)?NO:animated];
            if (poppedController) {
                [popped addObject:poppedController];
            } else {
                break;
            }
        }
    }

    return popped;
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self popToViewController:[self.viewControllers objectAtIndex:0] animated:animated];
}

/**
 关闭当前页面，跳转到应用内的某个页面
 */
- (void)redirectViewController:(UIViewController<IImitateNavigationTransitioning> *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated];
    if (self.childViewControllers.count > 2) {
        //        NSArray *subArr = [self.childViewControllers subarrayWithRange:NSMakeRange(1, self.childViewControllers.count-2)];
        //        NSMutableArray *arr = [NSMutableArray arrayWithArray:subArr];
        //        [arr addObject:viewController];

        UIViewController *last = self.childViewControllers[self.childViewControllers.count-2];
        [last removeFromParentViewController];
        //        for (<#type *object#> in <#collection#>) {
        //            <#statements#>
        //        }
        //        [self setViewControllers:arr animated:NO];
    }
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    [self popViewControllerAnimated:YES];
    return NO;
}

- (void)setContentSizeForViewInPopover:(CGSize)newSize {
    self.topViewController.contentSizeForViewInPopover = newSize;
}

- (CGSize)contentSizeForViewInPopover {
    return self.topViewController.contentSizeForViewInPopover;
}

//- (void)setNavigationBarHidden:(BOOL)hide animated:(BOOL)animated; {
//    if (hide != _navigationBarHidden) {
//        _navigationBarHidden = hide;
//
//        if (animated && !_isUpdating) {
//            CGAffineTransform startTransform = hide? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, -_navigationBar.frame.size.height);
//            CGAffineTransform endTransform = hide? CGAffineTransformMakeTranslation(0, -_navigationBar.frame.size.height) : CGAffineTransformIdentity;
//
//            CGRect contentRect;
//            [self _getNavbarRect:NULL contentRect:&contentRect toolbarRect:NULL forBounds:self.view.bounds];
//
//            _navigationBar.transform = startTransform;
//            _navigationBar.hidden = NO;
//
//            [UIView animateWithDuration:0.15 animations:^{
//                _visibleViewController.view.frame = contentRect;
//                _navigationBar.transform = endTransform;
//            } completion:^(BOOL finished) {
//                _navigationBar.transform = CGAffineTransformIdentity;
//                _navigationBar.hidden = _navigationBarHidden;
//            }];
//        } else {
//            _navigationBar.hidden = _navigationBarHidden;
//        }
//    }
//}

//- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
//    [self setNavigationBarHidden:navigationBarHidden animated:NO];
//}

- (UIViewController *)rootViewController {
    return self.viewControllers.firstObject;
}

/**
 push返回block
 */
- (void)didPushWithBlock:(bLECNavigationPushPop)didPushBlock {
    self.bDidPush = [didPushBlock copy];
}

/**
 pop时调用的block
 */
- (void)didPopWithBlock:(bLECNavigationPushPop)didPopBlock {
    self.bDidPop = [didPopBlock copy];
}

@end
