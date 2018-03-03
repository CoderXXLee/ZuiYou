//
//  LEUserData.h
//  Medical
//
//  Created by LE on 15/11/23.
//  Copyright © 2015年 LE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEUserData : NSObject

/**
 该类需要应用MJExtension.h中的MJExtensionCodingImplementation
 */
@property (nonatomic, strong) id user;
@property (nonatomic, strong) NSDate *expiresTime;// 账号的过期时间
@property (nonatomic, strong) NSDate *loginInTime;// 账号的登录时间

@end
