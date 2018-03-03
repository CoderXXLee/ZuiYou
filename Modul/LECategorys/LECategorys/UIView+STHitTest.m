//
//  UIView+STHitTest.m
//  Pods
//
//  Created by mac on 2017/5/17.
//
//

#import "UIView+STHitTest.h"
#import <objc/runtime.h>

#if !defined(ST_EXTERN)
#define ST_EXTERN extern
#endif

ST_EXTERN void STExchangeSelectors(Class aClass, SEL oldSelector, SEL newSelector) {
    Method oldMethod = class_getInstanceMethod(aClass, oldSelector);
    Method newMethod = class_getInstanceMethod(aClass, newSelector);

    if (class_addMethod(aClass, oldSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(aClass, newSelector, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

@implementation UIView (STHitTest)

const static NSString *STHitTestViewBlockKey = @"STHitTestViewBlockKey";
const static NSString *STPointInsideBlockKey = @"STPointInsideBlockKey";

+ (void)load {
    STExchangeSelectors(self, @selector(hitTest:withEvent:), @selector(st_hitTest:withEvent:));
    STExchangeSelectors(self, @selector(pointInside:withEvent:), @selector(st_pointInside:withEvent:));
}

- (UIView *)st_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSMutableString *spaces = [NSMutableString stringWithCapacity:20];
    UIView *superView = self.superview;
    while (superView) {
        [spaces appendString:@"----"];
        superView = superView.superview;
    }
    //    NSLog(@"%@%@:[hitTest:withEvent:]", spaces, NSStringFromClass(self.class));
    UIView *deliveredView = nil;
    // 如果有hitTestBlock的实现，则调用block
    if (self.hitTestBlock) {
        BOOL returnSuper = NO;
        deliveredView = self.hitTestBlock(point, event, &returnSuper);
        if (returnSuper) {
            deliveredView = [self st_hitTest:point withEvent:event];
        }
    } else {
        deliveredView = [self st_hitTest:point withEvent:event];
    }
    //    NSLog(@"%@%@:[hitTest:withEvent:] Result:%@", spaces, NSStringFromClass(self.class), NSStringFromClass(deliveredView.class));
    return deliveredView;
}

- (BOOL)st_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSMutableString *spaces = [NSMutableString stringWithCapacity:20];
    UIView *superView = self.superview;
    while (superView) {
        [spaces appendString:@"----"];
        superView = superView.superview;
    }
    //    NSLog(@"%@%@:[pointInside:withEvent:]", spaces, NSStringFromClass(self.class));
    BOOL pointInside = NO;
    if (self.pointInsideBlock) {
        BOOL returnSuper = NO;
        pointInside =  self.pointInsideBlock(point, event, &returnSuper);
        if (returnSuper) {
            pointInside = [self st_pointInside:point withEvent:event];
        }
    } else {
        pointInside = [self st_pointInside:point withEvent:event];
    }
    return pointInside;
}

- (void)setHitTestBlock:(STHitTestViewBlock)hitTestBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(STHitTestViewBlockKey), hitTestBlock, OBJC_ASSOCIATION_COPY);
}

- (STHitTestViewBlock)hitTestBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(STHitTestViewBlockKey));
}

- (void)setPointInsideBlock:(STPointInsideBlock)pointInsideBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(STPointInsideBlockKey), pointInsideBlock, OBJC_ASSOCIATION_COPY);
}

- (STPointInsideBlock)pointInsideBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(STPointInsideBlockKey));
}

@end
