//
//  ZYFTitleCell.m
//  ZuiYou
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFTitleCell.h"
#import "UICollectionViewCell+ZYExtension.h"

@implementation ZYFTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 数据展示
 */
- (void)viewWithModel:(NSString *)model {
    self.titleL.text = model;
}

@end
