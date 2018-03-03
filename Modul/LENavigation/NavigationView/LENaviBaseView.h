//
//  BMBaseView.h
//  ebm
//
//  Created by mac on 2017/4/25.
//  Copyright © 2017年 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LENaviView;

@interface LENaviBaseView : UIView

/**
 父view，只读
 */
@property(nonatomic,weak) LENaviBaseView *parentView;
@property (nonatomic, weak) UIViewController *parentViewController;
@property (nonatomic, readonly, strong) LENaviView *navigationView;

/**
 子view数组
 */
@property(nonatomic, strong) NSMutableArray *childViews;

- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;

@end
