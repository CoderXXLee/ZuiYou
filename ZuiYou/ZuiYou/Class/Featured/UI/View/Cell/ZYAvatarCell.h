//
//  ZYAvatarCell.h
//  ZuiYou
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYAvatarCell : UICollectionViewCell

/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;

/**
 用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameL;

/**
 关闭按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end
