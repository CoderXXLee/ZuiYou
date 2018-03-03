//
//  UIView+GeneralUIViewInterface.m
//
//
//  Created by MaoBing Ran on 16/3/2.
//  Copyright © 2016年 com.vince. All rights reserved.
//

#import "UIView+GeneralUIViewInterface.h"

@implementation UIView (GeneralUIViewInterface)
- (UIViewController *)viewController:(UIView *)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end

@implementation UILabel (Ex)
+ (CGSize)sizeOfLabelText:(NSString *)labelText sizeOfTextFont:(CGFloat)size
{
    return [labelText sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:size]}];
}

+ (void)setLabel:(UILabel *)label StartWithText:(NSString *)startText fontSizeOfStartText:(CGFloat)startSize andEndWithText:(NSString *)endText fontSizeOfEndText:(CGFloat)endSize
{
    NSMutableAttributedString *startAttributedString = [[NSMutableAttributedString alloc] initWithString:startText];
    NSMutableAttributedString *endAttributedString = [[NSMutableAttributedString alloc] initWithString:endText];
    [startAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:startSize] range:NSMakeRange(0, startAttributedString.length)];
    [endAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:endSize] range:NSMakeRange(0, endAttributedString.length)];
    [startAttributedString appendAttributedString:endAttributedString];
    CGSize startAttributedStringSize = [startText sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:startSize]}];
    CGSize endAttributedStringSize = [endText sizeWithAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:endSize]}];
    label.attributedText = startAttributedString;
    [label setFrame:CGRectMake(0, 0, startAttributedStringSize.width + endAttributedStringSize.width, startAttributedStringSize.height > endAttributedStringSize.height ? startAttributedStringSize.height : endAttributedStringSize.height)];
}
@end

@implementation UIImage (Ex)

+ (UIImage *) getImageFromURL:(NSString *)imageURL
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
    return [UIImage imageWithData:data];
}

+ (UIImage *)imageWithName:(NSString *)name type:(NSString *)type
{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:type]];
}

+ (UIImage *)pngImageWithName:(NSString *)name
{
    return [UIImage imageWithName:name type:@"png"];
}

+ (UIImage *)jpgImageWithName:(NSString *)name
{
    return [UIImage imageWithName:name type:@"jpg"];
}

- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height {
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}
@end


@implementation UIButton (Ex)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return image;
}

@end