//
//  LERequestManager.h
//  E
//
//  Created by lwp on 16/6/30.
//  Copyright © 2016年 com.haotu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LERequestManager : NSObject

+ (instancetype)shared;
/**
 *  取消队列中的下载任务
 */
- (void)cancelCurrentRequestOperationWithKey:(NSString *)key;
/*!
 *  绑定下载任务队列
 */
- (void)setCurrentRequestOperation:(NSURLSessionDataTask *)operation forKey:(NSString *)key;
/*!
 *  绑定下载任务队列
 */
- (void)setCurrentRequestOperations:(NSArray *)operations forKey:(NSString *)key;

/**
 取消所有请求
 */
- (void)cancelAllRequest;

@end
