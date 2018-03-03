//
//  ZYMemberM.h
//  ZuiYou
//
//  Created by mac on 2018/3/3.
//  Copyright © 2018年 le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYMemberM : NSObject

/**
 "id": 7934483,
 */
@property(nonatomic, copy) NSString *uid;

/**
 "isreg": 1,
 */
@property(nonatomic, copy) NSString *isreg;

/**
 "ct": 1475926609,
 */
@property(nonatomic, copy) NSString *ct;

/**
 "name": "私欲i",
 */
@property(nonatomic, copy) NSString *name;

/**
 "gender": 1,
 */
@property(nonatomic, copy) NSString *gender;

/**
 "sign": "关注走一走 炮友天天有 一炮干一宿 活到99 ~",
 */
@property(nonatomic, copy) NSString *sign;

/**
 "avatar": 209181260,
 */
@property(nonatomic, copy) NSString *avatar;

/**
 "cover": 218065754,
 */
@property(nonatomic, copy) NSString *cover;

/**
 "atts": 14,
 */
@property(nonatomic, copy) NSString *atts;

/**
 "fans": 130,
 */
@property(nonatomic, copy) NSString *fans;

/**
 "medal": {
    "original": 1,
    "name": "搞笑视频、影视剪辑达人",
    "click_url": "\/help\/kol\/describe"
 },
 */
@property(nonatomic, copy) NSDictionary *medal;

/**
 "epaulet": {
    "type": 1,
    "name": "搞笑视频、影视剪辑达人",
    "click_url": "\/help\/kol\/describe"
 }
 */
@property(nonatomic, copy) NSDictionary *epaulet;

@end
