//
//  LECommon.h
//  Medical
//
//  Created by LE on 14/11/19.
//  Copyright © 2014年 Lee. All rights reserved.
//

//#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

//==================字符串化==================
#define STRINGIZE_(x)  #x
#define STRINGIZE2(x)  STRINGIZE_(x)
#define OCNSSTRING(x) @STRINGIZE2(x)
//===================end=====================

//=============================weak/strong================================

//weakSelf
#define LEWeakObject(name, obj) __weak __typeof (obj)name = obj;
//strongSelf
#define LEStrongObject(name, obj) __strong __typeof (obj)name = obj;

#define LEWself LEWeakObject(wself, self)
#define LESself LEStrongObject(sself, wself)

//#ifndef LEWeakify

#if DEBUG
#define le_keywordify @autoreleasepool {}
#else
#define le_keywordify @try {} @catch (...) {}
#endif

#define le_metamacro_concat(A, B) A ## B

#define le_weakify_(VAR) \
__weak __typeof__(VAR) le_metamacro_concat(VAR, _weak_) = (VAR);

#define le_strongify_(VAR) \
__strong __typeof__(VAR) VAR = le_metamacro_concat(VAR, _weak_);

#define LEWeakify(x) \
le_keywordify \
le_weakify_(x)

#define LEStrongify(x) \
le_keywordify \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
le_strongify_(x) \
_Pragma("clang diagnostic pop")

#define LEWeakifySelf LEWeakify(self)
#define LEStrongifySelf LEStrongify(self)

//=============================end================================

//判断是否为iOS8
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0)
//判断是否为iOS9
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 10.0)
//判断是否为iOS11
#define iOS11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 12.0)

#ifndef __IPHONE_9_0
#define __IPHONE_9_0 90000
#endif

#define IS_IOS9 __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0

#ifndef __IPHONE_11_0
#define __IPHONE_11_0 110000
#endif

#define IS_IOS11 __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0

//自定义LOG
#ifdef DEBUG
#define LELog(...) NSLog(__VA_ARGS__)
#else
#define LELog(...)
#endif

//定义颜色函数
#define LEColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//通知
#define LENotificationCenter [NSNotificationCenter defaultCenter]

//自定义Error
#define LEErrorNil [NSError errorWithDomain:@"jsonFailMsg" code:-1 userInfo:@{@"message":@"没有更多数据"}]
#define LEError(m, c) [NSError errorWithDomain:@"jsonFailMsg" code:c userInfo:@{@"message":m}]

//屏幕size
#define LEScreeSize [UIScreen mainScreen].bounds.size

//提示框
#define LEAlertViewPlain(m) [[[UIAlertView alloc] initWithTitle:nil message:m delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
//提示框
#define LEAlertView1(t,m) [[[UIAlertView alloc] initWithTitle:t message:m delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];

//判断字符串是否相同
#define LEStringEqualTo(a, b) [a isEqualToString:b]
#define LEStringFormat(a, b ...) [NSString stringWithFormat:a, b]

//NSString -> NSURL
#define LEURLWithString(u) [NSURL URLWithString:u]

//沙盒
#define LEUserDefaultsAddObj(obj, key) \
[[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]; \
[[NSUserDefaults standardUserDefaults] synchronize]; \

#define  LEUserDefaultsRemoveObj(key) \
NSUserDefaults *deft2 = [NSUserDefaults standardUserDefaults]; \
[deft2 removeObjectForKey:key]; \
[deft2 synchronize]; \

#define LEUserDefaultsGetObj(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

//================自定义对象存储======================
#define LEDataFilePath(key) \
[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[key stringByAppendingString:@".data"]]
//存储
#define LEKeyedArchiverObj(obj, key) \
[NSKeyedArchiver archiveRootObject:obj toFile:LEDataFilePath(key)];
//取出
#define LEKeyedUnarchiverObj(key) \
[NSKeyedUnarchiver unarchiveObjectWithFile:LEDataFilePath(key)];
//=================end==============================

//切换到主线程
#define dispatch_main_sync_safe_le(block)\
if ([NSThread isMainThread]) {\
block();\
}\
else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

//动画
#define LEMoveAnimation(animationBlock, completionBlock)\
[UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.98 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:animationBlock completion:completionBlock];

#define LEAnimation(duration, animationBlock, completionBlock)\
[UIView animateWithDuration:duration delay:0 usingSpringWithDamping:.98 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:animationBlock completion:completionBlock];


//获取APP版本号
#define APPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//接口版本号
#define APIVersion APPVersion

//1px
#define LE_1PX_WIDTH (1 / [UIScreen mainScreen].scale)

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define LEScreenHeight ([[UIScreen mainScreen]bounds].size.height)
#define LEScreenWidth ([[UIScreen mainScreen]bounds].size.width)
#define SCREEN_MAX_LENGTH (MAX(LEScreenWidth, LEScreenHeight))
#define SCREEN_MIN_LENGTH (MIN(LEScreenWidth, LEScreenHeight))

//手机尺寸判断
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5_SE (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6_7 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P_7P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

//在不同的手机上对应的字体大小可能不同，一般的来说在 iphone 4 5 6 7的手机上的字体是一样大小，在6P/7P上的字体是4 5 6 7上的1.5倍，
#define SizeScale ((IS_IPHONE_6P_7P) ? SCREEN_MAX_LENGTH/568 : 1)


