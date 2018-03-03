//
//  LETool.h
//  BLELamp
//
//  Created by LE on 16/1/18.
//  Copyright © 2016年 LE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LETool : NSObject

#pragma mark - tableview
/**
 *  隐藏tableview多余分割线
 *
 *  @param tableView
 */
+ (void)setExtraCellLineHiddenWithTableView:(UITableView *)tableView;

/**
 拨打电话，iOS10以后有系统默认弹窗，设置title将不起作用
 */
+ (void)callWithPhone:(NSString *)phone title:(NSString *)title complation:(void(^)(BOOL isSuccess))complation;

/**
 用UIWebView的方式打电话，带有系统提示框
 */
//+ (void)callWebWithPhone:(NSString *)phone complation:(void(^)(BOOL isSuccess))complation;
/*!
 *  @brief  格式化电话号码
 */
+ (NSString *)formatPhoneNumber:(NSString *)formatePhone;
/*!
 *  @brief  本地推送通知
 */
+ (void)addLocalNotificationWithTitle:(NSString *)title body:(NSString *)body;
/*!
 *  MD5加密
 */
+ (NSString *)MD5:(NSString *)str;
/*!
 *  获取正在显示的window
 */
+ (UIWindow *)lastWindow;

/**
 版本对比是否需要升级
 
 @param serNewVersion 新版本
 @param currentVersion 当前APP版本
 */
+ (BOOL)compareVersionUpdate:(NSString *)serNewVersion withCurrentVersion:(NSString *)currentVersion;

/**
 添加阴影
 */
+ (void)addShadowWithView:(UIView *)view;

/**
 添加地图上的view的阴影
 */
+ (void)addMapShadowWithView:(UIView *)view;

/**
 添加阴影
 */
+ (void)addShadow:(UIView *)view shadowOffset:(CGSize)offset;

/**
 添加阴影
 */
+ (void)addShadow:(UIView *)view shadowOffset:(CGSize)offset color:(UIColor *)color;

/**
 添加阴影
 */
+ (void)addButtonShadow:(UIView *)view;

/*!
 *  设置透明->白色渐变背景色调
 */
+ (void)shadowAsInverse:(UIView *)view size:(CGSize)size;

/*!
 *  设置渐变背景色调
 colors:CGColor数组
 */
+ (CALayer *)shadowAsInverse:(UIView *)view size:(CGSize)size colors:(NSArray *)color;

/**
 ** frame:          虚线的frame
 ** lineLength:     单个虚线点的宽度
 ** lineSpacing:    单个虚线点间的间距
 ** lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (CAShapeLayer *)drawDashLineWithFrame:(CGRect)frame lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;

/**
 *  给class添加一个方法：selector
 *
 *  @param class          添加方法的类
 *  @param selector       添加的方法的方法名
 *  @param targetClass    方法的实现类
 *  @param targetSelector 实现方法的函数
 */
+ (void)addMethodWhthClass:(Class)class selector:(SEL)selector targetClass:(Class)targetClass targetSelector:(SEL)targetSelector;

/**
 根据图片获取图片的主色调
 */
+ (UIColor *)mostColor:(UIImage *)image;

/**
 设置滑动返回
 */
+ (void)setSwipeBack:(UIViewController *)vc;

@end
