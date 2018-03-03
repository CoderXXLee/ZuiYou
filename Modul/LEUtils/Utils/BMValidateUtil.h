//
//  BMValidateUtil.h
//  Pods
//
//  Created by mac on 2017/8/2.
//
//

#import <Foundation/Foundation.h>

@interface BMValidateUtil : NSObject

/**
 验证邮箱
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 验证电话号码（包含固话，手机号）
 */
+ (BOOL)isValidateContactNumber:(NSString *)mobileNum;

/**
 判断输入的身份证格式是否正确
 */
+ (BOOL)isValidIDNumber:(NSString *)IDNumber;

/**
 判断银行卡的合法性
 */
+ (BOOL)isValidCardNumber:(NSString *)cardNumber;

/**
 判断银行卡 截取数据
 */
+ (BOOL)bankCardWithTextfield:(UITextField *)textField String:(NSString *)string range:(NSRange)range;

/**
 获取银行卡银行名
 */
+ (NSString *)getBankName:(NSString *)cardId;

@end
