//
//  ZYFeaturedVC.m
//  ZuiYou
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFeaturedVC.h"
#import "LEDIYHeader.h"
#import "ZYFeaturedTitleView.h"
#import <UIView+Extension.h>
#import <ReactiveObjC.h>
#import <IGListKit.h>
#import "ZYFeaturedM.h"
#import <NSBundle+Extension.h>
#import <MJExtension.h>
#import "ZYFeaturedSC.h"
#import <LECommon.h>
#import "ZYFeaturedService.h"

@interface ZYFeaturedVC () <IGListAdapterDataSource>

@property(nonatomic, weak) UICollectionView *collectionView;
@property(nonatomic, strong) IGListAdapter *adapter;
///数据源
@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation ZYFeaturedVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self buildCollectionView];
    [self setupRefresh];
    [self setupTitleView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.collectionView.frame = self.view.bounds;
}

#pragma mark - LazyLoad
#pragma mark - Super
#pragma mark - Init

/**
 下拉刷新
 */
- (void)setupRefresh {
    LEWeakifySelf
    LEDIYHeader *header = [LEDIYHeader headerWithRefreshingBlock:^{
        LEStrongifySelf
        [self loadData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;

    self.collectionView.mj_header = header;
    [header beginRefreshing];
}


/**
 创建tableview
 */
- (void)buildCollectionView {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];

    IGListAdapter *adapter = [[IGListAdapter alloc] initWithUpdater:[[IGListAdapterUpdater alloc] init] viewController:self];
    self.adapter = adapter;
    adapter.collectionView = collectionView;
    adapter.dataSource = self;

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

/**
 titleView
 */
- (void)setupTitleView {
    ZYFeaturedTitleView *titleView = [ZYFeaturedTitleView loadFromNibUsingClassName];
    self.navigationItem.titleView = titleView;
}

#pragma mark - PublicMethod
#pragma mark - PrivateMethod
#pragma mark - Events
#pragma mark - LoadFromService

/**
 加载数据
 */
- (void)loadData {
    NSDictionary *dict = [NSBundle loadJsonFromBundle:@"recommend"];
    NSDictionary *dataDict = dict[@"data"];
    NSArray *dataSource = [ZYFeaturedM mj_objectArrayWithKeyValuesArray:dataDict[@"list"]];
    self.dataSource = dataSource;
    [self.collectionView.mj_header endRefreshing];
    [self.adapter reloadDataWithCompletion:nil];
}

#pragma mark - Delegate

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
    return self.dataSource;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
    IGListStackedSectionController *stackSC = [[IGListStackedSectionController alloc] initWithSectionControllers:@[[[ZYFeaturedSC alloc] init]]];
    return stackSC;
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
    return nil;
}

#pragma mark - StateMachine

@end
