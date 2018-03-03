//
//  XXTransitionAnimation.h
//  ebm
//
//  Created by mac on 2017/5/29.
//  Copyright © 2017年 BM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+XXTransition.h"

///自定义Present动画
extern NSString *const _kXXPresentAnimation;
extern NSString *const _kXXPresentScaleAnimation;
extern NSString *const _kXXPresentPullAnimation;
extern NSString *const _kXXPresentPullToNavigationBarAnimation;

@interface XXTransitionAnimation : NSObject

/**
 初始化自定义动画
 */
+ (void)initPresentAnimation;

@end
