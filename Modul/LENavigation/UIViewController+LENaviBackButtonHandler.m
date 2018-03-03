//
//  UIViewController+LEBackButtonHandler.m
//  CreditAddressBook
//
//  Created by LE on 16/1/17.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import "UIViewController+LENaviBackButtonHandler.h"
#import <objc/runtime.h>

#if !defined(LE_EXTERN)
#define LE_EXTERN extern
#endif

LE_EXTERN void LEExchangeSelectors(Class aClass, SEL oldSelector, SEL newSelector) {
    Method oldMethod = class_getInstanceMethod(aClass, oldSelector);
    Method newMethod = class_getInstanceMethod(aClass, newSelector);

    if (class_addMethod(aClass, oldSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))) {
        class_replaceMethod(aClass, newSelector, method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

@implementation UIViewController (LENaviBackButtonHandler)

const static NSString *LEViewDidDisappearBlockKey = @"LEViewDidDisappearBlockKey";

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        LEExchangeSelectors(self, @selector(viewDidDisappear:), @selector(le_viewDidDisappear:));
        LEExchangeSelectors(self, @selector(viewDidAppear:), @selector(le_viewDidAppear:));
    });
}

- (void)le_viewDidDisappear:(BOOL)animated {
    if (self.viewDidDisappearBlock) {
        self.viewDidDisappearBlock();
    }
    [self le_viewDidDisappear:animated];
    self.viewDidDisappearBlock = nil;
}

- (void)le_viewDidAppear:(BOOL)animated {
    if (self.viewDidDisappearBlock) self.viewDidDisappearBlock = nil;
    [self le_viewDidAppear:animated];
}

- (void)setViewDidDisappearBlock:(LEViewDidDisappearBlock)viewDidDisappearBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(LEViewDidDisappearBlockKey), viewDidDisappearBlock, OBJC_ASSOCIATION_COPY);
}

- (LEViewDidDisappearBlock)viewDidDisappearBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(LEViewDidDisappearBlockKey));
}

@end
