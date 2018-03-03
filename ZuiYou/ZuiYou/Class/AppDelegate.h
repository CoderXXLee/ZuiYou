//
//  AppDelegate.h
//  ZuiYou
//
//  Created by mac on 2018/2/28.
//  Copyright © 2018年 le. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LEAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define LERootNavi ((UINavigationController *)((AppDelegate *)[UIApplication sharedApplication].delegate).rootNavi)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) UINavigationController *rootNavi;

@end

