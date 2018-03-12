//
//  ZYGodReviewsM.h
//  ZuiYou
//
//  Created by mac on 2018/3/3.
//  Copyright © 2018年 le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListDiffable.h>
@class ZYImagesM, ZYVideosM;

@interface ZYGodReviewsM : NSObject <IGListDiffable>

/**
 "_id":339948764,
 "id":339948764,
 */
@property(nonatomic, copy) NSString *uid;

/**
 "pid":39732691,
 */
@property(nonatomic, copy) NSString *pid;

/**
 "mid":41044982,
 */
@property(nonatomic, copy) NSString *mid;

/**
 "ct":1517178579,
 */
@property(nonatomic, copy) NSString *ct;

/**
 "ut":1520043570,
 */
@property(nonatomic, copy) NSString *ut;

/**
 "godt":1520043570,
 */
@property(nonatomic, copy) NSString *godt;

/**
 "svut":1520043428,
 */
@property(nonatomic, copy) NSString *svut;

/**
 "likes":1377
 */
@property(nonatomic, copy) NSString *likes;

/**
 "up":1410,
 */
@property(nonatomic, copy) NSString *up;

/**
 "down":33,
 */
@property(nonatomic, copy) NSString *down;

/**
 "isgod":1,
 */
@property(nonatomic, copy) NSString *isgod;

/**
 "godcheck":1,
 */
@property(nonatomic, copy) NSString *godcheck;

/**
 "subreviewcnt":231,
 */
@property(nonatomic, copy) NSString *subreviewcnt;

/**
 "status":3,
 */
@property(nonatomic, copy) NSString *status;

/**
 "vd_stat":1,
 */
@property(nonatomic, copy) NSString *vd_stat;

/**
 "score":0.54023853535261,
 */
@property(nonatomic, copy) NSString *score;

/**
 "disp":317406,
 */
@property(nonatomic, copy) NSString *disp;

/**
 "review":"看这个，妈妈的，吓人",
 */
@property(nonatomic, copy) NSString *review;

/**
 "source":"user",
 */
@property(nonatomic, copy) NSString *source;

/**
 "ip":"117.136.24.166, 120.27.173.71",
 */
@property(nonatomic, copy) NSString *ip;

/**
 "imgs":[
 {
 "id":205420063,
 "h":480,
 "w":852,
 "video":1,
 "dancnt":1157,
 "fmt":"jpeg"
 }
 ],
 */
@property(nonatomic, strong) NSArray<ZYImagesM *> *imgs;

/**
 videos
 */
@property(nonatomic, strong) NSArray<ZYVideosM *> *videos;

/**
 "pos":99,
 */
@property(nonatomic, copy) NSString *pos;

/**
 "mname":"$毒 品",
 */
@property(nonatomic, copy) NSString *mname;

/**
 "avatar":213527168,
 */
@property(nonatomic, copy) NSString *avatar;

/**
 "gender":2
 */
@property(nonatomic, copy) NSString *gender;

@end
