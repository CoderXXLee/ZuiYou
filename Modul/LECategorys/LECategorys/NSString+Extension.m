//
//  NSString+Extension.m
//  CreditAddressBook
//
//  Created by Lee on 15/6/11.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)jsonStringWithString:(NSString *)string {
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+ (NSString *)jsonStringWithArray:(NSArray *)array {
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary {
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [NSString jsonStringWithObject:valueObj];
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}

+ (NSString *)jsonStringWithObject:(id)object {
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [NSString jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [NSString jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [NSString jsonStringWithArray:object];
    }else {
        value = [NSString stringWithFormat:@"%@", object];
    }
    return value;
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

//对比两个字符串内容是否一致
- (BOOL)equals:(NSString *)string {
    return [self isEqualToString:string];
}

//判断字符串是否以指定的前缀开头
- (BOOL) startsWith:(NSString*)prefix
{
    return [self hasPrefix:prefix];
}

//判断字符串是否以指定的后缀结束
- (BOOL) endsWith:(NSString*)suffix
{
    return [self hasSuffix:suffix];
}

//转换成小写
- (NSString *) toLowerCase
{
    return [self lowercaseString];
}

//转换成大写
- (NSString *) toUpperCase
{
    return [self uppercaseString];
}

//截取字符串前后空格
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//用指定分隔符将字符串分割成数组
- (NSArray *)split:(NSString*) separator
{
    return [self componentsSeparatedByString:separator];
}
/*!
 *  返回字符串中所有指定子字符串的位置下标数组
 */
- (NSArray *)indexsForSubString:(NSString *)sub {
    NSMutableArray *arrayOfLocation = [NSMutableArray new];
    NSArray *strs = [self split:sub];
    NSInteger index = 0;
    for (int i = 0; i < strs.count - 1; i++) {
        NSString *str = strs[i];
        if (i > 0) {
            index = index + str.length + sub.length;
        } else {
            index += str.length;
        }
        [arrayOfLocation addObject:[NSNumber numberWithInteger:index]];
    }
//    NSString *copyStr = self;
//    while ([copyStr rangeOfString:sub].location != NSNotFound) {
//        NSRange range = [copyStr rangeOfString:sub];
////        NSLog(@"location:%lu",(unsigned long)range.location);
//        [arrayOfLocation addObject:[NSNumber numberWithInteger:range.location]];
//        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:@"XXX"];
//    }
    return arrayOfLocation;
}

//用指定字符串替换原字符串
- (NSString *) replaceAll:(NSString*)oldStr with:(NSString*)newStr
{
    return [self stringByReplacingOccurrencesOfString:oldStr withString:newStr];
}

//从指定的开始位置和结束位置开始截取字符串
- (NSString *) substringFromIndex:(int)begin toIndex:(int)end
{
    if (end <= begin) {
        return @"";
    }
    NSRange range = NSMakeRange(begin, end - begin);
    return [self substringWithRange:range];
}

- (BOOL)isEmpty {
    if (self != nil && ![@"" equals:self.trim]) {
        return NO;
    }
    return YES;
}

- (NSString *)appendingString:(NSString *)str {
    if (str) {
        return [self stringByAppendingString:str];
    }
    return self;
}
/*!
 *  设置小数字符串小数点后的位数
 */
- (NSString *)decimals:(int)decimals {
    if (self != nil && !self.isEmpty) {
        CGFloat number = self.floatValue;
        NSNumberFormatter *nFormat = [[NSNumberFormatter alloc] init];
        [nFormat setNumberStyle:NSNumberFormatterDecimalStyle];
        [nFormat setMaximumFractionDigits:decimals];
        [nFormat setMinimumFractionDigits:decimals];
        NSString *string = [nFormat stringFromNumber:@(number)];
        return string;
    }
    return @"0";
}
/*!
 *  是否包含指定字符串
 */
- (BOOL)hasContains:(NSString *)str {
    //字条串是否包含有某字符串
    if ([self rangeOfString:str].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
    //在iOS8中你可以这样判断
//    NSString *str = @"hello world";
//    if ([str containsString:@"world"]) {
//        NSLog(@"str 包含 world");
//    } else {
//        NSLog(@"str 不存在 world");
//    }
}

/**
 判断是否为整形
 */
- (BOOL)le_isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 判断是否为浮点形：
 */
- (BOOL)le_isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 三元运算
 */
- (NSString *)ternary:(NSString *)falseResult {
    NSString *result = (!self.isEmpty)?self:falseResult;
    return result;
}

#pragma mark -

/**
 计算单行字符串的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[NSFontAttributeName] = font;
    return [self sizeWithAttributes:dic];
}

/**
 根据通过size限制的字符串 计算换行(需要固定宽)/单行字符串的 高/宽

 @param font 字体
 @param size 换行：CGSizeMake(LEScreenWidth, MAXFLOAT)；单行：CGSizeMake(MAXFLOAT, MAXFLOAT)
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    dic[NSFontAttributeName] = font;
    return [self boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) attributes:dic context:nil].size;
}

@end
