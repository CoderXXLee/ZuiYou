//
//  BMSegmentView.m
//  ebm_driver
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 ebm. All rights reserved.
//

#import "BMSegmentView.h"
#import <LECommon.h>

#define BtnColor_Sel [UIColor blackColor]///,默认颜色
#define BtnColor_UnSel LEColor(94,94,94,1)///,默认颜色

#define BannerColor [UIColor blackColor]///底部线条颜色,默认颜色
#define BannerH 3///底部线条高度,默认颜色

@interface BMSegmentView ()
/** title个数 */
@property (nonatomic ,assign) NSInteger titleCount;

@end

@implementation BMSegmentView

#pragma mark - LazyLoad

#pragma mark - Super

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _buttonList = [NSMutableArray array];
        self.segmentWidth = frame.size.width;
        self.segmentHeight = frame.size.height;
//        [self initUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _buttonList = [NSMutableArray array];
//    [self initUI];
}

- (void)dealloc {
    NSLog(@"BMSegmentView销毁");
}

#pragma mark - Init

- (void)createItem:(NSArray *)item {
    for (UIButton *btn in self.subviews) {
        [btn removeFromSuperview];
    }

    int count = (int)item.count;

    CGFloat segmentWidth = self.segmentWidth>0?self.segmentWidth:LEScreeSize.width;
    CGFloat segmentHeight = self.segmentHeight>0?self.segmentHeight:self.frame.size.height;
    CGFloat btnW = segmentWidth/count;

    CGFloat marginX = (segmentWidth - count * btnW)/(count + 1);
    for (int i = 0; i < count; i++) {
        NSString *temp = [item objectAtIndex:i];
        //按钮的X坐标计算，i为列数
        CGFloat buttonX = marginX + i * (btnW + marginX);

        UIButton *buttonItem = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, btnW, segmentHeight)];
        [_buttonList addObject:buttonItem];
        //设置
        buttonItem.tag = i + 1300;
        buttonItem.titleLabel.font = [UIFont systemFontOfSize:15];
        [buttonItem setTitle:temp forState:UIControlStateNormal];
        [buttonItem setTitleColor:self.normalColor forState:UIControlStateNormal];
        buttonItem.titleLabel.font = self.normalFont;
        [buttonItem addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonItem];

        //        [self.buttonList addObject:buttonItem];
        //第一个按钮默认被选中
        if (i == 0) {
            CGFloat firstX = buttonX;
            [buttonItem setTitleColor:self.selectedColor forState:UIControlStateNormal];
            if (self.type == BMSegmentViewTypeOval) {
                [self createOval:firstX];
            } else {
                [self createBanner:firstX];
//                [self createOval:firstX];
            }
        }

        buttonX += marginX;
    }
}

/**
 底部下划线
 */
- (void)createBanner:(CGFloat)firstX {
    //初始化
    self.LGLayer = [[CALayer alloc] init];
    _LGLayer.backgroundColor = self.bannerColor.CGColor;

    CGFloat segmentWidth = self.segmentWidth>0?self.segmentWidth:LEScreeSize.width;
    CGFloat segmentHeight = self.segmentHeight>0?self.segmentHeight:self.frame.size.height;
    _LGLayer.frame = CGRectMake(firstX, segmentHeight - 3, segmentWidth / _titleCount, BannerH);
    // 设定它的frame
    _LGLayer.cornerRadius = BannerH / 2;// 圆角处理
    [self.layer addSublayer:_LGLayer]; // 增加到UIView的layer上面

    ///底部分割线
    [self createLine];
}

/**
 选中椭圆背景
 */
- (void)createOval:(CGFloat)firstX {
    //初始化
    self.LGLayer = [[CALayer alloc] init];
    _LGLayer.backgroundColor = self.bannerColor.CGColor;

    CGFloat segmentWidth = self.segmentWidth>0?self.segmentWidth:LEScreeSize.width;
    CGFloat segmentHeight = self.segmentHeight>0?self.segmentHeight:self.frame.size.height;
    _LGLayer.frame = CGRectMake(firstX+3, 3, segmentWidth/_titleCount-6, segmentHeight-6);
    // 设定它的frame
    _LGLayer.cornerRadius = BannerH / 2;// 圆角处理
    [self.layer insertSublayer:_LGLayer atIndex:0]; // 增加到UIView的layer上面

    ///底部分割线
//    [self createLine];
}

#pragma mark - PublicMethod

/**
 添加按钮
 */
- (void)commonTitleArr:(NSArray *)titleArr {
    _titleCount = titleArr.count;
    [self createItem:titleArr];
}

/**
 根据下标设置标题
 */
