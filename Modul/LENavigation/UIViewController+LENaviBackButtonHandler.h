//
//  UIViewController+LEBackButtonHandler.h
//  CreditAddressBook
//
//  Created by LE on 16/1/17.
//  Copyright © 2016年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LEViewDidDisappearBlock)(void);

@protocol BackButtonHandlerProtocol <NSObject>

@optional

/**
 在UIViewController派生类中重写此方法来处理“返回”按钮单击事件
 即将执行pop操作时的回调函数
 */
- (BOOL)navigationShouldPopOnBackButtonWithGesture:(BOOL)gesture;

/**
 pop完成后回调函数
 */
- (void)navigationDidPop;

@end

@interface UIViewController (LENaviBackButtonHandler)<BackButtonHandlerProtocol>

/**
 viewDidDisappear: 的block调用
 */
@property(nonatomic, copy) LEViewDidDisappearBlock viewDidDisappearBlock;

@end
