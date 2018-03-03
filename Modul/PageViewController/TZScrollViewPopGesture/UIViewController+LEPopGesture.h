//
//  UIViewController+LEPopGesture.h
//  PageViewController
//
//  Created by mac on 2018/1/19.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LEPopGesture)<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

- (void)lePop_viewWillAppear;

/**
 销毁
 */
- (void)lePop_viewDidDisappear;

@end


@interface UIViewController (TZPopGesture)

/// 给view添加侧滑返回效果
- (void)le_addPopGestureToView:(UIView *)view;

/// 禁止该页面的侧滑返回
@property (nonatomic, assign) BOOL le_interactivePopDisabled;

@end
