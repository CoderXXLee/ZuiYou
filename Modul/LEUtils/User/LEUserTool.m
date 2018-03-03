//
//  LEUserTool.m
//  Medical
//
//  Created by LE on 15/11/23.
//  Copyright © 2015年 LE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEUserTool.h"

//切换到主线程
#define dispatch_main_sync_safe_user(block)\
if ([NSThread isMainThread]) {\
block();\
}\
else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define LEUserFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"user.data"]
#define LELocationFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"location.data"]

//沙盒
#define LEUserDefaultsAddObj(obj, key) \
[[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; \

#define  LEUserDefaultsRemoveObj(key) \
NSUserDefaults *deft2 = [NSUserDefaults standardUserDefaults]; \
[deft2 removeObjectForKey:key]; \
[deft2 synchronize]; \

#define LEUserDefaultsGetObj(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

NSString *const kLEDeviceToken = @"kLEDeviceToken";
NSString *const kLEIsSetChannel = @"kLEIsSetChannel";
NSString *const kLEDeviceTokenID = @"kLEDeviceTokenID";
NSString *const kLEBadageCount = @"kLEBadageCount";
NSString *const _nLEUserToolUpdate = @"nLEUserToolUpdate";///user缓存更新通知
NSString *const _nLEUserToolLogout = @"nLEUserToolLogout";///退出登录通知

@implementation LEUserTool
/**
 *  保存用户登录信息
 */
+ (BOOL)saveUserLoginInfo:(id)user {
    LEUserData *userData = [[LEUserData alloc] init];
    userData.user = user;
    userData.loginInTime = [NSDate date];
    NSTimeInterval interval = 24*60*60*90;
    userData.expiresTime = [[NSDate alloc] initWithTimeIntervalSinceNow:interval];//获取90天后的日期
    
    BOOL result = [NSKeyedArchiver archiveRootObject:userData toFile:LEUserFile];
    if (result) {
        return YES;
    }
    return NO;
}
/**
 *  更新用户信息
 */
+ (BOOL)updateUserData:(id)user {
    //取出旧数据
    LEUserData *userData = [self userData];
    if (userData) {
        userData.user = user;
//        CYLog(@"更新用户信息:%@", user.examineStatus);
        ///序列化
        [NSKeyedArchiver archiveRootObject:userData toFile:LEUserFile];
        ///发出更新通知
        [[NSNotificationCenter defaultCenter] postNotificationName:_nLEUserToolUpdate object:nil userInfo:@{_nLEUserToolUpdate: user}];
        return YES;
    }
    return NO;
}
/**
 *  获取用户信息
 */
+ (LEUserData *)userData {
    // 取出账号
    LEUserData *account = [NSKeyedUnarchiver unarchiveObjectWithFile:LEUserFile];
    if (account) {
        // 判断账号是否过期
        NSDate *now = [NSDate date];
        if ([now compare:account.expiresTime] == NSOrderedAscending) { // 还没有过期
            return account;
        } else { // 过期
            [self logout];
            return nil;
        }
    }
    return nil;
}
/**
 *  获取用户信息
 */
+ (id)user {
    return [self userData].user;
}

/**
 block方式获取user，效果等同于+(id)user;
 success：成功获取user并返回user
 failure：用户未登录，或者获取user失败
 */
+ (void)getUserSuccess:(void(^)(id user))success failure:(void(^)(void))failure {
    id user = [self user];
    if (user) {
        if (success) {
            dispatch_main_sync_safe_user(^{
                success(user);
            });
        }
    } else {
        if (failure) {
            dispatch_main_sync_safe_user(^{
                failure();
            });
        }
    }
}

/*!
 *  @brief  判断用户是否已登录
 */
+ (BOOL)isLogin {
    id user = [self user];
    if (user) {
        return YES;
    }
    return NO;
}

/**
 清除用户缓存
 */
+ (BOOL)isClearUserData {
    NSFileManager * fileManager = [[NSFileManager alloc]init];
    if ([fileManager isDeletableFileAtPath:LEUserFile]) {
        [fileManager removeItemAtPath:LEUserFile error:nil];
        return YES;
    }
    return NO;
}

+ (BOOL)logout {
    //登出后清除本地归档信息
    BOOL result = [self isClearUserData];
    if (result) {
        //解除账号绑定
//        [[LEALBBPush shared] antiBindAccount];
        ///发出更新通知
        [[NSNotificationCenter defaultCenter] postNotificationName:_nLEUserToolLogout object:nil userInfo:nil];
        //登出后清除本地归档信息
//        LEUserDefaultsRemoveObj(kLEDeviceToken);
        return YES;
    }
    return NO;
}

#pragma mark-

+ (BOOL)saveDeviceToken:(NSString *)token {
    LEUserDefaultsAddObj(token, kLEDeviceToken);
    return YES;
}

+ (NSString *)getDeviceToken {
    return LEUserDefaultsGetObj(kLEDeviceToken);
}

+ (void)saveBadgeCount {
    //本地存储badage
    NSNumber *countSre = LEUserDefaultsGetObj(kLEBadageCount);
    if (!countSre) {
        countSre = @(0);
    }
    NSInteger newCount = countSre.integerValue;
    newCount++;
    LEUserDefaultsAddObj(@(newCount), kLEBadageCount);
    //个人中心提示
//    LEUser *user = [LEUserTool userData].user;
//    [[NSNotificationCenter defaultCenter] postNotificationName:nLEBadagePushNoti object:nil userInfo:@{kLEBadageCount: @(newCount)}];
//    [[NSNotificationCenter defaultCenter] postNotificationName:nLEBadageTabBarMe object:nil userInfo:@{kLEBadageCount: @(newCount)}];
    //图标提示
    [UIApplication sharedApplication].applicationIconBadgeNumber = newCount;
}

+ (NSInteger)getBadgeCount {
    NSNumber *count = LEUserDefaultsGetObj(kLEBadageCount);
    return count.integerValue;
}

+ (void)clearLocalBadgeCount {
    [self hiddenBadgeCount];
    LEUserDefaultsAddObj(@(0), kLEBadageCount);
}

+ (void)hiddenBadgeCount {
    //个人中心提示
//    [[NSNotificationCenter defaultCenter] postNotificationName:nLEBadagePushNoti object:nil userInfo:@{kLEBadageCount: @(0)}];
//    [[NSNotificationCenter defaultCenter] postNotificationName:nLEBadageTabBarMe object:nil userInfo:@{kLEBadageCount: @(0)}];
    //图标提示
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

@end
