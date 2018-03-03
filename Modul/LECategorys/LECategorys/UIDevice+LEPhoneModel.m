//
//  UIDevice+LEPhoneModel.m
//  Pods
//
//  Created by mac on 2017/8/9.
//
//

#import "UIDevice+LEPhoneModel.h"
#import <sys/utsname.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation UIDevice (LEPhoneModel)

/**
 手机型号
 */
- (NSString *)iphoneModel {
    struct utsname systemInfo;
    uname(&systemInfo);

    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];

    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";

    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";

    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";

    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";

    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";

    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";

    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";

    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";

    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";

    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";

    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";

    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";

    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";

    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";

    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";

    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";

    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";

    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";

    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";

    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";

    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";

    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";

    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";

    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";

    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";

    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";

    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";

    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";

    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";

    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";

    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";

    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";

    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";

    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";

    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";

    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";

    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";

    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    return platform;
}

/**
 获取手机型号
 */
+ (NSString *)deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    static NSDictionary *mapping;
    if (!mapping) {
        mapping = @{
                    //iPhone
                    @"iPhone1,1":@"iPhone 1G",
                    @"iPhone1,2":@"iPhone 3G",
                    @"iPhone2,1":@"iPhone 3GS",
                    @"iPhone3,1":@"iPhone 4",
                    @"iPhone3,2":@"Verizon iPhone 4",
                    @"iPhone3,3":@"iPhone 4",
                    @"iPhone4,1":@"iPhone 4S",
                    @"iPhone5,1":@"iPhone 5",
                    @"iPhone5,2":@"iPhone 5",
                    @"iPhone5,3":@"iPhone 5C",
                    @"iPhone5,4":@"iPhone 5C",
                    @"iPhone6,1":@"iPhone 5S",
                    @"iPhone6,2":@"iPhone 5S",
                    @"iPhone7,1":@"iPhone 6 Plus",
                    @"iPhone7,2":@"iPhone 6",
                    @"iPhone8,1":@"iPhone 6s",
                    @"iPhone8,2":@"iPhone 6s Plus",
                    @"iPhone8,4":@"iPhone SE",
                    @"iPhone9,1":@"iPhone 7 (A1549/A1586)",
                    @"iPhone9,2":@"iPhone 7 Plus (A1549/A1586)",
                    
                    //iPod
                    @"iPod1,1":@"iPod Touch 1G",
                    @"iPod2,1":@"iPod Touch 2G",
                    @"iPod3,1":@"iPod Touch 3G",
                    @"iPod4,1":@"iPod Touch 4G",
                    @"iPod5,1":@"iPod Touch 5G",
                    
                    //iPad
                    @"iPad1,1":@"iPad",
                    @"iPad2,1":@"iPad 2 (WiFi)",
                    @"iPad2,2":@"iPad 2 (GSM)",
                    @"iPad2,3":@"iPad 2 (CDMA)",
                    @"iPad2,4":@"iPad 2 (32nm)",
                    @"iPad2,5":@"iPad mini (WiFi)",
                    @"iPad2,6":@"iPad mini (GSM)",
                    @"iPad2,7":@"iPad mini (CDMA)",
                    @"iPad3,1":@"iPad 3",
                    @"iPad3,2":@"iPad 3",
                    @"iPad3,3":@"iPad 3",
                    @"iPad3,4":@"iPad 4",
                    @"iPad3,5":@"iPad 4",
                    @"iPad3,6":@"iPad 4",
                    @"iPad4,1":@"iPad Air",
                    @"iPad4,2":@"iPad Air",
                    @"iPad4,3":@"iPad Air",
                    @"iPad4,4":@"iPad Mini 2G",
                    @"iPad4,5":@"iPad Mini 2G",
                    @"iPad4,6":@"iPad Mini 2G",

                    //Simulator
                    @"i386":@"iPhone Simulator",
                    @"x86_64":@"iPhone Simulator",

                    //Apple TV
                    @"AppleTV5,3":@"Apple TV"
                    };
    }
    if (mapping[deviceString]) {
        return mapping[deviceString];
    }
    return @"NONE";
}

/**
 获取与当前APP关联的设备唯一标识符
 获取设备UUID后存入keyChain中
 uuid并不唯一，但也是目前用的最多的唯一标识符，我们可以将其存入钥匙串中，以保证用户在卸载或升级系统时仍保证其唯一性。
 */
+ (NSString *)getDeviceUUID {
    ///以APP的的BundleID作为key，以保证唯一性
    NSString *UUIDKEY = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    if ([self load:UUIDKEY]) {
        NSString *result = [self load:UUIDKEY];
        return result;
    } else {
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);

        NSMutableString * tmpResult = result.mutableCopy;
        NSRange range = [tmpResult rangeOfString:@"-"];

        while (range.location != NSNotFound) {
            [tmpResult deleteCharactersInRange:range];

            range = [tmpResult rangeOfString:@"-"];
        }
        [self save:UUIDKEY data:tmpResult.copy];

        return tmpResult.copy;
    }
    return nil;
}

/**
 00	中国移动
 01	中国联通
 02	中国移动
 03	中国电信
 05	中国电信
 06	中国联通
 07	中国移动
 20	中国铁通
 */
+ (void)getCarrierName {
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
//    NSString *currentCountry = [carrier carrierName];
    NSLog(@"[carrier isoCountryCode]==%@,[carrier allowsVOIP]=%d,[carrier mobileCountryCode=%@,[carrier mobileCountryCode]=%@",[carrier isoCountryCode],[carrier allowsVOIP],[carrier mobileCountryCode],[carrier mobileNetworkCode]);
}

#pragma mark - Keychain

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

@end
