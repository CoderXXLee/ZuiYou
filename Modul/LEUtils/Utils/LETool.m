
//
//  LETool.m
//  BLELamp
//
//  Created by LE on 16/1/18.
//  Copyright © 2016年 LE. All rights reserved.
//

#import "LETool.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>
#import <UIView+STHitTest.h>


static inline void swizzleSelector(Class originalClass, SEL originalSelector, Class swizzledClass, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

static inline BOOL addMethod(Class class, SEL selector, Method method) {
    return class_addMethod(class, selector, method_getImplementation(method),  method_getTypeEncoding(method));
}

@implementation LETool

#pragma mark - tableview
/**
 *  隐藏tableview多余分割线
 *
 *  @param tableView
 */
+ (void)setExtraCellLineHiddenWithTableView:(UITableView *)tableView {
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

/**
 用UIWebView的方式打电话，带有系统提示框
 */
+ (void)callWebWithPhone:(NSString *)phone complation:(void(^)(BOOL isSuccess))complation {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@" ,phone]];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    if(canOpen){//能打开
        UIWebView *callWebview = [[UIApplication sharedApplication].keyWindow viewWithTag:1099999999];
        if (!callWebview) {
            callWebview = [[UIWebView alloc] init];
            callWebview.tag = 1099999999;
            [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
        }
        [callWebview loadRequest:[NSURLRequest requestWithURL:url]];
    } else {
        if (complation) {
            complation(NO);
        }
    }
}

/*!
 *  @brief  格式化电话号码
 */
+ (NSString *)formatPhoneNumber:(NSString *)formatePhone {
    if ([formatePhone rangeOfString:@"-"].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if ([formatePhone rangeOfString:@"("].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    if ([formatePhone rangeOfString:@"·"].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@"·" withString:@""];
    }
    if ([formatePhone rangeOfString:@" "].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if ([formatePhone rangeOfString:@" "].length) {//\u00A0空格
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if ([formatePhone rangeOfString:@"+86"].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    }
    if (formatePhone.length > 20) {
        formatePhone = [formatePhone substringToIndex:12];
    }
    return formatePhone;
}
/*!
 *  @brief  本地推送通知
 */
+ (void)addLocalNotificationWithTitle:(NSString *)title body:(NSString *)body {
    //0.取消本地通知
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateBackground) {
        [app cancelAllLocalNotifications];
        // 1.创建通知
        UILocalNotification *localNote = [[UILocalNotification alloc] init];
        // 2.设置属性
        localNote.alertAction = title; // 操作标题
        localNote.alertBody = body; // 正文
        //    localNote.applicationIconBadgeNumber = 5;
        //    localNote.repeatInterval = NSCalendarUnitMinute;
        //    localNote.alertLaunchImage = @"Default"; // 点击通知, 打开程序时候现实的启动图片
        //    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
        // 3.注册通知(添加)
        //    UIApplication *app = [UIApplication sharedApplication];
        [app cancelAllLocalNotifications];
        [app scheduleLocalNotification:localNote];
        app.applicationIconBadgeNumber = 1;
    }
}
/*!
 *  MD5加密
 */
+ (NSString *)MD5:(NSString *)str {
    if (str && ![str isEqualToString:@""]) {
        const char *cStr = [str UTF8String];
        unsigned char result[16];
        CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
        return [NSString stringWithFormat:
                @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                result[0], result[1], result[2], result[3],
                result[4], result[5], result[6], result[7],
                result[8], result[9], result[10], result[11],
                result[12], result[13], result[14], result[15]
                ];
    }
    return nil;
}
/*!
 *  获取正在显示的window
 */
+ (UIWindow *)lastWindow {
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds) && ![window isKindOfClass:NSClassFromString(@"UITextEffectsWindow")] && !window.isHidden)
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

/**
 版本对比是否需要升级

 @param serNewVersion 新版本
 @param currentVersion 当前APP版本
 */
+ (BOOL)compareVersionUpdate:(NSString *)serNewVersion withCurrentVersion:(NSString *)currentVersion {
    NSArray *serVersionArr = [serNewVersion componentsSeparatedByString:@"."];
    NSArray *currentVersionArr = [currentVersion componentsSeparatedByString:@"."];
    
    NSInteger serVersionCount = [[serVersionArr componentsJoinedByString:@""] integerValue];
    NSInteger currentVersionCount = [[currentVersionArr componentsJoinedByString:@""] integerValue];
//    if (serVersionArr.count > currentVersionArr.count) {
//        currentVersionCount = currentVersionCount * pow(10, serVersionArr.count - currentVersionArr.count);
//    } else {
//        serVersionCount = serVersionCount * pow(10, currentVersionArr.count - serVersionArr.count);
//    }
    if (serVersionCount > currentVersionCount) {
        return YES;
    } else {
        return NO;
    }
}

/**
 添加阴影
 */
+ (void)addShadowWithView:(UIView *)view {
    ///1.设置阴影颜色
    view.layer.shadowColor = [UIColor colorWithRed:209.f/255.f green:209.f/255.f blue:209.f/255.f alpha:1].CGColor;
    ///2.设置阴影偏移范围
    view.layer.shadowOffset = CGSizeMake(0, 0);///CGSizeMake(0, 1)
    ///3.设置阴影颜色的透明度
    view.layer.shadowOpacity = 1;
    ///4.设置阴影半径
    view.layer.shadowRadius = 2;
//    [self addShadow:view shadowOffset:CGSizeMake(0, 1)];
}

/**
 添加地图上的view的阴影
 */
+ (void)addMapShadowWithView:(UIView *)view {
    ///1.设置阴影颜色
    view.layer.shadowColor = [UIColor colorWithWhite:.75 alpha:1].CGColor;
    ///2.设置阴影偏移范围
    view.layer.shadowOffset = CGSizeMake(1, 2);///CGSizeMake(0, 1)
    ///3.设置阴影颜色的透明度
    view.layer.shadowOpacity = 1;
    ///4.设置阴影半径
    view.layer.shadowRadius = 3;
    //    [self addShadow:view shadowOffset:CGSizeMake(0, 1)];
}

/**
 添加阴影
 */
+ (void)addShadow:(UIView *)view shadowOffset:(CGSize)offset {
    view.layer.shadowOffset = offset;
    view.layer.shadowRadius = 2;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.3f;
}

/**
 添加阴影
 */
+ (void)addShadow:(UIView *)view shadowOffset:(CGSize)offset color:(UIColor *)color {
    view.layer.shadowOffset = offset;
    view.layer.shadowRadius = 1.3;
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = 1.f;
}

/**
 添加阴影
 */
+ (void)addButtonShadow:(UIView *)view {
    [self addShadow:view shadowOffset:CGSizeMake(1, 1) color:[[UIColor blackColor] colorWithAlphaComponent:.2]];
}

/**
 *  将originalClass中的originalSEL更换为swizzledClass的swizzledSEL调用
 *
 *  @param originalClass
 *  @param originalSEL
 *  @param swizzledClass
 *  @param swizzledSEL
 */
+ (void)swizzleWhthOriginalClass:(Class)originalClass originalSEL:(SEL)originalSEL swizzledClass:(Class)swizzledClass swizzledSEL:(SEL)swizzledSEL {
    swizzleSelector(originalClass, originalSEL, swizzledClass, swizzledSEL);

    // 获取到UIWindow中sendEvent对应的method
    //    Method sendEvent = class_getInstanceMethod([UIWindow class], @selector(sendEvent:));
    //    Method sendEventMySelf = class_getInstanceMethod([self class], @selector(sendEventHooked:));

    // 将目标函数的原实现绑定到sendEventOriginalImplemention方法上
    //    IMP sendEventImp = method_getImplementation(sendEvent);
    //    class_addMethod([UIWindow class], @selector(sendEventOriginal:), sendEventImp, method_getTypeEncoding(sendEvent));

    // 然后用我们自己的函数的实现，替换目标函数对应的实现
    //    IMP sendEventMySelfImp = method_getImplementation(sendEventMySelf);
    //    class_replaceMethod([UIWindow class], @selector(sendEvent:), sendEventMySelfImp, method_getTypeEncoding(sendEvent));
}
/**
 *  给class添加一个方法：selector
 *
 *  @param class          添加方法的类
 *  @param selector       添加的方法的方法名
 *  @param targetClass    方法的实现类
 *  @param targetSelector 实现方法的函数
 */
+ (void)addMethodWhthClass:(Class)class selector:(SEL)selector targetClass:(Class)targetClass targetSelector:(SEL)targetSelector {
    Method afSuspendMethod = class_getInstanceMethod(targetClass, targetSelector);
    addMethod(class, selector, afSuspendMethod);
}

/*!
 *  设置透明->白色渐变背景色调
 */
+ (void)shadowAsInverse:(UIView *)view size:(CGSize)size {
    NSArray *colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:1 alpha:.1f].CGColor,(id)[UIColor colorWithWhite:1 alpha:.5f].CGColor,(id)[UIColor colorWithWhite:1 alpha:.9f].CGColor,[UIColor whiteColor].CGColor,nil];
    [self shadowAsInverse:view size:size colors:colors];
}

/*!
 *  设置渐变背景色调
    colors:CGColor数组
 */
+ (CALayer *)shadowAsInverse:(UIView *)view size:(CGSize)size colors:(NSArray *)colors {
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    CGRect newShadowFrame = CGRectMake(0, 0, size.width, size.height);
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合
    newShadow.colors = colors;
    [view.layer insertSublayer:newShadow atIndex:0];
    return newShadow;
}

/**
 ** frame:          虚线的frame
 ** lineLength:     单个虚线点的宽度
 ** lineSpacing:    单个虚线点间的间距
 ** lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (CAShapeLayer *)drawDashLineWithFrame:(CGRect)frame lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:(CGRect){CGPointZero, frame.size}];

    if (isHorizonal) {
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame))];
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame)/2)];
    }

//    [shapeLayer setFrame:frame];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(frame)];
    } else {
        [shapeLayer setLineWidth:CGRectGetWidth(frame)];
    }

    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];

    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);

    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(frame));
    }

    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
//    [lineView.layer addSublayer:shapeLayer];
    [shapeLayer setFrame:frame];
    return shapeLayer;
}

/**
 根据图片获取图片的主色调
 */
+ (UIColor *)mostColor:(UIImage *)image {
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif

    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(image.size.width, image.size.height);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //8：bits per component
    CGContextRef context = CGBitmapContextCreate(NULL, thumbSize.width, thumbSize.height, 8, thumbSize.width*4, colorSpace, bitmapInfo);

    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);

    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData(context);
    if (data == NULL) return nil;
    NSCountedSet *cls = [NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];

    for (int x = 0; x < thumbSize.width; x++) {
        for (int y = 0; y < thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha > 0) {//去除透明
                if (red == 255 && green == 255 && blue == 255) {//去除白色
                } else {
                    NSArray *clr = @[@(red), @(green), @(blue), @(alpha)];
                    [cls addObject:clr];
                }
            }
        }
    }
    CGContextRelease(context);

    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor = nil;
    NSUInteger MaxCount = 0;

    while ((curColor = [enumerator nextObject]) != nil) {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if (tmpCount <= MaxCount) continue;
        MaxCount = tmpCount;
        MaxColor = curColor;
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

/**
 设置滑动返回
 */
+ (void)setSwipeBack:(UIViewController *)vc {
    vc.view.pointInsideBlock = ^BOOL(CGPoint point, UIEvent *event, BOOL *returnSuper) {
        if (point.x <= 50) {
            return NO;
        }
        *returnSuper = YES;
        return YES;
    };
}

@end
