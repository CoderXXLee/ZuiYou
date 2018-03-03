//
//  LENavigationController.m
//  Pods
//
//  Created by mac on 2017/3/30.
//
//

#import "LENavigationController.h"
#import "UIViewController+LENaviBackButtonHandler.h"
#import "NSBundle+LENavigation.h"

// 图片路径
#define ImageSrcName(file) [@"LENavigationImage.bundle" stringByAppendingPathComponent:file]
//weakSelf
#define LENaviWeakObject(name, obj) __weak __typeof (obj)name = obj;
//strongSelf
#define LENaviStrongObject(name, obj) __strong __typeof (obj)name = obj;

@interface LENavigationController () <UINavigationBarDelegate, UIGestureRecognizerDelegate>

@end

@implementation LENavigationController

#pragma mark - Lazy load
#pragma mark - Super

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNaviBack];
    [self setupPopGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

//    [self resetNavigationItemButtonView];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    //    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
//    [self setNavigationBarHidden:NO animated:YES];
    //    viewController.navigationItem.hidesBackButton = YES;

    ///设置返回按钮文字为空
    [self setupBackItemWithController:viewController];
}

//- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
//    BOOL shouldPop = YES;
//    UIViewController *vc = [self topViewController];
//    LENaviWeakObject(wVC, vc);
//    vc.viewDidDisappearBlock = ^{
//        LENaviStrongObject(sVC, wVC);
//        if([sVC respondsToSelector:@selector(navigationDidPop)]) {
//            [sVC navigationDidPop];
//        }
//    };
//    shouldPop = [self canPopOnBackWithController:vc];
//    if (shouldPop) {
//        UIViewController *vc = [super popViewControllerAnimated:animated];
//        return vc;
//    }
//    return vc;
//}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
//    UIViewController *vc = [self topViewController];
//    ///NavigationBar从不隐藏到隐藏的状态
//    if (!self.isNavigationBarHidden && hidden) {
//        if([vc respondsToSelector:@selector(navigationShouldPopOnBackButtonWithGesture:)]) {
//            [vc navigationShouldPopOnBackButtonWithGesture:NO];
//        }
//    }
    [super setNavigationBarHidden:hidden animated:animated];
}

#pragma mark - Init

/*!
 *  自定义返回按钮图标
 */
- (void)setNaviBack {
    UINavigationBar *navigationBar = [UINavigationBar appearance];///获取所有导航控制器
//    UINavigationBar *navigationBar = self.navigationBar;
//    navigationBar.delegate = self;
    //返回按钮的箭头颜色
    [navigationBar setTintColor:[UIColor colorWithWhite:.5 alpha:1]];
    //设置标题栏字体
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [[UIColor blackColor] colorWithAlphaComponent:.8f];
    textAttrs[NSFontAttributeName] = [UIFont fontWithName:@"Heiti SC" size:17];
    [navigationBar setTitleTextAttributes:textAttrs];

//    NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
//    NSString *imagePath = [currentBundle pathForResource:@"common_title_bar_ic_back_normal@2x.png" ofType:nil inDirectory:@"LENavigationImage.bundle"];
//    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    //设置返回样式图片
//    UIImage *image = [UIImage imageNamed:ImageSrcName(@"common_title_bar_ic_back_normal")];
    UIImage *image = [NSBundle le_backImage];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    navigationBar.backIndicatorTransitionMaskImage = image;

    [self setupBackItemWithController:[self topViewController]];
    //设置自带的返回按钮标题隐藏，若修改设置中系统返回按钮的样式，则改方法有问题，顾直接采用setupBackItemWithController：新建一个空标题的返回按钮
    //    UIBarButtonItem *buttonItem = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    //    UIOffset offset;
    //    offset.horizontal = - 500;
    //    offset.vertical =  - 500;
    //    [buttonItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
}

/**
 滑动返回代理
 */
- (void)setupPopGestureRecognizer {
    if (self.interactivePopGestureRecognizer.enabled == YES) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

/**
 设置导航栏阴影
 */
- (void)setupNaviShadow {
    self.navigationBar.translucent = NO;
    ///1.设置阴影颜色
    self.navigationBar.layer.shadowColor = [UIColor colorWithRed:209.f/255.f green:209.f/255.f blue:209.f/255.f alpha:1].CGColor;

    ///2.设置阴影偏移范围
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 1);

    ///3.设置阴影颜色的透明度
    self.navigationBar.layer.shadowOpacity = 1;

    ///4.设置阴影半径
    self.navigationBar.layer.shadowRadius = 1.5;

    ///5.设置阴影路径
    self.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationBar.bounds].CGPath;

    UIImage *image = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, NaivHeight)];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBarStyle:UIBarStyleDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

