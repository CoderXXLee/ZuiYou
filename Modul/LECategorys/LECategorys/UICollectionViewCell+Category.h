//
//  UICollectionViewCell+Category.h
//  E
//
//  Created by lwp on 2016/11/1.
//  Copyright © 2016年 com.haotu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (Category)

/**
 注册cell
 */
+ (void)registerXibCellWithCollectionView:(UICollectionView *)collectionView;

/**
 加载cell
 */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
@end
