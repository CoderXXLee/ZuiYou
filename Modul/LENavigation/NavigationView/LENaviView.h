//
//  BMNaviView.h
//  ebm
//
//  Created by mac on 2017/4/25.
//  Copyright © 2017年 BM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LENaviBaseView.h"

@interface LENaviView : LENaviBaseView

@property (nonatomic, readonly, strong) LENaviBaseView *topView;

- (id)initWithFrame:(CGRect)frame rootView:(LENaviBaseView *)rootView parentController:(UIViewController *)parentController;
- (void)pushView:(LENaviBaseView *)view animated:(BOOL)animated;
- (LENaviBaseView *)popViewAnimated:(BOOL)animated;
- (NSArray *)popToView:(UIView *)view animated:(BOOL)animated;
- (NSArray *)popToRootViewAnimated:(BOOL)animated;

@end