#pragma mark - Utils

- (void)back {
    [self popViewControllerAnimated:YES];
}

/*!
 *  是否禁止返回
 */
- (void)canPop:(BOOL)isCan {
    UIViewController *vc = [self topViewController];
    if (isCan) {
        vc.navigationItem.hidesBackButton = NO;
        self.interactivePopGestureRecognizer.enabled = YES;
    } else {
        vc.navigationItem.hidesBackButton = YES;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

/*!
 *  @brief  设置navigationBar的TintColor
 */
- (void)setNavigationBarWithTintColor:(UIColor *)color showShadow:(BOOL)show {
    UINavigationBar *naviBar = self.navigationBar;
    if (!show) {
        [self findHairlineImageViewUnder:naviBar].hidden = YES;
    } else {
        [self findHairlineImageViewUnder:naviBar].hidden = NO;
    }
    [naviBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    naviBar.barTintColor = color;
    [naviBar setTranslucent:self.navigationBar.translucent];
}

/**
 设置navigationBar的背景图片
 */
- (void)setNavigationBarWithBackgroundColor:(UIColor *)color showShadow:(BOOL)show {
    UINavigationBar *naviBar = self.navigationBar;
    UIImage *image = [self imageWithColor:color size:CGSizeMake([UIScreen mainScreen].bounds.size.width, NaivHeight)];
    [naviBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [naviBar setBarStyle:UIBarStyleDefault];
    if (show) {
//        [naviBar setShadowImage:nil];
        ///设置阴影颜色的透明度
        self.navigationBar.layer.shadowOpacity = 1;
        [naviBar setShadowImage:[UIImage new]];
        [naviBar setTranslucent:NO];
    }
    else {
        ///设置阴影颜色的透明度
        self.navigationBar.layer.shadowOpacity = 0;
        [naviBar setShadowImage:[UIImage new]];
        [naviBar setTranslucent:YES];
    }
}

/**
 通过指定颜色生成图片
 */
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGFloat imageW = size.width;
    CGFloat imageH = size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 导航栏去除横线
 */
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

/**
 设置返回按钮为自定义按钮样式
 */
- (void)setupBackItemWithController:(UIViewController *)vc {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    UIOffset offset;
    offset.horizontal = -10;
    offset.vertical = -5;
    [backItem setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
//    UIImage *image = [UIImage imageNamed:ImageSrcName(@"common_title_bar_ic_back_normal")];
    UIImage *image = [NSBundle le_backImage];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    backItem.image = nil;

//    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    closeButton.frame = CGRectMake(0, 0, 20, 20);
////    [closeButton setTitle:@"返回" forState:UIControlStateNormal];
//    [closeButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
//    [closeButton setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];

    vc.navigationItem.backBarButtonItem = backItem;

//    [self resetNavigationItemButtonView:vc];
}

/**
 判断UIViewController及其子控制器是否实现navigationShouldPopOnBackButtonWithGesture代理
 */
- (BOOL)canPopOnBackWithController:(UIViewController *)vc {
    __block BOOL shouldPop = YES;
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButtonWithGesture:)]) {
        shouldPop = [vc navigationShouldPopOnBackButtonWithGesture:NO];
    } else {
//        [vc.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            shouldPop = [self canPopOnBackWithController:obj];
//        }];
    }
    return shouldPop;
}

/**
 UINavigationItemButtonView
 */
- (void)resetNavigationItemButtonView:(UIViewController *)vc {
//    UIView *nav_back = [self.navigationBar.subviews objectAtIndex:2];
    for (UIView *nav_back in vc.navigationController.navigationBar.subviews) {
        if ([nav_back isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
            nav_back.frame = CGRectMake(CGRectGetMinX(nav_back.frame), CGRectGetMinY(nav_back.frame), 50, CGRectGetHeight(nav_back.frame));
            break;
        }
    }
}

#pragma mark - Events
#pragma mark - Public

/**
 初始返回按钮图片
 */
- (void)initBackIndicatorImage:(UIImage *)backImage {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置返回样式图片
    UIImage *image = backImage;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    navigationBar.backIndicatorTransitionMaskImage = image;
}

/**
 关闭当前页面，跳转到应用内的某个页面
 */
- (void)redirectViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    [self pushViewController:viewController animated:animated];
//    if (self.childViewControllers.count > 2) {
//        NSArray *subArr = [self.childViewControllers subarrayWithRange:NSMakeRange(0, self.childViewControllers.count-2)];
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:subArr];
//        [arr addObject:viewController];
//        [self setViewControllers:arr animated:NO];
//    }

    if (self.childViewControllers.count > 1) {
        NSArray *subArr = [self.childViewControllers subarrayWithRange:NSMakeRange(0, self.childViewControllers.count-1)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:subArr];
        [arr addObject:viewController];
        [self setViewControllers:arr animated:animated];
    }
}

/**
 关闭level个页面，跳转到应用内的某个页面
 level：从当前页面往前(左边)推，取值范围：1~100
 */
- (void)redirectToViewController:(UIViewController *)viewController level:(NSUInteger)level animated:(BOOL)animated {
//    [self pushViewController:viewController animated:animated];
    if (self.childViewControllers.count > 1) {
        NSArray *childs = self.childViewControllers;
        NSInteger index = childs.count - 0;
        NSInteger subIndex = index - level;
        if (subIndex <= 0) {
            subIndex = 1;
        }
        NSArray *subArr = [self.childViewControllers subarrayWithRange:NSMakeRange(0, subIndex)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:subArr];
        [arr addObject:viewController];
        [self setViewControllers:arr animated:animated];
    }
}

/**
 关闭当前页面以及之前的页面，跳转到应用内的某个页面
 返回时返回到rootViewController
 */
- (void)redirectAllToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated];
    [self setViewControllers:@[self.childViewControllers.firstObject, self.childViewControllers.lastObject] animated:NO];
}

