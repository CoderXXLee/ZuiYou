//
//  UIView+LEBadge.m
//  Medical
//
//  Created by LE on 15/12/5.
//  Copyright © 2015年 LE. All rights reserved.
//

#import "UIView+LEBadge.h"
#import "RKNotificationHub.h"
#import "LECommon.h"
#import "LEUserTool.h"
#import <objc/runtime.h>
#import <NSString+Extension.h>

static NSString *const _nBadgeUserInfoKey = @"nBadgeUserInfoKey";
static char loadOperationKey;
//static char RKNotificationHubKey;

//const static NSString *RKNotificationHubKey = @"RKNotificationHubKey";

static NSString *const RKBadgePrefix = @"RKBadgePrefix";///保存Badge的key的前缀

@implementation UIView (LEBadge)

#pragma mark - LazyLoad
#pragma mark - Super
#pragma mark - Init
#pragma mark - PublicMethod

/**
 获取RKNotificationHub
 */
- (RKNotificationHub *)notificationHubWithKey:(NSString *)key {
    RKNotificationHub *bud = [[self operationDictionary] objectForKey:key];
    return bud;
}

/**
 添加提示点, 同一个view中可以添加多个RKNotificationHub
 */
- (void)addBadge:(NSUInteger)amount scale:(CGFloat)scale point:(CGPoint)point key:(NSString *)key {
    RKNotificationHub *bud = [[RKNotificationHub alloc] initWithView:self];
    //rgba(52,168,79,1)
//    [bud setCircleColor:[UIColor colorWithRed:52/255.f green:168/255.f blue:79/255.f alpha:1] labelColor:[UIColor colorWithRed:52/255.f green:168/255.f blue:79/255.f alpha:1]];
    [bud moveCircleByX:point.x Y:point.y];
    //    [_bud hideCount]; // uncomment for a blank badge
    [bud scaleCircleSizeBy:scale];
    //存储RKNotificationHub
    [self setOperation:bud forKey:key];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incrementNoti:) name:key object:nil];

    //首次创建查看本地通知数
    //    [bud incrementBy:[LEUserTool getBadgeCount]];
    ///首次创建加载本地通知数
    NSNumber *badgeCache =  LEUserDefaultsGetObj([RKBadgePrefix stringByAppendingString:key]);
    if (badgeCache && badgeCache.intValue > 0) {
        amount += badgeCache.intValue;
    }

    if (amount > 0) {
        [bud setCount:amount];
        //    [_bud pop];
        //    [_bud blink];
        [bud bump];
    }

    ///清除缓存
    LEUserDefaultsRemoveObj([RKBadgePrefix stringByAppendingString:key]);
}
/**
 添加黑色数字
 */
- (void)addBlackNumberBadge:(NSUInteger)amount scale:(CGFloat)scale point:(CGPoint)point key:(NSString *)key {
    RKNotificationHub *bud = [[RKNotificationHub alloc] initWithView:self];
    [bud moveCircleByX:point.x Y:point.y];
    //    [_bud hideCount]; // uncomment for a blank badge
    [bud scaleCircleSizeBy:scale];
    //存储RKNotificationHub
    [self setOperation:bud forKey:key];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(incrementNoti:) name:key object:nil];
    
    //首次创建查看本地通知数
    //    [bud incrementBy:[LEUserTool getBadgeCount]];
    ///首次创建加载本地通知数
    NSNumber *badgeCache =  LEUserDefaultsGetObj([RKBadgePrefix stringByAppendingString:key]);
    if (badgeCache && badgeCache.intValue > 0) {
        amount += badgeCache.intValue;
    }
    
    if (amount > 0) {
        [bud setCount:amount];
        //    [_bud pop];
        //    [_bud blink];
        [bud bump];
    }
    
    ///清除缓存
    LEUserDefaultsRemoveObj([RKBadgePrefix stringByAppendingString:key]);
}
- (void)addBadgeHUDWithScale:(CGFloat)scale NotificationKey:(NSString *)key {
    [self addBadgeHUDWithScale:scale point:CGPointMake(-5, 0) NotificationKey:key];
}

- (void)addBadgeHUDWithScale:(CGFloat)scale point:(CGPoint)point NotificationKey:(NSString *)key {
    [self addBadge:0 scale:scale point:point key:key];
}

/**
 设置提示点数
 */
- (void)setBadge:(NSUInteger)amount key:(NSString *)key {
    RKNotificationHub *bud = [[self operationDictionary] objectForKey:key];
    [bud setCount:amount];
    //    [_bud pop];
    //    [_bud blink];
    [bud bump];
}

/**
 发送通知
 */
+ (void)postBadgeNotificationName:(NSString *)key badge:(NSInteger)badge {
    if (!LEStrNotEmpty(key)) return;
    ///测试提示红点
    [[NSNotificationCenter defaultCenter] postNotificationName:key object:nil userInfo:@{_nBadgeUserInfoKey: @(badge)}];
    ///缓存
    LEUserDefaultsAddObj(@(badge), [RKBadgePrefix stringByAppendingString:key]);
}

- (void)clearBadgeHUD {
    [LEUserTool clearLocalBadgeCount];
}

#pragma mark - PrivateMethod

- (void)setOperation:(id)operation forKey:(NSString *)key {
    NSMutableDictionary *operationDictionary = [self operationDictionary];
    [operationDictionary setObject:operation forKey:key];
}

- (NSMutableDictionary *)operationDictionary {
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey);
    if (operations) {
        return operations;
    }
    operations = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operations;
}

///**
// 新建唯一RKNotificationHub
// */
//- (RKNotificationHub *)notificationHub {
//    RKNotificationHub *operations = objc_getAssociatedObject(self, &RKNotificationHubKey);
//    if (operations) {
//        return operations;
//    }
//    operations = [[RKNotificationHub alloc] initWithView:self];
//    objc_setAssociatedObject(self, &RKNotificationHubKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    return operations;
//}

//- (void)setNotificationHub:(RKNotificationHub *)notificationHub {
//    objc_setAssociatedObject(self, (__bridge const void *)(RKNotificationHubKey), notificationHub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (RKNotificationHub *)notificationHub {
//    return objc_getAssociatedObject(self, (__bridge const void *)(RKNotificationHubKey));
//}

#pragma mark - Events

/**
 接收通知
 */
- (void)incrementNoti:(NSNotification *)noti {
    RKNotificationHub *bud = [[self operationDictionary] objectForKey:noti.name];
    NSDictionary *userInfo = noti.userInfo;
    NSNumber *countStr = userInfo[_nBadgeUserInfoKey];
    NSInteger count = countStr.integerValue;
    //    [_bud increment];
    [bud setCount:count];
    //    [_bud pop];
    //    [_bud blink];
    [bud bump];

    ///清除缓存
    LEUserDefaultsRemoveObj([RKBadgePrefix stringByAppendingString:noti.name]);
}

#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end
