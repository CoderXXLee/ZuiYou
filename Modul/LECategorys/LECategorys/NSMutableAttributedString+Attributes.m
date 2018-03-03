//
//  NSMutableAttributedString+Helper.m
//  DossierPolice
//
//  Created by Dmitry Shmidt on 7/26/13.
//  Copyright (c) 2013 Shmidt Lab. All rights reserved.
//
#import "NSMutableAttributedString+Attributes.h"
@interface NSString(MASAttributes)
-(NSRange)rangeOfStringNoCase:(NSString*)s;
@end

@implementation NSString(MASAttributes)
- (NSRange)rangeOfStringNoCase:(NSString*)s {
    return  [self rangeOfString:s options:NSCaseInsensitiveSearch];
}
/*!
 *  返回字符串中所有指定子字符串的位置下标数组
 */
- (NSArray *)indexsForSubString:(NSString *)sub {
    NSMutableArray *arrayOfLocation = [NSMutableArray new];
    NSArray *strs = [self componentsSeparatedByString:sub];
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
//    NSMutableArray *arrayOfLocation = [NSMutableArray new];
//    while ([copyStr rangeOfString:sub].location != NSNotFound) {
//        NSRange range = [copyStr rangeOfString:sub];
////        NSLog(@"location:%lu",(unsigned long)range.location);
//        [arrayOfLocation addObject:[NSNumber numberWithInteger:range.location]];
//        copyStr = [copyStr stringByReplacingCharactersInRange:NSMakeRange(range.location, range.length) withString:@"XXX"];
//    }
    return arrayOfLocation;
}
@end
@implementation NSMutableAttributedString (Attributes)

/**
 指定NSRange添加颜色
 */
- (void)addColor:(UIColor *)color range:(NSRange)range {
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:range];
    }
}

- (void)addColor:(UIColor *)color substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSForegroundColorAttributeName
                     value:color
                     range:range];
    }
}
- (void)addColor:(UIColor *)color {
    [self addColor:color substring:self.string];
}
/*!
 *  将字符串中所有的substring替换为指定颜色
 */
- (void)addColor:(UIColor *)color allSubstring:(NSString *)substring {
    NSArray *indexs = [self.string indexsForSubString:substring];
    for (NSNumber *index in indexs) {
        NSRange range = NSMakeRange(index.integerValue, substring.length);
        if (range.location != NSNotFound && color != nil) {
            [self addAttribute:NSForegroundColorAttributeName value:color range:range];
        }
    }
}
- (void)addBackgroundColor:(UIColor *)color substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSBackgroundColorAttributeName
                     value:color
                     range:range];
    }
}

/**
 添加下划线
 */
- (void)addUnderlineForSubstring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute:NSUnderlineStyleAttributeName
                     value:@(NSUnderlineStyleSingle)
                     range:range];
    }
}

/**
 设置下划线颜色
 */
- (void)addUnderlineColorForSubstring:(NSString *)substring color:(UIColor *)color {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute:NSUnderlineStyleAttributeName
                     value:color
                     range:range];
    }
}

/**
 添加删除线
 */
- (void)addStrikeThrough:(int)thickness substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute: NSStrikethroughStyleAttributeName
                     value:@(thickness)
                     range:range];
    }
}
- (void)addShadowColor:(UIColor *)color width:(int)width height:(int)height radius:(int)radius substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowColor:color];
        [shadow setShadowOffset:CGSizeMake (width, height)];
        [shadow setShadowBlurRadius:radius];
        
        [self addAttribute: NSShadowAttributeName
                     value:shadow
                     range:range];
    }
}
- (void)addFontWithName:(NSString *)fontName size:(int)fontSize substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && fontName != nil) {
        UIFont * font = [UIFont fontWithName:fontName size:fontSize];
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}
- (void)addFont:(UIFont *)font substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && font != nil) {
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}

/*!
 *  将字符串中所有的substring替换为指定UIFont
 */
- (void)addFont:(UIFont *)font allSubstring:(NSString *)substring {
    NSArray *indexs = [self.string indexsForSubString:substring];
    for (NSNumber *index in indexs) {
        NSRange range = NSMakeRange(index.integerValue, substring.length);
        if (range.location != NSNotFound && font != nil) {
            [self addAttribute: NSFontAttributeName value:font range:range];
        }
    }
}
- (void)addFont:(UIFont *)font range:(NSRange)range {
//    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && font != nil) {
        [self addAttribute: NSFontAttributeName
                     value:font
                     range:range];
    }
}
- (void)addAlignment:(NSTextAlignment)alignment substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
        style.alignment = alignment;
        [self addAttribute: NSParagraphStyleAttributeName
                     value:style
                     range:range];
    }
}

/**
 添加自定义NSMutableParagraphStyle类型

 @param style NSMutableParagraphStyle
 */
- (void)addParagraphStyle:(NSMutableParagraphStyle *)style substring:(NSString *)substring {
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute:NSParagraphStyleAttributeName
                     value:style
                     range:range];
    }
}

/**
 添加自定义NSMutableParagraphStyle类型
 @param style NSMutableParagraphStyle
 */
- (void)addParagraphStyle:(NSMutableParagraphStyle *)style {
    [self addParagraphStyle:style substring:self.string];
}

- (void)addColorToRussianText:(UIColor *)color{
    if(color == nil) return;
    
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"];
    
    NSRange searchRange = NSMakeRange(0,self.string.length);
    NSRange foundRange;
    while (searchRange.location < self.string.length) {
        searchRange.length = self.string.length-searchRange.location;
        foundRange = [self.string rangeOfCharacterFromSet:set options:NSCaseInsensitiveSearch range:searchRange];
        if (foundRange.location != NSNotFound) {
            [self addAttribute:NSForegroundColorAttributeName
                         value:color
                         range:foundRange];
            
            searchRange.location = foundRange.location+1;
            
        } else {
            // no more substring to find
            break;
        }
    }
}
- (void)addStrokeColor:(UIColor *)color thickness:(int)thickness substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound && color != nil) {
        [self addAttribute:NSStrokeColorAttributeName
                     value:color
                     range:range];
        [self addAttribute:NSStrokeWidthAttributeName
                     value:@(thickness)
                     range:range];
    }
}
- (void)addVerticalGlyph:(BOOL)glyph substring:(NSString *)substring{
    NSRange range = [self.string rangeOfStringNoCase:substring];
    if (range.location != NSNotFound) {
        [self addAttribute:NSForegroundColorAttributeName
                     value:@(glyph)
                     range:range];
    }
}

@end

@implementation NSString (Russian)
- (BOOL)hasRussianCharacters{
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"];
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}
- (BOOL)hasEnglishCharacters{
    NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}
@end
