//
//  LEHttpTool.m
//  AI
//
//  Created by LE on 16/4/9.
//  Copyright © 2016年 LE. All rights reserved.
//

#import "LERequest.h"
#import "AFNetworking.h"
#import "NSString+AFLE.h"
#import <UIImage+Luban_iOS_Extension_h.h>

@implementation LERequest

/**
 *  发送一个get请求
 */
+ (NSURLSessionDataTask *)getWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 30.f;
    
    //验证token,以及加密
    [self addTokenWithParams:&params manager:session];
    
    NSURLSessionDataTask *task = [session GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
//    NSString *urlStr = [NSString stringWithFormat:@"%@", task.currentRequest.URL];
    return task;
}

/**
 *  发送一个Post请求
 */
+ (NSURLSessionDataTask *)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    //1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //验证token
    [self addTokenWithParams:&params manager:manager];
    
    //2.发送请求
    NSURLSessionDataTask *operation = [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
//    NSString *urlStr = [NSString stringWithFormat:@"%@", operation.currentRequest.URL];
    return operation;
}

/**
 *  发送一个Post请求
 */
+ (NSURLSessionDataTask *)postWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure uploadProgress:(void (^)(int64_t bytesWritten, int64_t totalBytesWritten, double totalBytesExpectedToWrite))block {
    //1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //验证token
    [self addTokenWithParams:&params manager:manager];
    
    //2.发送请求
    NSURLSessionDataTask *operation = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (block) {
            block(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount, uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return operation;
}

/**
 *  发送一个get请求
 */
+ (NSURLSessionDataTask *)getSerializerWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure {
    //1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //验证token
    [self addTokenWithParams:&params manager:manager];
    
    //2.发送请求
    NSURLSessionDataTask *operation = [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
//    NSString *urlStr = [NSString stringWithFormat:@"%@", operation.currentRequest.URL];
    return operation;
}

/**
 *  发送一个Post Serializer请求
 */
+ (void)postSerializerWithURL:(NSString *)url params:(NSDictionary *)params success:(HttpRequestSuccess1)success failure:(HttpRequestFailure)failure {
    //1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 30.f;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //验证token
    [self addTokenWithParams:&params manager:manager];
    
    //2.发送请求
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params image:(UIImage *)image success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure uploadProgress:(void (^)(int64_t bytesWritten, int64_t totalBytesWritten, double totalBytesExpectedToWrite))block {

    //1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.f;
    //2.发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *data = UIImageJPEGRepresentation(image, 1);
        ///压缩
        NSData *data = [UIImage luban_compressImage:image withMask:nil];
        NSLog(@"上传图片的大小:%fKB", data.length/1024.0);
        [formData appendPartWithFileData:data name:@"file" fileName:@"a.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (block) {
            block(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount, uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        sleep(2);
        if (success) {
            //            NSData *responseObjectData = responseObject;
            //            NSString *json =  [[NSString alloc]initWithData:responseObjectData encoding:NSUTF8StringEncoding];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/*!
 *  @brief  post请求, 上传多张图片
 *
 *  @param url
 *  @param params
 *  @param images
 *  @param success
 *  @param failure
 *  @param block
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params images:(NSDictionary *)images success:(HttpRequestSuccess)success failure:(HttpRequestFailure)failure uploadProgress:(void (^)(int64_t bytesWritten, int64_t totalBytesWritten, double totalBytesExpectedToWrite))block {
    //1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//  manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 40.f;
    
    //2.发送请求
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSArray *keys = images.allKeys;
        for (NSString *key in keys) {
            UIImage *image = [images objectForKey:key];
            NSAssert(image, @"上传的图片不能为空");
            NSData *data = UIImageJPEGRepresentation(image, 1);
            [formData appendPartWithFileData:data name:key fileName:@"a.jpg" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (block) {
            block(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount, uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        sleep(2);
        if (success) {
            //            NSData *responseObjectData = responseObject;
            //            NSString *json =  [[NSString alloc]initWithData:responseObjectData encoding:NSUTF8StringEncoding];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 添加token验证
 */
+ (void)addTokenWithParams:(NSDictionary **)params manager:(AFHTTPSessionManager *)manager {
//    NSDictionary *a = *params;
//    NSString *token = a[@"Token"];
//    id data = a[@"data"];
//    if (token && !token.isEmpty) {
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
//    }
//    else if (data && [data isKindOfClass:[NSString class]]) {
//        NSDictionary *paramDic = [data jsonStringToDictionary];
//        if (paramDic && paramDic[@"Token"]) {
//            token = paramDic[@"Token"];
//            [manager.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
//        }
//    }
//    else if (data && [data isKindOfClass:[NSDictionary class]]) {
//        if (data[@"Token"]) {
//            token = data[@"Token"];
//            [manager.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
//        }
//    }

    ///接口鉴权
    NSDictionary *sign = [self getSign];
    if (sign) {
        ///@{@"sign": strRSA, @"timestamp": dateStr, @"app_key": user.app_key, @"Token": user.Token}
        if (sign[@"timestamp"])
            [manager.requestSerializer setValue:sign[@"timestamp"] forHTTPHeaderField:@"timestamp"];
        if (sign[@"sign"])
            [manager.requestSerializer setValue:sign[@"sign"] forHTTPHeaderField:@"sign"];
        if (sign[@"app_key"])
            [manager.requestSerializer setValue:sign[@"app_key"] forHTTPHeaderField:@"appkey"];
        if (sign[@"Token"])
            [manager.requestSerializer setValue:sign[@"Token"] forHTTPHeaderField:@"Token"];
        if (sign[@"User"])
            [manager.requestSerializer setValue:sign[@"User"] forHTTPHeaderField:@"User"];
        if (sign[@"islogin"])
            [manager.requestSerializer setValue:sign[@"islogin"] forHTTPHeaderField:@"islogin"];
    } else {
        NSLog(@"接口鉴权获取失败");
    }
//    NSNumber *encrypt = a[@"encrypt"];
//    if (token && !token.isEmpty) {
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
//    }
//    else if (data && [data isKindOfClass:[NSString class]]) {
//        NSDictionary *paramDic = [data jsonStringToDictionary];
//        if (paramDic && paramDic[@"Token"]) {
//            token = paramDic[@"Token"];
//            [manager.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
//        }
//    }
//    else if (data && [data isKindOfClass:[NSDictionary class]]) {
//        if (data[@"Token"]) {
//            token = data[@"Token"];
//            [manager.requestSerializer setValue:token forHTTPHeaderField:@"Token"];
//        }
//    }
}

/**
 子类重写
 获取接口鉴权:@{@"sign": strRSA, @"timestamp": dateStr, @"app_key": user.app_key, @"Token": user.Token}
 */
+ (NSDictionary *)getSign {
    return nil;
}

@end
