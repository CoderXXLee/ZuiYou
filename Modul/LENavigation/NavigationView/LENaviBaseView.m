//
//  BMBaseView.m
//  ebm
//
//  Created by mac on 2017/4/25.
//  Copyright © 2017年 BM. All rights reserved.
//

#import "LENaviBaseView.h"
#import "LENaviView.h"

@interface LENaviBaseView ()

@end

@implementation LENaviBaseView

- (NSMutableArray *)childViews {
    if (!_childViews) {
        _childViews = [NSMutableArray array];
    }
    return _childViews;
}

- (void)_removeFromParentView {
    if (_parentView) {
        [_parentView->_childViews removeObject:self];

        if ([_parentView->_childViews count] == 0) {
            _parentView->_childViews = nil;
        }
        _parentView = nil;
    }
}

- (id)_nearestParentViewThatIsKindOf:(Class)c {
    LENaviBaseView *view = _parentView;

    while (view && ![view isKindOfClass:c]) {
        view = [view parentView];
    }

    return view;
}

- (LENaviView *)navigationView {
    return [self _nearestParentViewThatIsKindOf:[LENaviView class]];
}

/**
 子类重写
 */
- (void)viewWillAppear:(BOOL)animated {}
- (void)viewDidAppear:(BOOL)animated {}
- (void)viewWillDisappear:(BOOL)animated {}
- (void)viewDidDisappear:(BOOL)animated {}

@end
