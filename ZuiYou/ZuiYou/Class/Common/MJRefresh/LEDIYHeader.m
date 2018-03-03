//
//  LEDIYHeader.m
//  CreditAddressBook
//
//  Created by LE on 15/12/30.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "LEDIYHeader.h"

@implementation LEDIYHeader

#pragma mark - 重写方法
#pragma mark - 基本设置

- (void)prepare {
    [super prepare];
    // 设置普通状态的动画图片
//    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
//    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=10; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_to_refresh_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    [self setImages:refreshingImages forState:MJRefreshStateIdle];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
