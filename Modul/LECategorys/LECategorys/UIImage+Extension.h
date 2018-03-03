//
//  UIImage+MJ.h
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
- (UIImage *)resizedImageWithLeft:(CGFloat)left top:(CGFloat)top;

/**
 *  根据所给颜色创建一张100*128的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据所给颜色以及size创建一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  图片压缩
 */
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
- (UIImage *)scaledToSize:(CGSize)newSize;

/**
 *  获取image的正方形区域size
 *
 *  @param image
 *
 *  @return
 */
+ (CGSize)squareWithImage:(UIImage *)image;
/**
 *  根据size获取image的等比例放大或者缩小size
 *
 *  @param image
 *  @param size
 *
 *  @return
 */
+ (CGSize)scaleWithImage:(UIImage *)image size:(CGSize)size;

/**
 根据size获取image的等比例放大或者缩小size
 */
- (CGSize)scaleWithSize:(CGSize)size;

/**
 将UIView转成UIImage
 */
+ (UIImage *)imageFromView:(UIView *)theView;

/**
 获得某个范围内的屏幕图像
 */
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r;

@end
