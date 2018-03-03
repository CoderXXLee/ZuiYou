//
//  LEUUID.m
//  CreditAddressBook
//
//  Created by Lee on 15/7/30.
//  Copyright (c) 2015年 Lee. All rights reserved.
//

#import "LEUUID.h"
@import UIKit;

@interface LEUUID ()

@property (strong, nonatomic) NSString *uuidForSession;
@end

@implementation LEUUID

- (NSString *)uuidForSession {
    if( _uuidForSession == nil ){
        _uuidForSession = [self uuid];
    }
    return _uuidForSession;
}

+ (LEUUID *)sharedInstance {
    static LEUUID *instance = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (NSString *)uuid {
//    NSString *uuidValue = [NSUUID UUID].UUIDString;
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    
    NSString *uuidValue = (__bridge_transfer NSString *)uuidStringRef;
    uuidValue = [uuidValue lowercaseString];
//    uuidValue = [uuidValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuidValue;
}

- (NSString *)uuidForVendor {
    NSString *uuid = [[[[UIDevice currentDevice] identifierForVendor] UUIDString] lowercaseString];
//    uuid = [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return uuid;
    
}

- (BOOL)uuidValueIsValid:(NSString *)uuidValue {
    return (uuidValue != nil && (uuidValue.length == 32 || uuidValue.length == 36));
}

+ (NSString *)UUID {
    return [[self sharedInstance] uuid];
}


+ (NSString *)UUIDForSession {
    return [self sharedInstance].uuidForSession;
}

+ (NSString *)UUIDForVendor {
    return [[self sharedInstance] uuidForVendor];
}
@end
