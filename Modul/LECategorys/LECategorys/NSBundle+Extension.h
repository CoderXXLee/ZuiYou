//
//  NSBundle+Extension.h
//  LECategorys
//
//  Created by mac on 2018/3/2.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Extension)

/**
 加载json
 */
+ (id)loadJsonFromBundle:(NSString *)fileName;

@end
