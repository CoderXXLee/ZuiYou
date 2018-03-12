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
#import "ZYImageSC.h"
#import "ZYFImageCell.h"
#import "NSArray+IGListDiffable.h"
#import "ZYFTopicCell.h"
#import "ZYGodReviewsM.h"
#import "ZYFGodReviewsSC.h"
#import "IGListDisplayDelegateM.h"

@interface ZYFeaturedSC () <IGListAdapterDataSource, UIScrollViewDelegate>

@property(nonatomic, strong) ZYFeaturedM *featuredM;
///数据
@property(nonatomic, strong) NSMutableArray *dataSource;

@property(nonatomic, strong) IGListAdapter *adapter;
///神评adapter
@property(nonatomic, strong) IGListAdapter *godReviewsAdapter;
///展示中的godReviews的IGListSectionController
@property(nonatomic, strong) IGListSectionController *visibleSectionController;

@property(nonatomic, strong) IGListDisplayDelegateM *delegateM;

@end

@implementation ZYFeaturedSC

#pragma mark - LazyLoad

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (IGListAdapter *)adapter {
    if (!_adapter) {
        IGListAdapter *adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self.viewController];
//        adapter.collectionView = collectionView;
        adapter.dataSource = self;
        _adapter = adapter;
    }
    return _adapter;
}

- (IGListAdapter *)godReviewsAdapter {
    if (!_godReviewsAdapter) {
        IGListAdapter *adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self.viewController];
        _godReviewsAdapter = adapter;
        adapter.dataSource = self;
        adapter.scrollViewDelegate = self;
    }
    return _godReviewsAdapter;
}

- (IGListDisplayDelegateM *)delegateM {
    if (!_delegateM) {
        _delegateM = [IGListDisplayDelegateM new];
        [self setupIGListDisplayDelegate];
    }
    return _delegateM;
}

#pragma mark - Super

- (NSInteger)numberOfItems {
    return self.dataSource.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    ZYFeaturedCellM *cellM = self.dataSource[index];
    return cellM.cellSize;
}

- (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    ZYFeaturedCellM *cellM = self.dataSource[index];
    UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellWithNibName:cellM.cellName bundle:nil forSectionController:self atIndex:index];
    [cell viewWithModel:cellM.dataSource];
    cell.backgroundColor = [UIColor whiteColor];
    if ([cellM.cellName isEqualToString:@"ZYFImageCell"]) {
        self.adapter.collectionView = ((ZYFImageCell *)cell).collectionView;
    }
    if ([cellM.cellName isEqualToString:@"ZYFTopicCell"]) {
        self.godReviewsAdapter.collectionView = ((ZYFTopicCell *)cell).collectionView;
    }
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
    const CGFloat width = self.collectionContext.containerSize.width;

    ///头像区
    ZYFeaturedCellM *avatarCellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYAvatarCell" cellSize:CGSizeMake(width, 60) dataSource:featuredM.member];
    [self.dataSource addObject:avatarCellM];

    ///标题cell
    if (LEStrNotEmpty(featuredM.content)) {
        const CGFloat width = self.collectionContext.containerSize.width;
        CGFloat singleH = ceil([featuredM.content sizeWithFont:ZYFTitleFont].height);
        ///两行高度
        CGFloat multiH = ceil([featuredM.content sizeWithFont:ZYFTitleFont constrainedToSize:CGSizeMake(width-16*2, singleH*2)].height);
        ZYFeaturedCellM *avatarCellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYFTitleCell" cellSize:CGSizeMake(width, multiH) dataSource:featuredM.content];
        [self.dataSource addObject:avatarCellM];
    }

    ///图片区
    if (featuredM.imgs.count > 0) {
        NSUInteger count = featuredM.imgs.count>3?3:featuredM.imgs.count;
        CGFloat itemSize = floor((width-(count-1)*8-2*16)/count);
        NSUInteger row = ceil(featuredM.imgs.count/3.f);
        ZYFeaturedCellM *avatarCellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYFImageCell" cellSize:CGSizeMake(width, itemSize*row+2*10+(row-1)*8) dataSource:featuredM.member];
        [self.dataSource addObject:avatarCellM];

//        NSUInteger count = featuredM.imgs.count>3?3:featuredM.imgs.count;
//        CGFloat itemSize = floor((width-(count-1)*8)/count);
//        for (NSInteger i=0; i<featuredM.imgs.count; i++) {
//            ZYFeaturedCellM *avatarCellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYFImageCell" cellSize:CGSizeMake(itemSize, itemSize) dataSource:featuredM.member];
//            avatarCellM.sectionController = [[ZYImageSC alloc] init];
//            [self.dataSource addObject:avatarCellM];
//        }
    }

    ///投票区
    ///标签,神评区
    if (featuredM.topic && featuredM.topic[@"topic"]) {
        ZYFeaturedCellM *cellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYFTopicCell" cellSize:CGSizeMake(width, 100) dataSource:featuredM.topic[@"topic"]];
        [self.dataSource addObject:cellM];
    }
    ///转发点赞区
    if (featuredM) {
        ZYFeaturedCellM *cellM = [[ZYFeaturedCellM alloc] initWithCellName:@"ZYFInfoCell" cellSize:CGSizeMake(width, 50) dataSource:featuredM];
        [self.dataSource addObject:cellM];
    }
}

