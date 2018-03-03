//
//  UIViewController+Category.m
//  CreditAddressBook
//
//  Created by Lee on 15/7/20.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "UIViewController+Category.h"

@implementation UIViewController (Category)

+ (instancetype)xc_loadFromNibUsingClassName {
    NSString *nibName = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    return [[self alloc] initWithNibName:nibName bundle:nil];
}

+ (instancetype)le_loadFromStoryBoard:(UIStoryboard *)sb {
    NSString *identifier = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}

/**
 通过storyboard的名字获取相应storyboard中的控制器
 storyboard中的控制器的storyboard ID必须与控制器命名一致

 @param sbName storyboard的名字
 */
+ (instancetype)le_loadFromStoryBoardName:(NSString *)sbName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:nil];
    NSString *identifier = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
