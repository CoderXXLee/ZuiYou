//
//  BMSegmentView.h
//  ebm_driver
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 ebm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BMSegmentViewType) {
    BMSegmentViewTypeDefault,
    BMSegmentViewTypeOval
};

@interface BMSegmentView : UIView

/**
 按钮数组
 */
@property(nonatomic,strong, readonly) NSMutableArray *buttonList;
@property(nonatomic,strong) CALayer *LGLayer;

/**
 类型
 */
@property(nonatomic, assign) BMSegmentViewType type;

/**
 默认的颜色
 */
@property(nonatomic, strong) UIColor *normalColor;

/**
 默认的字体
 */
@property(nonatomic, strong) UIFont *normalFont;

/**
 选中的颜色
 */
@property(nonatomic, strong) UIColor *selectedColor;

/**
 选中的字体
 */
@property(nonatomic, strong) UIFont *selectedFont;

/**
 底部线条颜色
 */
@property(nonatomic, strong) UIColor *bannerColor;

/**
 设置宽高
 若不指定宽高，则采用默认值
 */
@property(nonatomic, assign) CGFloat segmentWidth;
@property(nonatomic, assign) CGFloat segmentHeight;

/**
 点击按钮回调
 */
@property (nonatomic ,copy) void(^scrollToPageBlock)(NSInteger page);

/**
 根据下标设置标题
 */
- (void)setTitle:(NSString *)title index:(NSUInteger)index;

/**
 设置选中的下标
 */
- (void)setSelectedIndex:(NSInteger)index;

/**
 添加按钮
 */
- (void)commonTitleArr:(NSArray *)titleArr;

- (void)moveToOffsetX:(CGFloat)X;

@end

