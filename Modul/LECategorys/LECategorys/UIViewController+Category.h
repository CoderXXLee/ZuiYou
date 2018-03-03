//
//  UIViewController+Category.h
//  CreditAddressBook
//
//  Created by Lee on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Category)

+ (instancetype)xc_loadFromNibUsingClassName;

/**
 通过storyboard获取相应storyboard中的控制器
 storyboard中的控制器的storyboard ID必须与控制器命名一致

 @param sb storyboard
 */
+ (instancetype)le_loadFromStoryBoard:(UIStoryboard *)sb;

/**
 通过storyboard的名字获取相应storyboard中的控制器
 storyboard中的控制器的storyboard ID必须与控制器命名一致

 @param sbName storyboard的名字
 */
+ (instancetype)le_loadFromStoryBoardName:(NSString *)sbName;

@end
