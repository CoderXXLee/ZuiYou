//
//  LEPageViewController.m
//  CreditAddressBookEE
//
//  Created by LE on 16/2/16.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "LESysPageVC.h"
#import "UIView+AutoLayout.h"
#import <UIView+STHitTest.h>

@interface LESysPageVC ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate, WMMenuViewDelegate, WMMenuViewDataSource>

/** 顶部导航栏 */
@property (nonatomic, nullable, weak) WMMenuView *menuView;

@property(nonatomic, copy) LEControllerChanged block;

@property(nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL startDragging;

@end

@implementation LESysPageVC {
    UIPageViewController *_pageController;
    NSMutableDictionary *_viewControllers;
    NSUInteger _currentIndex;
    BOOL _disableDragging;
    CGFloat _targetX;
}

#pragma mark - LazyLoad

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self moveToPage:selectedIndex animated:NO];
}

- (void)setScrollEnable:(BOOL)scrollEnable {
    _scrollEnable = scrollEnable;

    if (!self.scrollView) return;
    self.scrollView.scrollEnabled = scrollEnable;
}

#pragma mark - Super

- (void)viewDidLoad {
    [super viewDidLoad];

    [self wm_calculateSize];
    [self wm_addMenuView];
    [self initContent];
    [self addConstraints];
    [self setupFirstController];
    [self setupPointInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - Init

// 初始化一些参数，在init中调用
- (void)wm_setup {
    _titleSizeSelected  = 18.0f;
    _titleSizeNormal    = 15.0f;
    _titleColorSelected = [UIColor colorWithRed:168.0/255.0 green:20.0/255.0 blue:4/255.0 alpha:1];
    _titleColorNormal   = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    _menuItemWidth = 65.0f;
    _currentIndex = -1;

    _scrollEnable = YES;

    self.automaticallyCalculatesItemWidths = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)initContent {
    _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageController.delegate = self;
    _pageController.dataSource = self;

    __block UIScrollView *scrollView = nil;
    [_pageController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)obj;
            *stop = YES;
        }
    }];
    if (scrollView ) {
        self.scrollView = scrollView;
        scrollView.delegate = self;
        scrollView.scrollEnabled = self.scrollEnable;
        scrollView.bounces = YES;
//        scrollView.scrollsToTop = NO;
//        scrollView.pagingEnabled = YES;
//        scrollView.backgroundColor = [UIColor whiteColor];
//        scrollView.showsVerticalScrollIndicator = NO;
//        scrollView.showsHorizontalScrollIndicator = NO;
    }

    _viewControllers = [[NSMutableDictionary alloc] init];

    UIViewController *newController = _pageController;
    [newController willMoveToParentViewController:self];
    [self addChildViewController:newController];
    [self.view addSubview:newController.view];
    [newController didMoveToParentViewController:self];
}

- (void)setupFirstController {
//    id viewController = self.controllers[_selectedIndex];
//    [_viewControllers setObject:viewController forKey:[NSNumber numberWithInteger:_selectedIndex]];
//
//    [_pageController setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
//
//    }];

    [self.menuView slideMenuAtProgress:_selectedIndex];
    [self moveToPage:_selectedIndex animated:NO];
}

- (void)addConstraints {
    [_pageController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];

    UIView *pageControllerView = _pageController.view;
    [pageControllerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(self.menuViewFrame.size.height, 0, 0, 0)];
}

// 包括宽高，子控制器视图 frame
- (void)wm_calculateSize {
    if (self.menuViewStyle == WMMenuViewStyleNone) {
        _menuViewFrame = CGRectZero;
    } else {
        CGFloat originY = (!self.navigationController.navigationBar.translucent ||(self.showOnNavigationBar && self.navigationController.navigationBar)) ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
        _menuViewFrame = CGRectMake(0, originY, self.view.frame.size.width, 40.0f);
    }
}

- (void)wm_addMenuView {
    if (self.menuViewStyle == WMMenuViewStyleNone) return;
    WMMenuView *menuView = [[WMMenuView alloc] initWithFrame:_menuViewFrame];
    menuView.backgroundColor = [UIColor whiteColor];
    menuView.delegate = self;
    menuView.dataSource = self;
    menuView.style = self.menuViewStyle;
    menuView.layoutMode = self.menuViewLayoutMode;
    menuView.progressHeight = self.progressHeight;
    menuView.contentMargin = self.menuViewContentMargin;
    menuView.progressViewBottomSpace = self.progressViewBottomSpace;
    menuView.progressWidths = self.progressViewWidths;
    menuView.progressViewIsNaughty = self.progressViewIsNaughty;
    menuView.progressViewCornerRadius = self.progressViewCornerRadius;

    if (self.menuViewBackgroundColor) {
        menuView.backgroundColor = self.menuViewBackgroundColor;
    }
    if (self.titleFontName) {
        menuView.fontName = self.titleFontName;
    }
    if (self.progressColor) {
        menuView.lineColor = self.progressColor;
    }
    if (self.showOnNavigationBar && self.navigationController.navigationBar) {
        self.navigationItem.titleView = menuView;
    } else {
        [self.view addSubview:menuView];
    }
    self.menuView = menuView;

    ///回调进行属性自定义
    if (self.bSetMenuViewProperty) self.bSetMenuViewProperty(menuView);
}

