//
//  ZYImageSC.m
//  ZuiYou
//
//  Created by mac on 2018/3/5.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYImageSC.h"
#import "ZYFImageCell.h"
#import "ZYImageSectionCell.h"
#import "ZYImagesM.h"
#import <UIImageView+WebCache.h>

@interface ZYImageSC ()

@property(nonatomic, strong) NSArray *dataSource;

@end

@implementation ZYImageSC

#pragma mark - LazyLoad
#pragma mark - Super

- (instancetype)init {
    self = [super init];
    if (self) {
        self.minimumInteritemSpacing = 8;
        self.minimumLineSpacing = 8;
    }
    return self;
}

- (NSInteger)numberOfItems {
    return self.dataSource.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
    CGFloat width = self.collectionContext.containerSize.width;
    NSUInteger count = self.dataSource.count>3?3:self.dataSource.count;
    CGFloat itemSize = floor((width-(count-1)*8)/count);
    return CGSizeMake(itemSize, itemSize);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
    ZYImagesM *model = self.dataSource[index];
    ZYImageSectionCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"ZYImageSectionCell" bundle:nil forSectionController:self atIndex:index];
    cell.backgroundColor = index%2==0?[UIColor grayColor]:[UIColor redColor];
    ///多张用 /sz/228
    ///单张用 /sz/480x270
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://file.izuiyou.com/img/view/id/%@/sz/480x270", model.uid]] placeholderImage:[UIImage imageNamed:@"special_placeholder"]];
    return cell;
}

/**
 ZYFeaturedSC中传递过来的数据
 */
- (void)didUpdateToObject:(id)object {
    self.dataSource = object;
}

#pragma mark - Init
#pragma mark - PublicMethod
#pragma mark - PrivateMethod
#pragma mark - Events
#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end
