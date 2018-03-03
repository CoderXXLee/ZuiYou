//
//  BMStaticCellM.m
//  ebm_driver
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 ebm. All rights reserved.
//

#import "LEStaticCellM.h"
#import <UITableViewCell+Category.h>
#import <LEUUID.h>

@interface LEStaticCellM () {
    CGFloat __cellHeight;
}

@end

@implementation LEStaticCellM

#pragma mark - LazyLoad

- (void)setCellHeight:(CGFloat)cellHeight {
    _cellHeight = cellHeight;
    __cellHeight = cellHeight;
}

- (void)setHidden:(BOOL)hidden {
    _hidden = hidden;
    _cellHeight = hidden?0:__cellHeight;
}

#pragma mark - Super
#pragma mark - Init
#pragma mark - PublicMethod

/**
 创建一个LEStaticCellM
 */
+ (instancetype)createWithTableView:(UITableView *)tableView xibCellClass:(Class)class {
    LEStaticCellM *model = [[[self class] alloc] init];
    NSString *identifier = [LEUUID UUID];
    model->_identifier = identifier;
    UITableViewCell *cell = [class createCellWithTableView:tableView identifier:identifier];
    model->_cell = cell;
    return model;
}

/**
 创建一个LEStaticCellM
 针对非xib的cell
 */
+ (instancetype)createWithTableView:(UITableView *)tableView cellClass:(Class)class {
    LEStaticCellM *model = [[[self class] alloc] init];
    NSString *identifier = [LEUUID UUID];
    model->_identifier = identifier;
    UITableViewCell *cell = [class createClassCellWithTableView:tableView identifier:identifier];
    model->_cell = cell;
    return model;
}

#pragma mark - PrivateMethod
#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end
