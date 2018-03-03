//
//  UIViewController+LEPopGesture.m
//  PageViewController
//
//  Created by mac on 2018/1/19.
//

#import "UIViewController+LEPopGesture.h"
#import <objc/runtime.h>

@interface UIViewController (LEPopGesturePrivate)

@property (nonatomic, weak, readonly) id le_naviDelegate;
@property (nonatomic, weak, readonly) id le_popDelegate;

@end

@implementation UIViewController (LEPopGesture)


//+ (void)load {
    //    Method originalMethod = class_getInstanceMethod(self, @selector(viewWillAppear:));
    //    Method swizzledMethod = class_getInstanceMethod(self, @selector(tzPop_viewWillAppear:));
    //    method_exchangeImplementations(originalMethod, swizzledMethod);
//}

- (void)lePop_viewWillAppear {
    // 只是为了触发le_PopDelegate的get方法，获取到原始的interactivePopGestureRecognizer的delegate
    [self.le_popDelegate class];
    // 获取导航栏的代理
    [self.le_naviDelegate class];
    self.navigationController.delegate = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.navigationController.delegate = self.le_naviDelegate;
    });
}

/**
 销毁
 */
- (void)lePop_viewDidDisappear {
    self.navigationController.delegate = nil;
//    self.le_naviDelegate = nil;
//    self.le_popDelegate = nil;
}

- (id)le_popDelegate {
    id le_popDelegate = objc_getAssociatedObject(self, _cmd);
    if (!le_popDelegate) {
        le_popDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        objc_setAssociatedObject(self, _cmd, le_popDelegate, OBJC_ASSOCIATION_ASSIGN);
    }
    return le_popDelegate;
}

- (id)le_naviDelegate {
    id le_naviDelegate = objc_getAssociatedObject(self, _cmd);
    if (!le_naviDelegate) {
        le_naviDelegate = self.navigationController.delegate;
        if (le_naviDelegate) {
            objc_setAssociatedObject(self, _cmd, le_naviDelegate, OBJC_ASSOCIATION_ASSIGN);
        }
    }
    return le_naviDelegate;
}

#pragma mark - UIGestureRecognizerDelegate

//- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
//    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
//        return NO;
//    }
//    if ([self.navigationController.transitionCoordinator isAnimated]) {
//        return NO;
//    }
//    if (self.childViewControllers.count <= 1) {
//        return NO;
//    }
//    UIViewController *vc = self.navigationController.topViewController;
//    if (vc.le_interactivePopDisabled) {
//        return NO;
//    }
//    // 侧滑手势触发位置
//    CGPoint location = [gestureRecognizer locationInView:self.view];
//    CGPoint offSet = [gestureRecognizer translationInView:gestureRecognizer.view];
//    BOOL ret = (0 < offSet.x && location.x <= 40);
//    // NSLog(@"%@ %@",NSStringFromCGPoint(location),NSStringFromCGPoint(offSet));
//    return ret;
//}

/// 只有当系统侧滑手势失败了，才去触发ScrollView的滑动
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    return YES;
//}

#pragma mark - UINavigationControllerDelegate

//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 转发给业务方代理
//    if (self.le_naviDelegate && ![self.le_naviDelegate isEqual:self]) {
//        if ([self.le_naviDelegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
//            [self.le_naviDelegate navigationController:navigationController didShowViewController:viewController animated:animated];
//        }
//    }
//    // 让系统的侧滑返回生效
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    if (self.childViewControllers.count > 0) {
//        if (viewController == self.childViewControllers[0]) {
//            self.navigationController.interactivePopGestureRecognizer.delegate = self.le_popDelegate; // 不支持侧滑
//        } else {
//            self.navigationController.interactivePopGestureRecognizer.delegate = nil; // 支持侧滑
//        }
//    }
//}
//
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    // 转发给业务方代理
//    if (self.le_naviDelegate && ![self.le_naviDelegate isEqual:self]) {
//        if ([self.le_naviDelegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
//            [self.le_naviDelegate navigationController:navigationController willShowViewController:viewController animated:animated];
//        }
//    }
//}

@end



@interface UIViewController (TZPopGesturePrivate)
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *le_popGestureRecognizer;
@end

@implementation UIViewController (TZPopGesture)

- (void)le_addPopGestureToView:(UIView *)view {
    if (!view) return;
    if (!self.navigationController) {
        // 在控制器转场的时候，self.navigationController可能是nil,这里用GCD和递归来处理这种情况
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self le_addPopGestureToView:view];
        });
    } else {
        UIPanGestureRecognizer *pan = self.le_popGestureRecognizer;
        if (![view.gestureRecognizers containsObject:pan]) {
            [view addGestureRecognizer:pan];
        }
    }
}

- (UIPanGestureRecognizer *)le_popGestureRecognizer {
    UIPanGestureRecognizer *pan = objc_getAssociatedObject(self, _cmd);
    if (!pan) {
        // 侧滑返回手势 手势触发的时候，让target执行action
        id target = self.navigationController.le_popDelegate;
        SEL action = NSSelectorFromString(@"handleNavigationTransition:");
        pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
        pan.maximumNumberOfTouches = 1;
        pan.delegate = self.navigationController;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        objc_setAssociatedObject(self, _cmd, pan, OBJC_ASSOCIATION_ASSIGN);
    }
    return pan;
}

- (BOOL)le_interactivePopDisabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLe_interactivePopDisabled:(BOOL)disabled {
    objc_setAssociatedObject(self, @selector(le_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
