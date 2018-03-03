//
//  LEHttpTool.h
//  AI
//
//  Created by LE on 16/4/9.
//  Copyright © 2016年 LE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "LERequestManager.h"

typedef void (^HttpRequestSuccess)(id json);
typedef void (^HttpRequestSuccess1)(id data);
typedef void (^HttpRequestSuccess2)(NSString *message);
typedef void (^HttpRequestFailure)(NSError *error);
typedef void (^HttpRequestFailure1)(NSString *message, NSError *error);
typedef void (^HttpRequestFailure2)(NSString *message, BOOL isLogin);

@interface LERequest : NSObject
/**
 *  发送一个get请求
 */
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
/**
 *  发送一个Post请求
 */
+ (NSURLSessionDataTask *)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
/**
 *  发送一个Post请求
 */
+ (NSURLSessionDataTask *)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure uploadProgress:(void (^)(int64_t bytesWritten, int64_t totalBytesWritten, double totalBytesExpectedToWrite))block;
/**
 *  发送一个getSerializer请求
 */
+ (NSURLSessionDataTask *)getSerializerWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure;
/**
 *  发送一个Post Serializer请求
 */
+ (void)postSerializerWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess1)success failure:(HttpRequestFailure)failure;
/**
 *  文件上传
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure uploadProgress:(void (^)(int64_t bytesWritten, int64_t totalBytesWritten, double totalBytesExpectedToWrite))block;
/*!
 *  @brief  post请求, 上传多张图片
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params images:(NSDictionary *)images success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure uploadProgress:(void (^)(int64_t bytesWritten, int64_t totalBytesWritten, double totalBytesExpectedToWrite))block;

/**
 子类重写
 获取接口鉴权
 */
+ (NSDictionary *)getSign;

@end
