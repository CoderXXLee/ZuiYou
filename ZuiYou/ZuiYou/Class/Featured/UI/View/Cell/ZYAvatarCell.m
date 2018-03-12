//
//  ZYAvatarCell.m
//  ZuiYou
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYAvatarCell.h"
#import "UICollectionViewCell+ZYExtension.h"
#import <UIImageView+WebCache.h>
#import "ZYMemberM.h"

@interface ZYAvatarCell ()

/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *avatarIV;

/**
 用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@end

@implementation ZYAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.avatarIV.layer.cornerRadius = 35/2.f;
    self.avatarIV.clipsToBounds = YES;
}

/**
 数据展示
 */
- (void)viewWithModel:(ZYMemberM *)model {
    [self.avatarIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://file.izuiyou.com/account/avatar/id/%@/sz/228", model.avatar]] placeholderImage:[UIImage imageNamed:@"signup_default_avatar"]];
    self.nameL.text = model.name;
}

@end
