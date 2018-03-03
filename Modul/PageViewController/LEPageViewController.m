//
//  LEPageViewController.m
//  ebm_driver
//
//  Created by mac on 2017/7/24.
//  Copyright © 2017年 ebm. All rights reserved.
//

#import "LEPageViewController.h"
#import "BMSegmentView.h"
#import <UIView+AutoLayout.h>

@interface LEPageViewController ()

@property(nonatomic, copy) LEControllerChanged block;

@end

@implementation LEPageViewController

#pragma mark - LazyLoad

- (UIColor *)backgroundColor {
    if (!_backgroundColor) {
        _backgroundColor = [UIColor clearColor];
    }
    return _backgroundColor;
}

#pragma mark - Super

- (void)viewDidLoad {
    [super viewDidLoad];
    ///初始化
    [self initUI];
}

#pragma mark - Init

/**
 初始化
 */
- (void)initUI {
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.view setBackgroundColor:self.backgroundColor];
}

#pragma mark - PublicMethod

/**
 创建
 */
- (instancetype)initWithControllers:(NSArray *)controllers controllerChanged:(LEControllerChanged)controllerChanged {
    NSMutableArray *classes = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    for (UIViewController *vc in controllers) {
        [classes addObject:[vc class]];
        if (vc.title) {
            [titles addObject:vc.title];
        } else {
            [titles addObject:@"NONE"];
        }
    }
    if (self = [super initWithViewControllerClasses:classes andTheirTitles:titles]) {
        ///默认segment为None
        self.menuViewStyle = WMMenuViewStyleNone;
        self.pageAnimatable = YES;
        //    self.bounces = YES;
        self.block = [controllerChanged copy];
        _controllers = controllers.mutableCopy;
    }
    return self;
}

/**
 创建带有BMSegmentView的pageVC
 */
- (instancetype)initBMWithController:(UIViewController *)vc titles:(NSArray *)titles subControllers:(NSArray *)controllers controllerChanged:(LEControllerChanged)controllerChanged {
    NSMutableArray *classes = [NSMutableArray array];
    NSMutableArray *classTitles = [NSMutableArray array];
    for (UIViewController *vc in controllers) {
        [classes addObject:[vc class]];
        if (vc.title) {
            [classTitles addObject:vc.title];
        } else {
            [classTitles addObject:@"NONE"];
        }
    }
    if (self = [super initWithViewControllerClasses:classes andTheirTitles:classTitles]) {
        ///默认segment为None
        self.menuViewStyle = WMMenuViewStyleNone;
        self.block = [controllerChanged copy];
        _controllers = controllers.mutableCopy;

        [self setupDefaultWithParentVC:vc titles:titles];
    }
    return self;
}

/**
 创建
 */
- (instancetype)initWithControllers:(NSArray *)controllers menuViewStyle:(WMMenuViewStyle)menuViewStyle controllerChanged:(LEControllerChanged)controllerChanged {
    NSMutableArray *classes = [NSMutableArray array];
    NSMutableArray *titles = [NSMutableArray array];
    for (UIViewController *vc in controllers) {
        [classes addObject:[vc class]];
        if (vc.title) {
            [titles addObject:vc.title];
        } else {
            [titles addObject:@"NONE"];
        }
    }
    if (self = [super initWithViewControllerClasses:classes andTheirTitles:titles]) {
        ///默认segment为None
        self.menuViewStyle = menuViewStyle;
        self.block = [controllerChanged copy];
        _controllers = controllers.mutableCopy;
    }
    return self;
}

- (void)setSelectedIndex:(int)selectedIndex {
    _selectedIndex = selectedIndex;
    self.selectIndex = selectedIndex;
    ///选中操作
    [self customSegmentSelectedIndex:selectedIndex];
}

- (void)setBLEPageVCDidScroll:(void (^)(CGPoint))bLEPageVCDidScroll {
    _bLEPageVCDidScroll = bLEPageVCDidScroll;
    self.bWMPageVCDidScroll =  bLEPageVCDidScroll;
}

/**
 移动到父类控制器
 */
- (void)moveToParentViewController:(UIViewController *)parentVC {
    [self willMoveToParentViewController:parentVC];
    [parentVC addChildViewController:self];
    [parentVC.view addSubview:self.view];
    [self didMoveToParentViewController:parentVC];
}

#pragma mark - PrivateMethod

/**
 初始化默认的BMSegmentView
 */
- (void)setupDefaultWithParentVC:(UIViewController *)vc titles:(NSArray *)titles {
    [self willMoveToParentViewController:vc];
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    [self didMoveToParentViewController:vc];

    BMSegmentView *segment = [[BMSegmentView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    [self.view addSubview:segment];
    _segmentView = segment;
    [segment autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
    [segment autoSetDimension:ALDimensionHeight toSize:30];

    segment.backgroundColor = [UIColor whiteColor];
    //    segment.type = BMSegmentViewTypeOval;
    [segment commonTitleArr:titles];

    [self.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
    [self.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:segment];
}

#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.controllers.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    if (self.titles && self.titles.count > 0) {
        return self.titles[index];
    }
    return @"NONE";
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (self.controllers && self.controllers.count > 0) {
        return self.controllers[index];
    }
    return [[UIViewController alloc] init];
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    NSUInteger index = [self.controllers indexOfObject:viewController];
    if (index != NSNotFound) {
        _selectedIndex = (int)index;
        if (self.block) {
            self.block(index);
        }
    }
}

///**
// 自定义WMMenuView的frame
// */
//- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
//
//}

#pragma mark - StateMachine

@end
