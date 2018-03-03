//
//  CNContact+LE.h
//  CreditAddressBook
//
//  Created by Lee on 15/9/24.
//  Copyright © 2015年 Lee. All rights reserved.
//

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
//#if IS_IOS9
#import <Contacts/Contacts.h>

@interface CNContact (LE)

@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSArray *phones;
@end

#endif
