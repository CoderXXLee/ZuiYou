//
//  ZYFeaturedSC.m
//  ZuiYou
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFeaturedSC.h"
#import "ZYFeaturedM.h"
#import "UICollectionViewCell+ZYExtension.h"
#import "ZYFeaturedCellM.h"
#import <NSString+Extension.h>
#import "ZYImagesM.h"
#import <LECommon.h>
#import "ZYFTitleCell.h"

@interface ZYFeaturedSC () <IGListSupplementaryViewSource>

@property(nonatomic, strong) ZYFeaturedM *featuredM;
///数据
@property(nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ZYFeaturedSC

#pragma mark - LazyLoad

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - Super

- (instancetype)init {
    self.supplementaryViewSource = self;
    return [super init];
}

- (NSInteger)numberOfItems {
    return self.dataSource.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    const CGFloat width = self.collectionContext.containerSize.width;
    ZYFeaturedCellM *cellM = self.dataSource[index];
    return CGSizeMake(width, cellM.cellHeight);
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    ZYFeaturedCellM *cellM = self.dataSource[index];
    UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellWithNibName:cellM.cellName bundle:nil forSectionController:self atIndex:index];
    [cell viewWithModel:cellM.dataSource];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

/**
 ZYFeaturedVC中传递过来的数据
 */
- (void)didUpdateToObject:(id)object {
    self.featuredM = object;
    [self initCellData:object];
}

/**
 点击事件
 */
- (void)didSelectItemAtIndex:(NSInteger)index {
    ///更新标题cell高度
    [self updateTitleCellSize:index];
}

#pragma mark - Init

/**
 初始化数据
 */
- (void)initCellData:(ZYFeaturedM *)featuredM {
    self.dataSource = nil;

    ///头像区
    ZYFeaturedCellM *avatarCellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYAvatarCell" cellHeight:60 dataSource:featuredM.member];
    [self.dataSource addObject:avatarCellM];

    ///标题cell
    if (LEStrNotEmpty(featuredM.content)) {
        const CGFloat width = self.collectionContext.containerSize.width;
        CGFloat singleH = ceil([featuredM.content sizeWithFont:ZYFTitleFont].height);
        ///两行高度
        CGFloat multiH = ceil([featuredM.content sizeWithFont:ZYFTitleFont constrainedToSize:CGSizeMake(width-16*2, singleH*2)].height);
        ZYFeaturedCellM *avatarCellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYFTitleCell" cellHeight:multiH dataSource:featuredM.content];
        [self.dataSource addObject:avatarCellM];
    }

    ///图片区
    if (featuredM.imgs.count > 0) {
        ZYFeaturedCellM *avatarCellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYFImageCell" cellHeight:100 dataSource:featuredM.member];
        [self.dataSource addObject:avatarCellM];
    }
}

#pragma mark - PublicMethod
#pragma mark - PrivateMethod

/**
 更新标题cell高度
 */
- (void)updateTitleCellSize:(NSUInteger)index {
    ZYFeaturedCellM *cellM = self.dataSource[index];
    if ([cellM.cellName isEqualToString:@"ZYFTitleCell"]) {
        NSString *title = cellM.dataSource;
        if (!LEStrNotEmpty(title)) {
            return;
        }

        const CGFloat width = self.collectionContext.containerSize.width;
        ///单行高度
        CGFloat singleH = ceil([title sizeWithFont:ZYFTitleFont].height);
        ///两行高度
        CGFloat multiH = ceil([title sizeWithFont:ZYFTitleFont constrainedToSize:CGSizeMake(width-16*2, singleH*2)].height);
        ///多行高度
        CGFloat maxH = ceil([title sizeWithFont:ZYFTitleFont constrainedToSize:CGSizeMake(width-16*2, MAXFLOAT)].height);
        if (multiH < maxH) {
            cellM.cellHeight = (cellM.cellHeight==multiH)?maxH:multiH;
            LEMoveAnimation(^{
                [self.collectionContext invalidateLayoutForSectionController:self completion:nil];
            }, nil)
        }
    }
}

#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate

- (NSArray<NSString *> *)supportedElementKinds {
    return @[UICollectionElementKindSectionFooter];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    UICollectionReusableView *footer = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self class:[UICollectionViewCell class] atIndex:index];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
    const CGFloat width = self.collectionContext.containerSize.width;
    return CGSizeMake(width, 10);
}

#pragma mark - StateMachine

@end
