//
//  LEUserTool.h
//  Medical
//
//  Created by LE on 15/11/23.
//  Copyright © 2015年 LE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LEUserData.h"

extern NSString *const kLEDeviceToken;//DeviceToken
extern NSString *const kLEIsSetChannel;//是否设置了频道
extern NSString *const kLEDeviceTokenID;//BmobInstallation的ID
extern NSString *const _nLEUserToolUpdate;///user缓存更新通知
extern NSString *const _nLEUserToolLogout;///退出登录通知

@interface LEUserTool : NSObject
/**
 *  保存用户登录信息
 */
+ (BOOL)saveUserLoginInfo:(id)user;
/**
 *  保存用户信息
 */
+ (BOOL)updateUserData:(id)user;
/**
 *  获取用户信息
 */
+ (LEUserData *)userData;
/**
 *  获取用户信息
 */
+ (id)user;

/**
 block方式获取user，效果等同于+(id)user;
 success：成功获取user并返回user
 failure：用户未登录，或者获取user失败
 */
+ (void)getUserSuccess:(void(^)(id user))success failure:(void(^)(void))failure;

/*!
 *  @brief  判断用户是否已登录
 */
+ (BOOL)isLogin;

//+ (BOOL)isClearUserData;
/**
 *  登出
 */
+ (BOOL)logout;

/**
 清除本地用户缓存
 */
+ (BOOL)isClearUserData;
/**
 *  保存推送的deviceToken
 */
+ (BOOL)saveDeviceToken:(NSString *)token;
/**
 *  get推送的deviceToken
 */
+ (NSString *)getDeviceToken;
/**
 *  本地存储BadgeCount并发出通知
 */
+ (void)saveBadgeCount;
/**
 *  获取本地BadgeCount存储
 */
+ (NSInteger)getBadgeCount;
/**
 *  清除本地BadgeCount存储
 */
+ (void)clearLocalBadgeCount;
/**
 *  隐藏BadgeCount显示
 */
+ (void)hiddenBadgeCount;

@end
