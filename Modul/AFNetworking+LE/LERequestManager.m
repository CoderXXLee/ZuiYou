//
//  LERequestManager.m
//  E
//
//  Created by lwp on 16/6/30.
//  Copyright © 2016年 com.haotu. All rights reserved.
//

#import "LERequestManager.h"
#import "objc/runtime.h"

static char loadOperationKey;

@implementation LERequestManager

+ (instancetype)shared {
    static LERequestManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LERequestManager alloc] init];
    });
    return manager;
}

#pragma mark - 绑定及取消队列中的下载任务
/*!
 *  绑定下载任务队列
 */
- (void)setCurrentRequestOperation:(NSURLSessionDataTask *)operation forKey:(NSString *)key {
    @synchronized(self) {
        [self cancelCurrentRequestOperationWithKey:key];
        NSMutableDictionary *operationDictionary = [self operationDictionary];
        [operationDictionary setObject:operation forKey:key];
    }
}
/*!
 *  绑定下载任务队列
 */
- (void)setCurrentRequestOperations:(NSArray *)operations forKey:(NSString *)key {
    @synchronized(self) {
        [self cancelCurrentRequestOperationWithKey:key];
        NSMutableDictionary *operationDictionary = [self operationDictionary];
        [operationDictionary setObject:operations forKey:key];
    }
}
/**
 *  取消队列中的下载任务
 */
- (void)cancelCurrentRequestOperationWithKey:(NSString *)key {
    NSMutableDictionary *operationDictionary = [self operationDictionary];
    id operations = [operationDictionary objectForKey:key];
    if (operations) {
        if ([operations isKindOfClass:[NSArray class]]) {
            for (NSURLSessionDataTask *operation in operations) {
                if (operation) {
                    [operation cancel];
                    [operationDictionary removeObjectForKey:key];
                    NSLog(@"请求取消成功Key:%@", key);
                }
            }
        } else if ([operations isKindOfClass:[NSURLSessionDataTask class]]){
            [(NSURLSessionDataTask *) operations cancel];
            [operationDictionary removeObjectForKey:key];
            NSLog(@"请求取消成功Key:%@", key);
        }
        [operationDictionary removeObjectForKey:key];
    }
}

/**
 取消所有请求
 */
- (void)cancelAllRequest {
    NSMutableDictionary *operationDictionary = [self operationDictionary];
    for (NSString *key in [operationDictionary allKeys]) {
//        id operations = [operationDictionary objectForKey:key];
        [self cancelCurrentRequestOperationWithKey:key];
    }
}

- (NSMutableDictionary *)operationDictionary {
    NSMutableDictionary *operations = objc_getAssociatedObject(self, &loadOperationKey);
    if (operations) {
        return operations;
    }
    operations = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &loadOperationKey, operations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operations;
}
@end
