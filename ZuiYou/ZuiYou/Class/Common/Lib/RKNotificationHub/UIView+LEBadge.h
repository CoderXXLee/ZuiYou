//
//  UIView+LEBadge.h
//  Medical
//
//  Created by LE on 15/12/5.
//  Copyright © 2015年 LE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKNotificationHub.h"

@interface UIView (LEBadge)

/**
 获取RKNotificationHub
 */
- (RKNotificationHub *)notificationHubWithKey:(NSString *)key;

/**
 发送通知
 */
+ (void)postBadgeNotificationName:(NSString *)key badge:(NSInteger)badge;

/**
 添加提示点, 同一个view中可以添加多个RKNotificationHub
 通过key来识别
 */
- (void)addBadge:(NSUInteger)amount scale:(CGFloat)scale point:(CGPoint)point key:(NSString *)key;

/**
 设置提示点数
 */
- (void)setBadge:(NSUInteger)amount key:(NSString *)key;

- (void)addBadgeHUDWithScale:(CGFloat)scale NotificationKey:(NSString *)key;
- (void)addBadgeHUDWithScale:(CGFloat)scale point:(CGPoint)point NotificationKey:(NSString *)key;
- (void)clearBadgeHUD;
@end