- (void)setTitle:(NSString *)title index:(NSUInteger)index {
    UIButton *btn = [_buttonList objectAtIndex:index];
    if (btn) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

/**
 设置选中的下标
 */
- (void)setSelectedIndex:(NSInteger)index {
    UIButton *btn = [_buttonList objectAtIndex:index];
    if (btn) {
        [btn setTitleColor:self.selectedColor forState:UIControlStateNormal];
        CGFloat bannerX = btn.center.x;
        [self bannerMoveTo:bannerX];
        [self didSelectButton:btn];
    }
}

- (UIColor *)normalColor {
    if (!_normalColor) {
        return BtnColor_UnSel;
    }
    return _normalColor;
}

- (UIFont *)normalFont {
    if (!_normalFont) {
        return [UIFont systemFontOfSize:14];
    }
    return _normalFont;
}

- (UIColor *)selectedColor {
    if (!_selectedColor) {
        return BtnColor_Sel;
    }
    return _selectedColor;
}

- (UIFont *)selectedFont {
    if (!_selectedFont) {
        return [UIFont systemFontOfSize:14];
    }
    return _selectedFont;
}

- (UIColor *)bannerColor {
    if (!_bannerColor) {
        return BannerColor;
    }
    return _bannerColor;

}

#pragma mark - PrivateMethod

/**
 底部分割线
 */
- (void)createLine {
    ///设置分割线
    CALayer *line = [[CALayer alloc] init];
    CGFloat segmentWidth = self.segmentWidth>0?self.segmentWidth:LEScreeSize.width;
    CGFloat segmentHeight = self.segmentHeight>0?self.segmentHeight:self.frame.size.height;
    line.frame = CGRectMake(0, segmentHeight-0.5, segmentWidth, 0.5);
    [self.layer addSublayer:line];
    line.backgroundColor = [UIColor lightGrayColor].CGColor;
}

#pragma mark - Events

- (void)buttonClick:(UIButton *)sender {
    //获取被点击按钮
    UIButton *btn = (UIButton *)sender;

    [btn setTitleColor:self.selectedColor forState:UIControlStateNormal];
    btn.titleLabel.font = self.selectedFont;

    CGFloat bannerX = btn.center.x;

    [self bannerMoveTo:bannerX];

    [self didSelectButton:sender];

    if (self.scrollToPageBlock) {
        self.scrollToPageBlock(sender.tag - 1300);
    }

}

- (void)moveToOffsetX:(CGFloat)offsetX {
    UIButton *bt1 = (UIButton *)[self viewWithTag:1300];
    UIButton *bt2 = (UIButton *)[self viewWithTag:1301];
    UIButton *bt3 = (UIButton *)[self viewWithTag:1302];

    CGFloat segmentWidth = self.segmentWidth>0?self.segmentWidth:LEScreeSize.width;
//    CGFloat segmentHeight = self.segmentHeight>0?self.segmentHeight:self.frame.size.height;

    CGFloat bannerX = bt1.center.x;
    CGFloat offSet = offsetX;
    CGFloat addX = offSet / segmentWidth * (bt2.center.x - bt1.center.x);

    bannerX += addX;

    [self bannerMoveTo:bannerX];

    if (offsetX == 0) {
        [self didSelectButton:bt1];
    } else if (offsetX == segmentWidth) {
        [self didSelectButton:bt2];

    } else if (offsetX == segmentWidth * 2){
        [self didSelectButton:bt3];
    }
}

- (void)bannerMoveTo:(CGFloat)bannerX {
    //基本动画，移动到点击的按钮下面
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    pathAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(bannerX, 10)];
    //组合动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = [NSArray arrayWithObjects:pathAnimation, nil];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animationGroup.duration = 0.3;
    //设置代理
    //    animationGroup.delegate = self;
    //1.3设置动画执行完毕后不删除动画
    animationGroup.removedOnCompletion = NO;
    //1.4设置保存动画的最新状态
    animationGroup.fillMode = kCAFillModeForwards;

    //监听动画
    [animationGroup setValue:@"animationStep1" forKey:@"animationName"];
    //动画加入到changedLayer上
    [_LGLayer addAnimation:animationGroup forKey:nil];
}

//点击按钮后改变字体颜色
- (void)didSelectButton:(UIButton*)Button {
    for (UIButton *btn in self.subviews) {
        if (btn == Button) {
            [btn setTitleColor:self.selectedColor forState:UIControlStateNormal];
            btn.titleLabel.font = self.selectedFont;
        } else {
            [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
            btn.titleLabel.font = self.normalFont;
        }
    }
}

#pragma mark - LoadFromService
#pragma mark - Delegate
#pragma mark - StateMachine

@end