/**
 设置点击穿透,为了使侧滑返回生效
 */
- (void)setupPointInside {
    _pageController.view.pointInsideBlock = ^BOOL(CGPoint point, UIEvent *event, BOOL *returnSuper) {
        if (point.x <= 50) {
            return NO;
        }
        *returnSuper = YES;
        return YES;
    };
}

#pragma mark - PublicMethod

/**
 初始化
 */
- (instancetype)initWithControllers:(NSArray *)controllers controllerChanged:(LEControllerChanged)controllerChanged {
    if (self = [super init]) {
        self.block = [controllerChanged copy];
        _controllers = controllers.mutableCopy;
        [self wm_setup];
    }
    return self;
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

/**
 移动到指定控制器
 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    _selectedIndex = selectedIndex;
    [self moveToPage:selectedIndex animated:animated];
}

- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index {
    [self.menuView updateTitle:title atIndex:index andWidth:NO];
}

- (void)updateAttributeTitle:(NSAttributedString * _Nonnull)title atIndex:(NSInteger)index {
    [self.menuView updateAttributeTitle:title atIndex:index andWidth:NO];
}

- (void)updateTitle:(NSString *)title andWidth:(CGFloat)width atIndex:(NSInteger)index {
    if (self.itemsWidths && index < self.itemsWidths.count) {
        NSMutableArray *mutableWidths = [NSMutableArray arrayWithArray:self.itemsWidths];
        mutableWidths[index] = @(width);
        self.itemsWidths = [mutableWidths copy];
    } else {
        NSMutableArray *mutableWidths = [NSMutableArray array];
        for (int i = 0; i < self.controllers.count; i++) {
            CGFloat itemWidth = (i == index) ? width : self.menuItemWidth;
            [mutableWidths addObject:@(itemWidth)];
        }
        self.itemsWidths = [mutableWidths copy];
    }
    [self.menuView updateTitle:title atIndex:index andWidth:YES];
}

#pragma mark - PrivateMethod

/**
 移动到指定控制器
 */
- (void)moveToPage:(NSUInteger)selectedIndex animated:(BOOL)animated {
    if (selectedIndex == _currentIndex) return;
    if(selectedIndex > _controllers.count) return;
    if (_disableDragging) return;
    if (!_pageController) return;
    _disableDragging = YES;

    UIViewController *viewController = [_viewControllers objectForKey:[NSNumber numberWithInteger:selectedIndex]];

    if (!viewController) {
        viewController = self.controllers[selectedIndex];
        [_viewControllers setObject:viewController forKey:[NSNumber numberWithInteger:selectedIndex]];
    }

    UIPageViewControllerNavigationDirection animateDirection =
    selectedIndex > _currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;

    __unsafe_unretained typeof(self) weakSelf = self;
    _pageController.view.userInteractionEnabled = NO;
    self.menuView.userInteractionEnabled = NO;
    [_pageController setViewControllers:@[viewController] direction:animateDirection animated:animated completion:^(BOOL finished) {
        weakSelf->_disableDragging = NO;
        weakSelf->_pageController.view.userInteractionEnabled = YES;
        weakSelf->_currentIndex = selectedIndex;
        weakSelf.menuView.userInteractionEnabled = YES;
    }];
}

- (void)wm_resetMenuView {
    if (!self.menuView) {
        [self wm_addMenuView];
    } else {
        [self.menuView reload];
        if (self.menuView.userInteractionEnabled == NO) {
            self.menuView.userInteractionEnabled = YES;
        }
        if (self.selectedIndex != 0) {
            [self.menuView selectItemAtIndex:self.selectedIndex];
        }
        [self.view bringSubviewToFront:self.menuView];
    }
}

- (CGFloat)wm_calculateItemWithAtIndex:(NSInteger)index {
    NSString *title = [self titleAtIndex:index];
    UIFont *titleFont = self.titleFontName ? [UIFont fontWithName:self.titleFontName size:self.titleSizeSelected] : [UIFont systemFontOfSize:self.titleSizeSelected];
    NSDictionary *attrs = @{NSFontAttributeName: titleFont};
    CGFloat itemWidth = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:attrs context:nil].size.width;
    return ceil(itemWidth);
}

- (NSString * _Nonnull)titleAtIndex:(NSInteger)index {
    if (index < self.controllers.count) {
        UIViewController *vc = self.controllers[index];
        return vc.title != nil ? vc.title: @"";
    }
    return @"";
}

- (UIViewController*)topMostWindowController {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIViewController *topController = [window rootViewController];

    //  Getting topMost ViewController
    while ([topController presentedViewController]) topController = [topController presentedViewController];

    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)currentViewController; {
    UIViewController *currentViewController = [self topMostWindowController];

    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];

    return currentViewController;
}

