//
//  NSMutableAttributedString+Helper.h
//  DossierPolice
//
//  Created by Dmitry Shmidt on 7/26/13.
//  Copyright (c) 2013 Shmidt Lab. All rights reserved.
//

#ifdef __MAC_OS_X_VERSION_MIN_REQUIRED
typedef NSFont UIFont;
typedef NSColor UIColor;
#endif

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Attributes)

/** 指定NSRange添加颜色 */
- (void)addColor:(UIColor *)color range:(NSRange)range;
- (void)addColor:(UIColor *)color substring:(NSString *)substring;
- (void)addColor:(UIColor *)color;
/*! 将字符串中所有的substring替换为指定颜色 */
- (void)addColor:(UIColor *)color allSubstring:(NSString *)substring;
- (void)addBackgroundColor:(UIColor *)color substring:(NSString *)substring;
/** 添加下划线 */
- (void)addUnderlineForSubstring:(NSString *)substring;
/** 设置下划线颜色 */
- (void)addUnderlineColorForSubstring:(NSString *)substring color:(UIColor *)color;
- (void)addStrikeThrough:(int)thickness substring:(NSString *)substring;
- (void)addShadowColor:(UIColor *)color width:(int)width height:(int)height radius:(int)radius substring:(NSString *)substring;
- (void)addFontWithName:(NSString *)fontName size:(int)fontSize substring:(NSString *)substring;
- (void)addFont:(UIFont *)font substring:(NSString *)substring;
/*!
 *  将字符串中所有的substring替换为指定UIFont
 */
- (void)addFont:(UIFont *)font allSubstring:(NSString *)substring;
- (void)addFont:(UIFont *)font range:(NSRange)range;
- (void)addAlignment:(NSTextAlignment)alignment substring:(NSString *)substring;
/** 添加自定义NSMutableParagraphStyle类型 @param style NSMutableParagraphStyle */
- (void)addParagraphStyle:(NSMutableParagraphStyle *)style substring:(NSString *)substring;

/**
 添加自定义NSMutableParagraphStyle类型
 @param style NSMutableParagraphStyle
 */
- (void)addParagraphStyle:(NSMutableParagraphStyle *)style;

- (void)addColorToRussianText:(UIColor *)color;
- (void)addStrokeColor:(UIColor *)color thickness:(int)thickness substring:(NSString *)substring;
- (void)addVerticalGlyph:(BOOL)glyph substring:(NSString *)substring;
@end

@interface NSString (Russian)
- (BOOL)hasRussianCharacters;
- (BOOL)hasEnglishCharacters;
@end
