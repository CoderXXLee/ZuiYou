//
//  BMStaticCellM.h
//  ebm_driver
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 ebm. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@class LEStaticCellM;

typedef void(^ClickActionBlock)(LEStaticCellM *model);

@interface LEStaticCellM : NSObject

/**
 唯一标识符,随机生成，不可自定义是怕ID重复
 */
@property(nonatomic, copy, readonly) NSString *identifier;

/**
 cell
 */
@property(nonatomic, strong, readonly) __kindof UITableViewCell *cell;

/**
 cell高度
 默认0
 */
@property(nonatomic, assign) CGFloat cellHeight;

/**
 是否隐藏
 隐藏后cell高度变为0
 */
@property(nonatomic, assign, getter=isHidden) BOOL hidden;

//@property (nonatomic, assign) CGFloat separateHeight;  ///分割线高度
//@property (nonatomic, strong) UIColor *separateColor;  ///分割线颜色
//@property (nonatomic, assign) CGFloat separateOffset;  ///分割线左边间距(默认为0)

/**
 cell点击事件
 */
@property(nonatomic, copy) ClickActionBlock actionBlock;

/**
 创建一个BMStaticCellM
 */
+ (instancetype)createWithTableView:(UITableView *)tableView xibCellClass:(Class)class;

/**
 创建一个BMStaticCellM
 针对非xib的cell
 */
+ (instancetype)createWithTableView:(UITableView *)tableView cellClass:(Class)class;

@end
