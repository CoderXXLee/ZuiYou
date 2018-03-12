//
//  ZYFTopicCell.m
//  ZuiYou
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFTopicCell.h"

@implementation ZYFTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.tagL.layer.cornerRadius = 22/2.f;
    self.tagL.clipsToBounds = YES;
    self.collectionView.pagingEnabled = YES;
}

/**
 数据展示
 */
- (void)viewWithModel:(NSString *)model {
    self.tagL.text = [NSString stringWithFormat:@"    %@    ", model];
}

@end
