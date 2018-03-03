//
//  UIView+GeneralUIViewInterface.h
//
//
//  Created by MaoBing Ran on 16/3/2.
//  Copyright © 2016年 com.vince. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (GeneralUIViewInterface)
- (UIViewController *)viewController:(UIView *)view;
@end


@interface UILabel (Ex)
/**
 *  获取指定字体大小的指定字符串尺寸
 *
 *  @param string 字符串
 *  @param size   字体尺寸
 *
 *  @return 字体尺寸
 */
+ (CGSize)sizeOfLabelText:(NSString *)labelText sizeOfTextFont:(CGFloat)size;

+ (void)setLabel:(UILabel *)label StartWithText:(NSString *)startText fontSizeOfStartText:(CGFloat)startSize andEndWithText:(NSString *)endText fontSizeOfEndText:(CGFloat)endSize;

@end


@interface UIImage (Ex)
+ (UIImage *)getImageFromURL:(NSString *)fileURL;

+ (UIImage *)imageWithName:(NSString *)name type:(NSString *)type;

+ (UIImage *)pngImageWithName:(NSString *)name;

+ (UIImage *)jpgImageWithName:(NSString *)name;

- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height;
@end


@interface UIButton (Ex)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end