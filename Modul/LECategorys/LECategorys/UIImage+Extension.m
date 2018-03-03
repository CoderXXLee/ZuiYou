//
//  UIImage+MJ.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithName:(NSString *)name
{
    NSString *newName = [name stringByAppendingString:@"_os7"];
    UIImage *image = [UIImage imageNamed:newName];
    if (image == nil) { // 没有_os7后缀的图片
        image = [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

- (UIImage *)resizedImageWithLeft:(CGFloat)left top:(CGFloat)top {
    return [self stretchableImageWithLeftCapWidth:self.size.width * left topCapHeight:self.size.height * top];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGFloat imageW = 100;
    CGFloat imageH = 128;
    CGSize size = CGSizeMake(imageW, imageH);
    UIImage *image = [self imageWithColor:color size:size];
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGFloat imageW = size.width;
    CGFloat imageH = size.height;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//对图片尺寸进行压缩--
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    newSize = [self scaleWithImage:image size:newSize];
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    if (!newImage) {
//        LELog(@"压缩失败！");
        return image;
    }
    
    // Return the new image.
    return newImage;
}
- (UIImage *)scaledToSize:(CGSize)newSize {
    newSize = [UIImage scaleWithImage:self size:newSize];
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);

    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];

    // Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    // End the context
    UIGraphicsEndImageContext();

    if (!newImage) {
        //        LELog(@"压缩失败！");
        return self;
    }
    // Return the new image.
    return newImage;
}
/**
 *  根据size获取image的等比例放大或者缩小size
 *
 *  @param image
 *  @param size
 *
 *  @return
 */
+ (CGSize)scaleWithImage:(UIImage *)image size:(CGSize)size {
    CGSize imageSize = image.size;
    if (imageSize.width > imageSize.height) {
        size.height = image.size.height * (size.width / imageSize.width);
        
    } else {
        size.width = imageSize.width * (size.height / imageSize.height);
    }
    return size;
}
- (CGSize)scaleWithSize:(CGSize)size {
    CGSize imageSize = self.size;
    if (imageSize.width > imageSize.height) {
        size.height = self.size.height * (size.width / imageSize.width);

    } else {
        size.width = imageSize.width * (size.height / imageSize.height);
    }
    return size;
}
/**
 *  获取image的正方形区域size
 *
 *  @param image
 *
 *  @return
 */
+ (CGSize)squareWithImage:(UIImage *)image {
    CGSize imageSize = image.size;
    CGFloat width, height;
    if (imageSize.width > imageSize.height) {
        height = imageSize.height;
        width = height;
    } else {
        width = imageSize.width;
        height = width;
    }
    return CGSizeMake(width, height);
}

+ (UIImage *)verticalImageFromArray:(NSArray *)imagesArray {
    UIImage *unifiedImage = nil;
    CGSize totalImageSize = [self verticalAppendedTotalImageSizeFromImagesArray:imagesArray];
    UIGraphicsBeginImageContextWithOptions(totalImageSize, NO, 0.f);
    // For each image found in the array, create a new big image vertically
    int imageOffsetFactor = 0;
    for (UIImage *img in imagesArray) {
        [img drawAtPoint:CGPointMake(0, imageOffsetFactor)];
        imageOffsetFactor += img.size.height;
    }
    
    unifiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return unifiedImage;
}

+ (CGSize)verticalAppendedTotalImageSizeFromImagesArray:(NSArray *)imagesArray {
    CGSize totalSize = CGSizeZero;
    for (UIImage *im in imagesArray) {
        CGSize imSize = [im size];
        totalSize.height += imSize.height;
        // The total width is gonna be always the wider found on the array
        totalSize.width = MAX(totalSize.width, imSize.width);
    }
    return totalSize;
}

/**
 将UIView转成UIImage
 */
+ (UIImage *)imageFromView:(UIView *)theView {
    //UIGraphicsBeginImageContext(theView.bounds.size);iPhone4
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(theView.bounds.size, NO, [UIScreen mainScreen].scale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

/**
 获得某个范围内的屏幕图像
 */
+ (UIImage *)imageFromView:(UIView *)theView atFrame:(CGRect)r {
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}

/**
 将图片转化成PNG格式输出
 */
- (UIImage *)imageToPNG {
    if (self) {
        UIImage *img =  [UIImage imageWithData:UIImagePNGRepresentation(self)];
        return img;
    }
    return self;
}

/**
 将图片转化成JPEG格式输出
 */
- (UIImage *)imageToJPEG {
    if (self) {
        UIImage *img =  [UIImage imageWithData:UIImageJPEGRepresentation(self, 1.0)];
        return img;
    }
    return self;
}

@end
