//
//  ZYGodReviewsM.m
//  ZuiYou
//
//  Created by mac on 2018/3/3.
//  Copyright © 2018年 le. All rights reserved.
//

#import "ZYGodReviewsM.h"
#import "ZYImagesM.h"
#import <MJExtension.h>

@implementation ZYGodReviewsM

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"uid": @"id"};
}

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"imgs": [ZYImagesM class]};
}

/**
 *  旧值换新值，用于过滤字典中的值
 *  @param oldValue 旧值
 *  @return 新值
 */
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([property.name isEqualToString:@"videos"]) {
        NSDictionary *oldDic = oldValue;
        NSArray *newDic = oldDic.allValues;
        NSArray *new = [ZYVideosM mj_objectArrayWithKeyValuesArray:newDic];
        return new;
    }
    return oldValue;
}

@end
