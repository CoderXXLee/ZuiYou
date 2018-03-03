//
//  CNContact+LE.m
//  CreditAddressBook
//
//  Created by Lee on 15/9/24.
//  Copyright © 2015年 Lee. All rights reserved.
//

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000

#import "CNContact+LE.h"

@implementation CNContact (LE)

- (NSString *)name {
    return [CNContactFormatter stringFromContact:self style:CNContactFormatterStyleFullName];
}

- (NSArray *)phones {
    NSMutableArray *arr = [NSMutableArray array];
    for (CNLabeledValue *value in self.phoneNumbers) {
        CNPhoneNumber *phoneNumber = value.value;
        [arr addObject:[self formatPhoneNumber:phoneNumber.stringValue]];
    }
    return arr;
}

/*!
 *  @brief  格式化电话号码
 */
- (NSString *)formatPhoneNumber:(NSString *)formatePhone {
    if ([formatePhone rangeOfString:@"-"].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    if ([formatePhone rangeOfString:@"("].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@"(" withString:@""];
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    if ([formatePhone rangeOfString:@"·"].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@"·" withString:@""];
    }
    if ([formatePhone rangeOfString:@" "].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if ([formatePhone rangeOfString:@" "].length) {//\u00A0空格
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    if ([formatePhone rangeOfString:@"+86"].length) {
        formatePhone = [formatePhone stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    }
    if (formatePhone.length > 20) {
        formatePhone = [formatePhone substringToIndex:12];
    }
    return formatePhone;
}
@end

#endif
