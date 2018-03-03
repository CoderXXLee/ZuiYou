//
//  UIImage+DY.m
//  DYMainViewController
//
//  Created by 杜宇 on 15/8/6.
//  Copyright (c) 2015年 杜宇. All rights reserved.
//

#import "UIImage+DY.h"

// 图片底色处理
@implementation UIImage (DY)
+ (UIImage *)grayscale:(UIImage *)anImage type:(int)type
{
    CGImageRef imageRef = anImage.CGImage;
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data);
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8 *tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            UInt8 brightness;
            switch (type) {
                case 1:
                    // 黑白
                    brightness = (77 * red + 28 * green + 151 * blue) / 256;
                    *(tmp + 0) = brightness;
                    *(tmp + 1) = brightness;
                    *(tmp + 2) = brightness;
                    break;
                case 2:
                    // 原图（变淡）
                    *(tmp + 0) = red;
                    *(tmp + 1) = green * 0.7;
                    *(tmp + 2) = blue * 0.4;
                    break;
                case 3:
                    // 曝光
                    *(tmp + 0) = 255 - red;
                    *(tmp + 1) = 255 - green;
                    *(tmp + 2) = 255 - blue;
                    break;
                default:
                    *(tmp + 0) = red;
                    *(tmp + 1) = green;
                    *(tmp + 2) = blue;
                    break;
            }
        }
    }
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    CGImageRef effectedCgImage = CGImageCreate(width, height,bitsPerComponent, bitsPerPixel, bytesPerRow,colorSpace, bitmapInfo, effectedDataProvider,NULL, shouldInterpolate, intent);
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    return effectedImage;
}

// 图片裁剪成圆,加边框
+ (UIImage *)circleWithImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
//    UIImage *oldImage = oldImage;
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 自定义大小裁剪图片
+ (NSData *)imageDataWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}

// 打水印
+ (UIImage *)waterImageWithBg:(UIImage *)bg logo:(UIImage *)logo
{
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    UIGraphicsBeginImageContextWithOptions(bg.size, NO, 0.0);
    
    // 2.画背景
    [bg drawInRect:CGRectMake(0, 0, bg.size.width, bg.size.height)];
    
    // 3.画右下角的水印
    CGFloat scale = 0.2;
    CGFloat margin = 5;
    CGFloat waterW = logo.size.width * scale;
    CGFloat waterH = logo.size.height * scale;
    CGFloat waterX = bg.size.width - waterW - margin;
    CGFloat waterY = bg.size.height - waterH - margin;
    [logo drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  根据CGRect裁剪图片
 */
- (UIImage *)croppedImageWithCGRect:(CGRect)rect {
    //Calculate rect that needs to be cropped
//    CGRect visibleRect = self.resizableCropArea ? [self _calcVisibleRectForResizeableCropArea] : [self _calcVisibleRectForCropArea];
//    
//    //transform visible rect to image orientation
//    CGAffineTransform rectTransform = [self _orientationTransformedRectOfImage:self.imageToCrop];
//    visibleRect = CGRectApplyAffineTransform(visibleRect, rectTransform);
    
    //finally crop image
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
//    UIImage *result = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return result;
}

/**
 *  给图片加文字水印
 *
 *  @param str     水印文字
 *  @param strRect 文字所在的位置大小
 *  @param attri   文字的相关属性，自行设置
 *
 *  @return 加完水印文字的图片
 */
- (UIImage *)imageWaterMarkWithString:(NSString*)str rect:(CGRect)strRect attribute:(NSDictionary *)attri {
    return [self imageWaterMarkOptionsWithString:str rect:strRect attribute:attri image:nil imageRect:CGRectZero alpha:0];
}

/**
 给图片加文字水印

 @param str 水印文字
 @param point 文字所在的位置
 @param attri 文字的相关属性，自行设置
 @return 加完水印文字的图片
 */
- (UIImage *)imageWaterMarkWithString:(NSString*)str point:(CGPoint)point attribute:(NSDictionary *)attri {
    return [self imageWaterMarkWithString:str point:point attribute:attri image:nil imagePoint:CGPointZero alpha:0];
}

/**
 给图片加文字水印

 @param str 水印文字
 @param point 文字所在的位置
 @param attri 文字的相关属性，自行设置
 @return 加完水印文字的图片
 */
- (UIImage *)imageWaterMarkWithAttributedString:(NSAttributedString *)str point:(CGPoint)point {
    return [self imageWaterMarkWithAttributedString:str point:point image:nil imagePoint:CGPointZero alpha:0];
}

- (UIImage *)imageWaterMarkWithString:(NSString*)str rect:(CGRect)strRect attribute:(NSDictionary *)attri image:(UIImage *)image imageRect:(CGRect)imgRect alpha:(CGFloat)alpha {
    ///iPhone4
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    if (image) {
        [image drawInRect:imgRect blendMode:kCGBlendModeNormal alpha:alpha];
    }

    if (str) {
        [str drawInRect:strRect withAttributes:attri];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)imageWaterMarkOptionsWithString:(NSString*)str rect:(CGRect)strRect attribute:(NSDictionary *)attri image:(UIImage *)image imageRect:(CGRect)imgRect alpha:(CGFloat)alpha {
    //UIGraphicsBeginImageContext(self.size);iPhone4
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    if (image) {
        [image drawInRect:imgRect blendMode:kCGBlendModeNormal alpha:alpha];
    }

    if (str) {
        [str drawInRect:strRect withAttributes:attri];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)imageWaterMarkWithString:(NSString*)str point:(CGPoint)strPoint attribute:(NSDictionary*)attri image:(UIImage*)image imagePoint:(CGPoint)imgPoint alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [self drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeNormal alpha:1.0];
    if (image) {
        [image drawAtPoint:imgPoint blendMode:kCGBlendModeNormal alpha:alpha];
    }

    if (str) {
        [str drawAtPoint:strPoint withAttributes:attri];

    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (UIImage *)imageWaterMarkWithAttributedString:(NSAttributedString *)str point:(CGPoint)strPoint image:(UIImage*)image imagePoint:(CGPoint)imgPoint alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    [self drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeNormal alpha:1.0];
    if (image) {
        [image drawAtPoint:imgPoint blendMode:kCGBlendModeNormal alpha:alpha];
    }

    if (str) {
        [str drawAtPoint:strPoint];
    }
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
