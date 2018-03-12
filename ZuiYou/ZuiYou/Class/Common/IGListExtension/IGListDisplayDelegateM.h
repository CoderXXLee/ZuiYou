//
//  IGListDisplayDelegateM.h
//  ZuiYou
//
//  Created by mac on 2018/3/7.
//  Copyright © 2018年 le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListDisplayDelegate.h>
@class IGListAdapter, IGListSectionController, UICollectionViewCell;

@interface IGListDisplayDelegateM : NSObject <IGListDisplayDelegate>

@property(nonatomic, copy) void(^bIGListSectionControllerWillDisplay)(IGListAdapter *listAdapter, IGListSectionController *sectionController);

@property(nonatomic, copy) void(^bIGListSectionControllerDidDisplay)(IGListAdapter *listAdapter, IGListSectionController *sectionController);

@property(nonatomic, copy) void(^bIGListCellWillDisplay)(IGListAdapter *listAdapter, IGListSectionController *sectionController, UICollectionViewCell *cell, NSUInteger index);

@property(nonatomic, copy) void(^bIGListCellDidDisplay)(IGListAdapter *listAdapter, IGListSectionController *sectionController, UICollectionViewCell *cell, NSUInteger index);

@property(nonatomic, copy) void(^bIGListSectionControllerDidEndDisplaying)(IGListAdapter *listAdapter, IGListSectionController *sectionController);

@property(nonatomic, copy) void(^bIGListCellDidEndDisplaying)(IGListAdapter *listAdapter, IGListSectionController *sectionController, UICollectionViewCell *cell, NSUInteger index);

@end
