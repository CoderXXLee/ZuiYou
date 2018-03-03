//
//  LETabBarController.h
//  ZuiYou
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 le. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LETabBarView;

@interface LETabBarController : UITabBarController

/**
 设置选中的item
 */
- (void)le_setSelectedIndex:(NSUInteger)selectedIndex;

@end
