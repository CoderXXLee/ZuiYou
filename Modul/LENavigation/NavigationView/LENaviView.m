//
//  BMNaviView.m
//  ebm
//
//  Created by mac on 2017/4/25.
//  Copyright © 2017年 BM. All rights reserved.
//

#import "LENaviView.h"

@interface LENaviBaseView (UIPrivate)

- (void)_removeFromParentView;

@end

@implementation LENaviView {
    LENaviBaseView *_visibleView;
    BOOL _needsDeferredUpdate;
    BOOL _isUpdating;
}

#pragma mark - LazyLoad
#pragma mark - Super

- (void)dealloc {
    //    _navigationBar.delegate = nil;
}

#pragma mark - Init
#pragma mark - PublicMethod

/**
 初始化
 */
- (id)initWithFrame:(CGRect)frame rootView:(LENaviBaseView *)rootView parentController:(UIViewController *)parentController {
    if ((self = [super initWithFrame:frame])) {
        [self.childViews addObject:rootView];
        [self viewWillLayoutSubviews];
        _visibleView = rootView;
        self.parentViewController = parentController;
        [self loadView];
    }
    return self;
}

- (void)pushView:(LENaviBaseView *)view animated:(BOOL)animated {
    assert(view);
    assert([view isKindOfClass:[LENaviBaseView class]]);
    assert(![self.childViews containsObject:view]);
    assert(view.parentView == nil || view.parentView == self);

    if (view.parentView != self) {
        [self addSubview:view];
        view.parentView = self;
        [self.childViews addObject:view];
    }

    [view viewWillAppear:animated];

    if (animated) {
        [self _updateVisibleView:animated];
    } else {
        [self _setNeedsDeferredUpdate];
    }
}

- (LENaviBaseView *)popViewAnimated:(BOOL)animated {
    if ([self.childViews count] <= 1) {
        return nil;
    }

    LENaviBaseView *formerTopView = self.topView;
    if (formerTopView == _visibleView) {
        //        [formerTopView willMoveToParentView:nil];
    }
    [formerTopView _removeFromParentView];

    [formerTopView viewWillDisappear:animated];

    if (animated) {
        [self _updateVisibleView:animated];
    } else {
        [self _setNeedsDeferredUpdate];
    }

    return formerTopView;
}

- (NSArray *)popToView:(LENaviBaseView *)view animated:(BOOL)animated {
    NSMutableArray *popped = [[NSMutableArray alloc] init];

    if ([self.childViews containsObject:view]) {
        while (self.topView != view) {
            LENaviBaseView *poppedView = [self popViewAnimated:animated];
            if (poppedView) {
                [popped addObject:poppedView];
            } else {
                break;
            }
        }
    }

    return popped;
}

- (NSArray *)popToRootViewAnimated:(BOOL)animated {
    return [self popToView:[self.childViews objectAtIndex:0] animated:animated];
}

- (LENaviBaseView *)topView {
    return self.childViews.lastObject;
}

#pragma mark - PrivateMethod

/**
 首次加载view
 */
- (void)loadView {
    self.clipsToBounds = YES;

    CGRect navbarRect;
    CGRect contentRect;
    CGRect toolbarRect;
    [self _getNavbarRect:&navbarRect contentRect:&contentRect toolbarRect:&toolbarRect forBounds:self.bounds];

    _visibleView.frame = contentRect;
    _visibleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self addSubview:_visibleView];
    _visibleView.parentView = self;
}

- (void)setViews:(NSArray *)newViews animated:(BOOL)animated {
    assert([newViews count] >= 1);

    if (![newViews isEqualToArray:self.childViews]) {
        NSMutableArray *removeViews = [self.childViews mutableCopy];
        [removeViews removeObjectsInArray:newViews];

        for (LENaviBaseView *view in removeViews) {
            //            [ willMoveToParentView:nil];
            [view removeFromSuperview];
        }
        for (LENaviBaseView *view in newViews) {
            [self pushView:view animated:(animated && (view == [newViews lastObject]))];
        }
    }
}

- (void)setViews:(NSArray *)newViews {
    [self setViews:newViews animated:NO];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)_setNeedsDeferredUpdate {
    _needsDeferredUpdate = YES;
    [self setNeedsLayout];
}

- (void)_getNavbarRect:(CGRect *)navbarRect contentRect:(CGRect *)contentRect toolbarRect:(CGRect *)toolbarRect forBounds:(CGRect)bounds {
    CGRect content = bounds;
    if (contentRect) *contentRect = content;
}

- (void)_updateVisibleView:(BOOL)animated {
    _isUpdating = YES;

    LENaviBaseView *newVisibleView = self.topView;
    LENaviBaseView *oldVisibleView = _visibleView;

    const BOOL isPushing = (oldVisibleView.parentView != nil);

    _visibleView = newVisibleView;

    const CGRect bounds = self.bounds;

    CGRect navbarRect;
    CGRect contentRect;
    CGRect toolbarRect;
    [self _getNavbarRect:&navbarRect contentRect:&contentRect toolbarRect:&toolbarRect forBounds:bounds];

    newVisibleView.transform = CGAffineTransformIdentity;
    newVisibleView.frame = contentRect;

    const CGAffineTransform inStartTransform = isPushing? CGAffineTransformMakeTranslation(bounds.size.width, 0) : CGAffineTransformMakeTranslation(-bounds.size.width, 0);
    const CGAffineTransform outEndTransform = isPushing? CGAffineTransformMakeTranslation(-bounds.size.width/3, 0) : CGAffineTransformMakeTranslation(bounds.size.width/3, 0);

    newVisibleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self insertSubview:newVisibleView aboveSubview:oldVisibleView];
    newVisibleView.transform = inStartTransform;

    [UIView animateWithDuration:animated? 0.5 : 0 delay:0 usingSpringWithDamping:.98 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        oldVisibleView.transform = outEndTransform;
        newVisibleView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (oldVisibleView && isPushing) {
            [oldVisibleView viewDidDisappear:animated];
            [newVisibleView viewDidAppear:animated];
        } else {
            [newVisibleView viewDidAppear:animated];
        }
        [oldVisibleView removeFromSuperview];
    }];
//    [LENaviBaseView animateWithDuration:animated? 0.33 : 0 animations:^{
//        oldVisibleView.transform = outEndTransform;
//        newVisibleView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        if (oldVisibleView && isPushing) {
//            [oldVisibleView viewDidDisappear:animated];
//            [newVisibleView viewDidAppear:animated];
//        } else {
//            [newVisibleView viewDidAppear:animated];
//        }
//        [oldVisibleView removeFromSuperview];
//    }];

    _isUpdating = NO;
}

- (void)viewWillLayoutSubviews {
    if (_needsDeferredUpdate) {
        _needsDeferredUpdate = NO;
        [self _updateVisibleView:NO];
    }
}

#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end
