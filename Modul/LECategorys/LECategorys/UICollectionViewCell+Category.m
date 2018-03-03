//
//  UICollectionViewCell+Category.m
//  E
//
//  Created by lwp on 2016/11/1.
//  Copyright © 2016年 com.haotu. All rights reserved.
//

#import "UICollectionViewCell+Category.h"

@implementation UICollectionViewCell (Category)

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    NSString *nibName = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    NSString *ID = nibName;
    return [self collectionView:collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
}

+ (void)registerXibCellWithCollectionView:(UICollectionView *)collectionView {
    NSString *nibName = [[NSStringFromClass(self) componentsSeparatedByString:@"."] lastObject];
    NSString *ID = nibName;
    [self collectionView:collectionView registerCellWithReuseIdentifier:ID];
}

/**
 *  注册cell
 *
 *  @param collectionview
 *  @param identifier
 */
+ (void)collectionView:(UICollectionView *)collectionview registerCellWithReuseIdentifier:(NSString *)identifier {
    NSAssert(identifier, @"UICollectionViewCell(Category)：注册cell的identifier不能为空");
    [collectionview registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellWithReuseIdentifier:identifier];
}

/**
 *  创建cell
 *
 *  @param collectionview
 *  @param identifier
 *  @param indexPath
 *
 *  @return
 */
+ (instancetype)collectionView:(UICollectionView *)collectionview dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    NSAssert(identifier, @"UICollectionViewCell(Category)：获取cell的identifier不能为空");
    id cell = [collectionview dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

@end
