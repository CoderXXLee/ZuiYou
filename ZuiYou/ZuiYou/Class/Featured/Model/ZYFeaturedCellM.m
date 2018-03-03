//
//  ZYFeaturedCellM.m
//  ZuiYou
//
//  Created by mac on 2018/3/3.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFeaturedCellM.h"

@implementation ZYFeaturedCellM

/**
 初始化
 */
- (instancetype)initWithCellName:(NSString *)cellName cellHeight:(CGFloat)cellHeight dataSource:(id)dataSource {
    if (self == [super init]) {
        _cellName = cellName;
        _cellHeight = cellHeight;
        _dataSource = dataSource;
    }
    return self;
}

@end
