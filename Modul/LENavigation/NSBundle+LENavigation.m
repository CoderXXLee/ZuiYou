//
//  NSBundle+LENavigation.m
//  LENavigation
//
//  Created by mac on 2018/3/1.
//

#import "NSBundle+LENavigation.h"
#import "LENavigationController.h"

@implementation NSBundle (LENavigation)

+ (instancetype)le_navigationBundle {
    static NSBundle *navigationBundle = nil;
    if (navigationBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        NSBundle *bundle = [NSBundle bundleForClass:[LENavigationController class]];
        navigationBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"LENavigationImage" ofType:@"bundle"]];
//        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"LENavigation" withExtension:@"bundle"];
//        navigationBundle = [NSBundle bundleWithURL:bundleURL];
    }
    return navigationBundle;
}

+ (UIImage *)le_backImage {
    static UIImage *backImage = nil;
    if (backImage == nil) {
//        backImage = [[UIImage imageWithContentsOfFile:[[self le_navigationBundle] pathForResource:@"common_title_bar_ic_back_normal@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        backImage = [UIImage imageNamed:@"common_title_bar_ic_back_normal" inBundle:[self le_navigationBundle] compatibleWithTraitCollection:nil];
    }
    return backImage;
}

@end
