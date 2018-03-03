//
//  ZYAvatarCell.m
//  ZuiYou
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYAvatarCell.h"
#import "UICollectionViewCell+ZYExtension.h"

@implementation ZYAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.avatarIV.layer.cornerRadius = 35/2.f;
    self.avatarIV.clipsToBounds = YES;
}

/**
 数据展示
 */
- (void)viewWithModel:(id)model {

}

@end
