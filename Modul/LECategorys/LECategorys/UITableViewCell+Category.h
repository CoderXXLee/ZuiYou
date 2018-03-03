//
//  UITableViewCell+Category.h
//  CreditAddressBook
//
//  Created by Lee on 15/10/8.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Category)

/**
 自定义cell的 注册，创建 一体化
 针对xib cell
 */
+ (instancetype)createCellWithTableView:(UITableView *)tableView;

/**
 通过identifier创建cell
 */
+ (instancetype)createCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

/**
 通过类名为identifier创建cell
 针对非xib cell
 */
+ (instancetype)createClassCellWithTableView:(UITableView *)tableView;

/**
 通过identifier创建cell
 针对非xib cell
 */
+ (instancetype)createClassCellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

@end
