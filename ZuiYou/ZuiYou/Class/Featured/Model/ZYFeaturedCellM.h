//
//  ZYFeaturedCellM.h
//  ZuiYou
//
//  Created by mac on 2018/3/3.
//  Copyright © 2018年 le. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class IGListSectionController;

@interface ZYFeaturedCellM : NSObject

/**
 cell名称
 */
@property(nonatomic, strong, readonly) NSString *cellName;

/**
 cell size
 */
@property(nonatomic, assign) CGSize cellSize;
@property(nonatomic, assign) CGFloat cellHeight;
@property(nonatomic, assign) CGFloat cellWidth;

/**
 数据源
 */
@property(nonatomic, strong) id dataSource;

/**
 IGListSectionController
 */
@property(nonatomic, strong) IGListSectionController *sectionController;

/**
 初始化
 */
- (instancetype)initWithCellName:(NSString *)cellName cellSize:(CGSize)cellSize dataSource:(id)dataSource;

@end
