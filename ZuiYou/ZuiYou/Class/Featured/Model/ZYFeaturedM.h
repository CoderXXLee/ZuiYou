//
//  ZYFeaturedM.h
//  ZuiYou
//
//  Created by mac on 2018/3/2.
//  Copyright © 2018年 le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListDiffable.h>
@class ZYImagesM, ZYVideosM, ZYGodReviewsM, ZYMemberM;

@interface ZYFeaturedM : NSObject <IGListDiffable>

@property (nonatomic,copy)   NSString *uid;
@property (nonatomic,copy)   NSString *mid;
@property (nonatomic,copy)   NSString *content;
@property (nonatomic,assign) NSUInteger reviews;
@property (nonatomic,assign) NSUInteger likes;
@property (nonatomic,assign) NSUInteger up;
@property (nonatomic,assign) NSUInteger ct;
@property (nonatomic,strong) NSArray<ZYImagesM *> *imgs;
@property (nonatomic,strong) NSArray<ZYVideosM *> *videos;
@property (nonatomic,assign) NSUInteger status;
@property (nonatomic,assign) NSUInteger share;
@property (nonatomic,assign) NSUInteger type;
@property (nonatomic,strong) ZYMemberM *member;
@property (nonatomic,copy)   NSDictionary *topic;
@property (nonatomic,copy)   NSArray<ZYGodReviewsM *> *god_reviews;
@property (nonatomic,copy)   NSArray *fine_reviews;

@end