/*!
 *  @brief  返回到上level个控制器
 *
 *  @param level 取值范围：1~100
 *  @param animated 动画
 */
- (void)popToViewControllerOfLevel:(NSUInteger)level animated:(BOOL)animated {
    NSArray *controllers = self.viewControllers;
    NSInteger index = controllers.count - 1;
    NSInteger subIndex = index - level;
    if (subIndex < 0) {
        subIndex = 0;
    }
    [self popToViewController:controllers[subIndex] animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated  {
    return [super popToRootViewControllerAnimated:animated];
}

#pragma mark - LoadFromService
#pragma mark - Delegate

/**
 *  UIGestureRecognizerDelegate
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //    CGPoint point = [gestureRecognizer locationInView:self.view];
    //    NSLog(@"滑过画面坐标位置 %f, %f",point.x, point.y);
    UIViewController *vc = [self topViewController];
    BOOL shouldPop = YES;
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButtonWithGesture:)]) {
        shouldPop = [vc navigationShouldPopOnBackButtonWithGesture:YES];
    } else {
//        int i = 0;
//        while (vc && i < vc.childViewControllers.count) {
//            vc = vc.childViewControllers[i];
//            if([vc respondsToSelector:@selector(navigationShouldPopOnBackButtonWithGesture:)]) {
//                shouldPop = [vc navigationShouldPopOnBackButtonWithGesture:YES];
//                break;
//            }
//            i++;
//        }
    }
    if (shouldPop) {
        if ([gestureRecognizer isEqual:self.interactivePopGestureRecognizer] && [self.viewControllers count] == 1) {
            return NO;
        } else {
            ///设置POP完成后的调用
            UIViewController *vc = [self topViewController];
            LENaviWeakObject(wVC, vc);
            vc.viewDidDisappearBlock = ^{
                LENaviStrongObject(sVC, wVC);
                if([sVC respondsToSelector:@selector(navigationDidPop)]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [sVC navigationDidPop];
                    });
                }
            };

            ///地图也滑动返回
//            UIView *touchView = [vc.view hitTest:[gestureRecognizer locationInView:vc.view] withEvent:nil];
//            if ([touchView isKindOfClass:NSClassFromString(@"MAAnnotationContainerView")]) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self popViewControllerAnimated:YES];
//                });
//            }
            return YES;
        }
    } else {
        return NO;
    }
}

#pragma mark - UINavigationBarDelegate

/**
 当NavigationBar从不隐藏到隐藏的状态时该方法将不会再调用
 点击导航栏返回按钮将会调用次方法
 注意：调用了该方法将不会调用popViewControllerAnimated:方法
 注意：使用了JZNavigationExtension后会改变该方法与popViewControllerAnimated:的调用顺序
 */
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    //导航栏分割线
    //    self.jz_line.alpha = 1;
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    BOOL shouldPop = YES;
    UIViewController *vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButtonWithGesture:)]) {
        shouldPop = [vc navigationShouldPopOnBackButtonWithGesture:NO];
    }
    if(shouldPop) {
        ///设置POP完成后的调用
        UIViewController *vc = [self topViewController];
        LENaviWeakObject(wVC, vc);
        vc.viewDidDisappearBlock = ^{
            LENaviStrongObject(sVC, wVC);
            if([sVC respondsToSelector:@selector(navigationDidPop)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [sVC navigationDidPop];
                });
            }
        };

        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        for(UIView *subview in [navigationBar subviews]) {
            if(subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    return NO;
}

//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {}
- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item {

}
//- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {}
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item {

}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

}

@end
