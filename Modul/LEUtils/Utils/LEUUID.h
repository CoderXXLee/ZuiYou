//
//  LEUUID.h
//  CreditAddressBook
//
//  Created by Lee on 15/7/30.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEUUID : NSObject
/**
 *  随机生成一个UUID
 */
+ (NSString *)UUID;
/**
 *  获取设备UUID
 */
+ (NSString *)UUIDForVendor;

+ (NSString *)UUIDForSession;
@end