#pragma mark - Events

#pragma mark - LoadFromService
#pragma mark - Delegate

#pragma mark - <UIGestureRecognizerDelegate>

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //MARK: UITableViewCell 删除手势
    if ([NSStringFromClass(otherGestureRecognizer.view.class) isEqualToString:@"UITableViewWrapperView"] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)navigationShouldPopOnBackButtonWithGesture:(BOOL)gesture {
    if (gesture) {
        self.scrollView.bounces = NO;
        return YES;
    }
    return YES;
}

#pragma mark - PageViewController Delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed)
        return;
    
    id currentView = [pageViewController.viewControllers objectAtIndex:0];
    
    NSNumber *key = (NSNumber *)[_viewControllers allKeysForObject:currentView][0];
    _selectedIndex = [key integerValue];
    _currentIndex = _selectedIndex;
    if (self.block) {
        self.block(_selectedIndex);
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.controllers indexOfObject:viewController];
    _selectedIndex = index;
//    if (self.block) {
//        self.block(index);
//    }

    if (index++ < self.controllers.count - 1) {
        UIViewController *nextViewController = [_viewControllers objectForKey:[NSNumber numberWithInteger:index]];
        
        if (!nextViewController) {
            nextViewController = self.controllers[index];
            [_viewControllers setObject:nextViewController forKey:[NSNumber numberWithInteger:index]];
        }
        return nextViewController;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.controllers indexOfObject:viewController];
    _selectedIndex = index;
//    if (self.block) {
//        self.block(index);
//    }

    if (index-- > 0) {
        UIViewController *nextViewController = [_viewControllers objectForKey:[NSNumber numberWithInteger:index]];
        
        if (!nextViewController) {
            nextViewController = self.controllers[index];
            [_viewControllers setObject:nextViewController forKey:[NSNumber numberWithInteger:index]];
        }
        return nextViewController;
    }
    return nil;
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;

    CGFloat scrollViewWidth = scrollView.frame.size.width;

    int selectedIndex = (int)self.selectedIndex;
    float xDriff = offset.x - scrollViewWidth;

    if (self.bLEPageVCDidScroll) {
        self.bLEPageVCDidScroll(CGPointMake(xDriff+(selectedIndex)*scrollViewWidth, offset.y));
    }

    if (_startDragging) {
        scrollView.bounces = NO;
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        if (contentOffsetX < 0) {
            contentOffsetX = 0;
        }
        if (contentOffsetX > scrollView.contentSize.width - self.view.frame.size.width) {
            contentOffsetX = scrollView.contentSize.width - self.view.frame.size.width;
        }
        CGFloat rate = contentOffsetX / self.view.frame.size.width - 1;
        CGFloat progress = rate + self.selectedIndex;
//        NSLog(@"progress: %f", progress);
        [self.menuView slideMenuAtProgress:progress];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _startDragging = YES;
    self.menuView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.menuView.userInteractionEnabled = YES;
    [self.menuView deselectedItemsIfNeeded];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self.menuView deselectedItemsIfNeeded];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.menuView.userInteractionEnabled = YES;
//        CGFloat rate = _targetX / self.view.frame.size.width;
//        [self.menuView slideMenuAtProgress:rate];
        [self.menuView deselectedItemsIfNeeded];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    _targetX = targetContentOffset->x;
//    NSLog(@"_targetX: %f", _targetX);
}

#pragma mark - WMMenuView Delegate
- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
//    if (!_hasInited) return;
//    self.selectedIndex = (int)index;
    [self setSelectedIndex:index animated:self.pageAnimatable];
    _startDragging = NO;
    self.scrollView.bounces = YES;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    if (self.automaticallyCalculatesItemWidths) {
        return [self wm_calculateItemWithAtIndex:index];
    }

    if (self.itemsWidths.count == self.controllers.count) {
        return [self.itemsWidths[index] floatValue];
    }
    return self.menuItemWidth;
}

- (CGFloat)menuView:(WMMenuView *)menu itemMarginAtIndex:(NSInteger)index {
    if (self.itemsMargins.count == self.controllers.count + 1) {
        return [self.itemsMargins[index] floatValue];
    }
    return self.itemMargin;
}

- (CGFloat)menuView:(WMMenuView *)menu titleSizeForState:(WMMenuItemState)state atIndex:(NSInteger)index {
    switch (state) {
        case WMMenuItemStateSelected: {
            return self.titleSizeSelected;
            break;
        }
        case WMMenuItemStateNormal: {
            return self.titleSizeNormal;
            break;
        }
    }
}

- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state atIndex:(NSInteger)index {
    switch (state) {
        case WMMenuItemStateSelected: {
            return self.titleColorSelected;
            break;
        }
        case WMMenuItemStateNormal: {
            return self.titleColorNormal;
            break;
        }
    }
}

#pragma mark - WMMenuViewDataSource

- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu {
    return self.controllers.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index {
    return [self titleAtIndex:index];
}

@end
