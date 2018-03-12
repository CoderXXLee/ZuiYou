//
//  ZYFImageCell.m
//  ZuiYou
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFImageCell.h"
#import "UICollectionViewCell+ZYExtension.h"

@interface ZYFImageCell ()

@end

@implementation ZYFImageCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
////    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
////    self.collectionView.collectionViewLayout = layout;
//
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    [self.contentView addSubview:collectionView];
//    self.collectionView = collectionView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.collectionView.frame = self.contentView.bounds;
}

/**
 数据展示
 */
- (void)viewWithModel:(id)model {

}

@end
