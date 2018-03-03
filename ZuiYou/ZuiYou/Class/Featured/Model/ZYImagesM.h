//
//  ZYImagesM.h
//  ZuiYou
//
//  Created by mac on 2018/3/3.
//  Copyright © 2018年 le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYImagesM : NSObject

@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *h;
@property(nonatomic, copy) NSString *w;
@property(nonatomic, copy) NSString *video;
@property(nonatomic, copy) NSString *dancnt;
@property(nonatomic, copy) NSString *fmt;

@end


@interface ZYVideosM : NSObject

/**
 "dur": 223,
 */
@property(nonatomic, copy) NSString *dur;

/**
 "thumb": 191427740,
 */
@property(nonatomic, copy) NSString *thumb;

/**
 "playcnt": 44002,
 */
@property(nonatomic, copy) NSString *playcnt;

/**
 "url": "http:\/\/tbapi.ixiaochuan.cn\/urlresolver\/tbvideo\/vid\/424e-e79c-11e7-b08a-00163e042306?pid=37181239&rid=316912105&imgid=191427740&cb=zyvd%2Fec%2F5b%2F424e-e79c-11e7-b08a-00163e042306",
 */
@property(nonatomic, copy) NSString *url;

/**
 "priority": 1,
 */
@property(nonatomic, copy) NSString *priority;

/**
 "urlsrc": "http:\/\/tbapi.ixiaochuan.cn\/urlresolver\/tbvideo\/vid\/424e-e79c-11e7-b08a-00163e042306?pid=37181239&rid=316912105&imgid=191427740&cb=zyvd%2Fec%2F5b%2F424e-e79c-11e7-b08a-00163e042306",
 */
@property(nonatomic, copy) NSString *urlsrc;

/**
 "urlext": "http:\/\/tbapi.ixiaochuan.cn\/urlresolver\/get_video_real_url\/vid\/NrJILCIRLzgc-yficw4mK5cz1gH-jJ0FWE4oFw__?pid=37181239&rid=316912105&imgid=191427740",
 */
@property(nonatomic, copy) NSString *urlext;

/**
 "h5type": "miaopai",
 */
@property(nonatomic, copy) NSString *h5type;

/**
 "h5id": "oOL7X8zQy6BztYoFX5VabmHOyy-yAoGt4QILyg__",
 */
@property(nonatomic, copy) NSString *h5id;

/**
 "urlwm": "http:\/\/tbvideo.ixiaochuan.cn\/zyvd\/2f\/ea\/4287-6483-472e-8281-f13af5e05c90"
 */
@property(nonatomic, copy) NSString *urlwm;
@end
