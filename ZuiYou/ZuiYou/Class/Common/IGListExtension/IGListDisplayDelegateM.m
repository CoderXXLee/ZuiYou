//
//  IGListDisplayDelegateM.m
//  ZuiYou
//
//  Created by mac on 2018/3/7.
//  Copyright © 2018年 le. All rights reserved.
//

#import "IGListDisplayDelegateM.h"

@interface IGListDisplayDelegateM ()

///展示中的IGListSectionController
@property(nonatomic, strong) IGListSectionController *visibleSectionController;
///展示中的cell
@property(nonatomic, strong) UICollectionViewCell *visibleCell;
@property(nonatomic, assign) NSUInteger visibleIndex;

@end

@implementation IGListDisplayDelegateM

- (void)listAdapter:(nonnull IGListAdapter *)listAdapter didEndDisplayingSectionController:(nonnull IGListSectionController *)sectionController {
    if (self.visibleSectionController && sectionController != self.visibleSectionController) {
        if (self.bIGListSectionControllerDidDisplay) self.bIGListSectionControllerDidDisplay(listAdapter, self.visibleSectionController);
    }
    if (self.bIGListSectionControllerDidEndDisplaying) self.bIGListSectionControllerDidEndDisplaying(listAdapter, sectionController);
}

- (void)listAdapter:(nonnull IGListAdapter *)listAdapter didEndDisplayingSectionController:(nonnull IGListSectionController *)sectionController cell:(nonnull UICollectionViewCell *)cell atIndex:(NSInteger)index {
    if (sectionController != self.visibleSectionController) {
        if (self.bIGListCellDidDisplay) self.bIGListCellDidDisplay(listAdapter, self.visibleSectionController, self.visibleCell, self.visibleIndex);
    }
    if (self.bIGListCellDidEndDisplaying) self.bIGListCellDidEndDisplaying(listAdapter, sectionController, cell, index);
}

- (void)listAdapter:(nonnull IGListAdapter *)listAdapter willDisplaySectionController:(nonnull IGListSectionController *)sectionController {
    self.visibleSectionController = sectionController;
    if (self.bIGListSectionControllerWillDisplay) self.bIGListSectionControllerWillDisplay(listAdapter, sectionController);
}

- (void)listAdapter:(nonnull IGListAdapter *)listAdapter willDisplaySectionController:(nonnull IGListSectionController *)sectionController cell:(nonnull UICollectionViewCell *)cell atIndex:(NSInteger)index {
    if (self.visibleSectionController) {
        if (self.bIGListCellWillDisplay) self.bIGListCellWillDisplay(listAdapter, sectionController, cell, index);
    }
    self.visibleSectionController = sectionController;
    self.visibleCell = cell;
    self.visibleIndex = index;
}

@end
