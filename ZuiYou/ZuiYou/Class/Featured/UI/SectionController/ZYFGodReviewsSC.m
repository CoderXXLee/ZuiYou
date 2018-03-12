//
//  ZYFGodReviewsSC.m
//  ZuiYou
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFGodReviewsSC.h"
#import "ZYFGodReviewsCell.h"
#import "ZYGodReviewsM.h"

@interface ZYFGodReviewsSC ()

@property(nonatomic, strong) ZYGodReviewsM *model;

@end

@implementation ZYFGodReviewsSC

#pragma mark - LazyLoad
#pragma mark - Super

- (NSInteger)numberOfItems {
    NSLog(@"id - sectin: %@ - %ld", self.model.uid, (long)self.section);
    return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    CGFloat cellHeight = self.collectionContext.containerSize.height;
//    if (self.isVisible && self.section == 1) {
//        cellHeight = 200;
//    }
    return CGSizeMake(self.collectionContext.containerSize.width-2*16, cellHeight);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    ZYFGodReviewsCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"ZYFGodReviewsCell" bundle:nil forSectionController:self atIndex:index];
    cell.hidden = YES;
    return cell;
}

- (void)didUpdateToObject:(ZYGodReviewsM *)object {
    self.model = object;
}

#pragma mark - Init

- (instancetype)init {
    if (self = [super init]) {
        self.minimumInteritemSpacing = 32;
        self.inset = UIEdgeInsetsMake(0, 16, 0, 16);
    }
    return self;
}

#pragma mark - PublicMethod
#pragma mark - PrivateMethod
#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate

@end
