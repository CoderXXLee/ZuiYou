//
//  ZYFTopicCell.h
//  ZuiYou
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYFTopicCell : UICollectionViewCell

/**
 标签
 */
@property (weak, nonatomic) IBOutlet UILabel *tagL;

/**
 UICollectionView
 */
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**
 UIPageControl
 */
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
