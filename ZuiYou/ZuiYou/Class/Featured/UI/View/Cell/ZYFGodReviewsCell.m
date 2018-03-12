//
//  ZYFGodReviewsCell.m
//  ZuiYou
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFGodReviewsCell.h"
#import <UIImage+Extension.h>

@interface ZYFGodReviewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end

@implementation ZYFGodReviewsCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.bgImageView.image = [UIImage resizedImageWithName:@"bg_best_reply" left:.1f top:.7f];
}

@end
