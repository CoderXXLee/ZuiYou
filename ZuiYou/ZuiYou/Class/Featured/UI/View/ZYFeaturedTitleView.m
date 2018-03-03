//
//  ZYFeaturedTitleView.m
//  ZuiYou
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFeaturedTitleView.h"

@interface ZYFeaturedTitleView ()

@property (weak, nonatomic) IBOutlet UIView *searchView;

@end

@implementation ZYFeaturedTitleView

#pragma mark - LazyLoad
#pragma mark - Super

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.searchView.layer.cornerRadius = 5.0;
}

- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}

#pragma mark - Init
#pragma mark - PublicMethod
#pragma mark - PrivateMethod
#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end
