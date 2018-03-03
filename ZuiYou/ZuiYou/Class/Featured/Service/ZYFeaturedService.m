//
//  ZYFeaturedService.m
//  ZuiYou
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYFeaturedService.h"

@implementation ZYFeaturedService

/**
 加载推荐数据
 */
+ (void)recommend {
    [self postWithURL:@"https://api.izuiyou.com/index/recommend?sign=3e71c63608066df58d2af260fffff3fe" params:@{@"h_model": @"iPhone 6",@"h_ch": @"appstore", @"h_app": @"zuiyou", @"h_ts": @1519983526164, @"h_av": @"4.1.3", @"tab": @"rec", @"h_did": @"2a3b04a45791b653280b3701439d4a56c2b76310", @"filter": @"all", @"h_os": @"9.300000", @"auto": @1, @"h_nt": @1, @"h_m": @54401863, @"token": @"T3KaNLTUqTX0w2IXCfR8AwJqvH5nCOWYGEXlaaODyf8k2V4xyOlRPDBuMH5fH4YJApFUh", @"h_dt": @1, @"direction": @"down"} success:^(id json) {
        NSLog(@"json: %@", json);
    } failure:^(NSError *error) {

    }];
}

@end
