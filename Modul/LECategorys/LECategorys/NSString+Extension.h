//
//  NSString+Extension.h
//  CreditAddressBook
//
//  Created by Lee on 15/6/11.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///三元运算
#define LETernary(str, trueResult, falseResult) (str && !str.isEmpty)?trueResult:falseResult
#define LESimpleTernary(str, falseResult) LETernary(str, str, falseResult)
///不为nil且不为空字符串（当字符串为nil时不会调用isEmpty方法，故要先判断是否为nil）
#define LEStrNotEmpty(str) (str && !str.isEmpty)

@interface NSString (Extension)

/**
 NSDictionary转jsonStr
 */
+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;

/**
 NSArray转jsonStr
 */
+ (NSString *)jsonStringWithArray:(NSArray *)array;

/**
 NSString转jsonStr
 */
+ (NSString *)jsonStringWithString:(NSString *)string;

/**
 object转jsonStr
 */
+ (NSString *)jsonStringWithObject:(id)object;

/*!
 *  jsonStr转NSDictionary
 */
- (NSDictionary *)jsonStringToDictionary;
/*!
 *  对比两个字符串内容是否一致
 */
- (BOOL)equals:(NSString*)string;

//判断字符串是否以指定的前缀开头
- (BOOL)startsWith:(NSString*)prefix;

//判断字符串是否以指定的后缀结束
- (BOOL)endsWith:(NSString*)suffix;

//转换成大写
- (NSString *)toLowerCase;

//转换成小写
- (NSString *)toUpperCase;

//截取字符串前后空格
- (NSString *)trim;
/*!
 *  用指定分隔符将字符串分割成数组
 */
- (NSArray *)split:(NSString*)separator;
/*!
 *  返回指定子字符串在字符串中的下标数组
 */
- (NSArray *)indexsForSubString:(NSString *)sub;

//用指定字符串替换原字符串
- (NSString *)replaceAll:(NSString*)oldStr with:(NSString*)newStr;

//从指定的开始位置和结束位置开始截取字符串
- (NSString *)substringFromIndex:(int)begin toIndex:(int)end;
/**判断字符串是否为@“”*/
- (BOOL)isEmpty;
/**拼接字符串*/
- (NSString *)appendingString:(NSString *)str;
/*!
 *  设置小数字符串小数点后的位数
 */
- (NSString *)decimals:(int)decimals;
/*!
 *  是否包含指定字符串
 */
- (BOOL)hasContains:(NSString *)str;

/**
 判断是否为整形
 */
- (BOOL)le_isPureInt;

/**
 判断是否为浮点形：
 */
- (BOOL)le_isPureFloat;

#pragma mark - 

/**
 计算单行字符串的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 根据通过size限制的字符串 计算换行(需要固定宽)/单行字符串的 高/宽

 @param font 字体
 @param size 换行：CGSizeMake(LEScreenWidth, MAXFLOAT)；单行：CGSizeMake(MAXFLOAT, MAXFLOAT)
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
