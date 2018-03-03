//
//  NSBundle+Extension.m
//  LECategorys
//
//  Created by mac on 2018/3/2.
//

#import "NSBundle+Extension.h"

@implementation NSBundle (Extension)

/**
 加载json
 */
+ (id)loadJsonFromBundle:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSAssert(!error, [error localizedDescription]);
    return json;
}

@end
