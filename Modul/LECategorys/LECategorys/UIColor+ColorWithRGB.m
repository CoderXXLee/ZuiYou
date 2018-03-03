//
//  UIColor+ColorWithRGB.m
//  CallCar
//
//  Created by MaoBing Ran on 15/10/30.
//  Copyright © 2015年 com. All rights reserved.
//

#import "UIColor+ColorWithRGB.h"

@implementation UIColor (ColorWithRGB)
- (UIColor *)colorWithR:(int)r G:(int)g B:(int)b
{
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}

+ (UIColor *)colorWithR:(int)r G:(int)g B:(int)b
{
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0];
}
@end
