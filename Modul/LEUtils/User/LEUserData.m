//
//  LEUserData.m
//  Medical
//
//  Created by LE on 15/11/23.
//  Copyright © 2015年 LE. All rights reserved.
//

#import "LEUserData.h"

@implementation LEUserData
/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
        self.loginInTime = [decoder decodeObjectForKey:@"loginInTime"];
        self.user = [decoder decodeObjectForKey:@"user"];
    }
    return self;
}
/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];
    [encoder encodeObject:self.loginInTime forKey:@"loginInTime"];
    [encoder encodeObject:self.user forKey:@"user"];
}
@end
