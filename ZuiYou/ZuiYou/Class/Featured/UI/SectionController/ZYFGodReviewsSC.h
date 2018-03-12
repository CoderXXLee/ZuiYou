//
//  ZYFGodReviewsSC.h
//  ZuiYou
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 le. All rights reserved.
//

#import <IGListKit/IGListKit.h>
@class ZYGodReviewsM;

@protocol ZYFGodReviewsDelegate

- (void)listAdapter:(IGListAdapter *)listAdapter willDisplaySectionController:(IGListSectionController *)displaySectionController didEndDisplayingSectionController:(IGListSectionController *)endDisplayingSectionController;

@end

@interface ZYFGodReviewsSC : IGListSectionController

///是否处于展示状态
@property(nonatomic, assign) BOOL isVisible;

/**
 cell显示回调
 */
@property(nonatomic, copy) void(^bZYFGodReviewsCellDidDisplay)(ZYGodReviewsM *model);

@end
