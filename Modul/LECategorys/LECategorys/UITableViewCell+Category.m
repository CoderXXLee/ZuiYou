//
//  UITableViewCell+Category.m
//  CreditAddressBook
//
//  Created by Lee on 15/10/8.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "UITableViewCell+Category.h"

@implementation UITableViewCell (Category)

/**
 通过类名为identifier创建cell
 */
+ (instancetype)createCellWithTableView:(UITableView *)tableView {
    NSString *cellName = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    Class className = NSClassFromString(cellName);
    if (className) {
//        id cell = [tableView dequeueReusableCellWithIdentifier:ID];
        id cell = [self registerCellWithTableView:tableView cellClass:className];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        }
        return cell;
    }
    return nil;
}

/*!
 *  @brief  以cellClass为identifier注册cell
 *  @param cellClass
 *  @return
 */
+ (UITableViewCell *)registerCellWithTableView:(UITableView *)tableView cellClass:(Class)cellClass {
    UITableViewCell *modelCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    if (!modelCell.contentView.subviews.count) {
        modelCell = nil;
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
        if (nib) {
            [tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass(cellClass)];
        } else {
            [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        }
        modelCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    }
    return modelCell;
}

/**
 通过identifier创建cell
 */
+ (instancetype)createCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    NSString *cellName = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    Class className = NSClassFromString(cellName);
    if (className) {
        id cell = [self registerCellWithTableView:tableView cellClass:className identifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:nil options:nil] lastObject];
        }
        return cell;
    }
    return nil;
}

/**
 注册cell

 @param tableView tableview
 @param cellClass 类名
 @param identifier 注册用的ID
 */
+ (UITableViewCell *)registerCellWithTableView:(UITableView *)tableView cellClass:(Class)cellClass identifier:(NSString *)identifier {
    UITableViewCell *modelCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!modelCell.contentView.subviews.count) {
        modelCell = nil;
        UINib *nib = [UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil];
        if (nib) {
            [tableView registerNib:nib forCellReuseIdentifier:identifier];
        } else {
            [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
        }
        modelCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    return modelCell;
}

/**
 通过类名为identifier创建cell
 针对非xib cell
 */
+ (instancetype)createClassCellWithTableView:(UITableView *)tableView {
    NSString *cellName = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    Class className = NSClassFromString(cellName);
    if (className) {
        id cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            [tableView registerClass:className forCellReuseIdentifier:NSStringFromClass(className)];
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(className)];
        }
        return cell;
    }
    return nil;
}

/**
 通过identifier创建cell
 针对非xib cell
 */
+ (instancetype)createClassCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier {
    NSString *cellName = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    Class className = NSClassFromString(cellName);
    if (className) {
        id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            [tableView registerClass:className forCellReuseIdentifier:identifier];
            cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        }
        return cell;
    }
    return nil;
}

@end
