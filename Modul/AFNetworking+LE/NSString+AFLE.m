//
//  NSString+AFLE.m
//  Pods
//
//  Created by mac on 2017/3/29.
//
//

#import "NSString+AFLE.h"

@implementation NSString (AFLE)

- (BOOL)isEmpty {
    if (self != nil && ![@"" isEqualToString:self.trim]) {
        return NO;
    }
    return YES;
}

/**
 截取字符串前后空格
 */
- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/*!
 *  jsonStr转NSDictionary
 */
- (NSDictionary *)jsonStringToDictionary {
    if (self == nil || self.isEmpty) {
        return nil;
    }
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
