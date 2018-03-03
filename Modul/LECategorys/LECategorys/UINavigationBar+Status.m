//
//  UINavigationBar+Status.m
//  状态栏
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 xiaojianwei. All rights reserved.
//

#import "UINavigationBar+Status.h"
#import <objc/runtime.h>

static char key;
@implementation UINavigationBar (Status)
-(UIView *)navBackgorundView
{
    return objc_getAssociatedObject(self, &key);
}

-(void)setNavBackgorundView:(UIView *)navBackgorundView
{
    objc_setAssociatedObject(self, &key, navBackgorundView, OBJC_ASSOCIATION_ASSIGN);
}

/**
 *  内部实现了自己加一层视图放在bar上面
 */
-(void)aop_setBackgroundColor:(UIColor *)backgroundColor
{
    if(self.navBackgorundView == nil)
    {
        //取消高斯效果
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //取消阴影线
        self.shadowImage = [UIImage new];
        
        //利用runtime生成setget方法
        UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        self.navBackgorundView = bgview;
        //将背景图放在最上层
        [self insertSubview:self.navBackgorundView atIndex:0];
    }
    
    //设置颜色
    self.navBackgorundView.backgroundColor = backgroundColor;
}


-(void)aop_clear
{
    //高斯效果
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //阴影线
    self.shadowImage = nil;
    
    //清除底部视图
    [self.navBackgorundView removeFromSuperview];
    self.navBackgorundView = nil;
}

@end
