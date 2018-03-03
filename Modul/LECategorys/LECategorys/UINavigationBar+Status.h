//
//  UINavigationBar+Status.h
//  状态栏
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 xiaojianwei. All rights reserved.
//
/**
 * 使用方法:
 * 1.导入头文件
 * 2.在视图滚动的方法中设置颜色
    例如:
 -(void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
    [self.navigationController.navigationBar aop_setBackgroundColor:[UIColor colorWithRed:0.255 green:0.682 blue:0.980 alpha:1.000]];
 
    CGFloat y = self.tableView.contentOffset.y;
    CGFloat alpha = (y - 40) / 100;
 
    if(y > 40)
    {
        self.navigationController.navigationBar.navBackgorundView.alpha = alpha;
    }
    else
    {
        self.navigationController.navigationBar.navBackgorundView.alpha = 0;
    }
 }
 * 3.设置视图加载和结束的时候tableView的代理
    例如:
 -(void)viewWillAppear:(BOOL)animated
 {
    self.tableView.delegate = self;
 }
 
 -(void)viewWillDisappear:(BOOL)animated
 {
    //[self.navigationController.navigationBar aop_clear];
    self.tableView.delegate = nil;
 }
 *
 */

#import <UIKit/UIKit.h>

@interface UINavigationBar (Status)

@property(nonatomic , weak)UIView *navBackgorundView;

/**
 *  在视图中加了navBackgorundView作为底部视图,只需要改变navBackgorundView的alpha即可实现上下滑渐变的效果
 */
- (void)aop_setBackgroundColor:(UIColor *)backgroundColor;

/**
 *  清空所有的设置  改回到原来的NavigationBar
 */
-(void)aop_clear;

@end