#pragma mark - PublicMethod
#pragma mark - PrivateMethod

/**
 IGListDisplayDelegate
 */
- (void)setupIGListDisplayDelegate {
    LEWeakifySelf
    IGListDisplayDelegateM *delegateM = self.delegateM;
    delegateM.bIGListCellWillDisplay = ^(IGListAdapter *listAdapter, IGListSectionController *sectionController, UICollectionViewCell *cell, NSUInteger index) {
        if ([sectionController isKindOfClass:[ZYFGodReviewsSC class]]) {
            ((ZYFGodReviewsSC *)sectionController).isVisible = YES;
        }
        self.visibleSectionController = sectionController;
    };
    delegateM.bIGListCellDidDisplay = ^(IGListAdapter *listAdapter, IGListSectionController *sectionController, UICollectionViewCell *cell, NSUInteger index) {
        LEStrongifySelf
        if ([sectionController isKindOfClass:[ZYFGodReviewsSC class]]) {
            ((ZYFGodReviewsSC *)sectionController).isVisible = NO;
        }
        self.visibleSectionController = sectionController;
        [self updateTopicCellHeightWithGodReviewsSection:sectionController.section];
//        cell.hidden = NO;
    };
    delegateM.bIGListCellDidEndDisplaying = ^(IGListAdapter *listAdapter, IGListSectionController *sectionController, UICollectionViewCell *cell, NSUInteger index) {
//        cell.hidden = YES;
    };
}

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

/**
 更新神评cell高度
 */
- (void)updateTopicCellHeightWithGodReviewsSection:(NSUInteger)section {
    ZYFeaturedCellM *cellM = self.dataSource[[[self.dataSource valueForKeyPath:@"cellName"] indexOfObject:@"ZYFTopicCell"]];
    cellM.cellHeight = section==0?100:200;
//    LEMoveAnimation(^{
//        [self.collectionContext invalidateLayoutForSectionController:self completion:^(BOOL finished) {
//            if (finished) {
//                [self.visibleSectionController.collectionContext invalidateLayoutForSectionController:self.visibleSectionController completion:nil];
//            }
//        }];
//    }, nil)

    [self.collectionContext performBatchAnimated:NO updates:^(id<IGListBatchContext>  _Nonnull batchContext) {

    } completion:^(BOOL finished) {
        [self.visibleSectionController.collectionContext performBatchAnimated:NO updates:^(id<IGListBatchContext>  _Nonnull batchContext) {

        } completion:^(BOOL finished) {

        }];
    }];
}

#pragma mark - Events
#pragma mark - LoadFromService

#pragma mark - Delegate

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    if (listAdapter == self.godReviewsAdapter) {
        return self.featuredM.god_reviews;
    }
    return @[self.featuredM.imgs];
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    if ([object isKindOfClass:[ZYGodReviewsM class]]) {
        ZYFGodReviewsSC *godReviewsSC = [[ZYFGodReviewsSC alloc] init];
        godReviewsSC.displayDelegate = self.delegateM;
        return godReviewsSC;
    }
    ZYImageSC *stackSC = [[ZYImageSC alloc] init];
//    stackSC.displayDelegate = self;
    return stackSC;
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

///UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSArray *arr = self.godReviewsAdapter.visibleObjects;
    NSArray *cells = [self.godReviewsAdapter visibleCellsForObject:arr.firstObject];
    if (cells.count > 0) {
        [cells setValue:@NO forKeyPath:@"hidden"];
    }
}

//- (NSArray<NSString *> *)supportedElementKinds {
//    return @[UICollectionElementKindSectionFooter];
//}
//
//- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
//    UICollectionReusableView *footer = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self class:[UICollectionViewCell class] atIndex:index];
//    footer.backgroundColor = [UIColor clearColor];
//    return footer;
//}
//
//- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
//    const CGFloat width = self.collectionContext.containerSize.width;
//    return CGSizeMake(width, 10);
//}

#pragma mark - StateMachine

@end
