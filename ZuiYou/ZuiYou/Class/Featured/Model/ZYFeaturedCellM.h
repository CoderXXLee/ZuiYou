//
//  ZYFeaturedCellM.h
//  ZuiYou
//
//  Created by mac on 2018/3/3.
//  Copyright © 2018年 le. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ZYFeaturedCellM : NSObject

/**
 cell名称
 */
@property(nonatomic, strong, readonly) NSString *cellName;

/**
 高度
 */
@property(nonatomic, assign) CGFloat cellHeight;

/**
 数据源
 */
@property(nonatomic, strong) id dataSource;

/**
 初始化
 */
- (instancetype)initWithCellName:(NSString *)cellName cellHeight:(CGFloat)cellHeight dataSource:(id)dataSource;

@end
