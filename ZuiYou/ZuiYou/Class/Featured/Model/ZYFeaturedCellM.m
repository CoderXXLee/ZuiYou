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
- (instancetype)initWithCellName:(NSString *)cellName cellSize:(CGSize)cellSize dataSource:(id)dataSource {
    if (self == [super init]) {
        _cellName = cellName;
        _cellSize = cellSize;
        _dataSource = dataSource;
    }
    return self;
}

- (void)setCellHeight:(CGFloat)cellHeight {
    self.cellSize = CGSizeMake(self.cellSize.width, cellHeight);
}

- (CGFloat)cellHeight {
    return self.cellSize.height;
}

- (void)setCellWidth:(CGFloat)cellWidth {
    self.cellSize = CGSizeMake(cellWidth, self.cellSize.height);
}

- (CGFloat)cellWidth {
    return self.cellSize.width;
}

@end
