//
//  UIDevice+LEPhoneModel.h
//  Pods
//
//  Created by mac on 2017/8/9.
//
//

#import <UIKit/UIKit.h>

#define IFPGA_NAMESTRING                @"iFPGA"

#define IPHONE_1G_NAMESTRING            @"iPhone 1G"
#define IPHONE_3G_NAMESTRING            @"iPhone 3G"
#define IPHONE_3GS_NAMESTRING           @"iPhone 3GS"
#define IPHONE_4_NAMESTRING             @"iPhone 4"
#define IPHONE_4S_NAMESTRING            @"iPhone 4S"
#define IPHONE_5_NAMESTRING             @"iPhone 5"
#define IPHONE_5c_NAMESTRING            @"iPhone 5C"
#define IPHONE_5s_NAMESTRING            @"iPhone 5S"
#define IPHONE_6_NAMESTRING             @"iPhone 6"
#define IPHONE_6P_NAMESTRING            @"iPhone 6 Plus"
#define IPHONE_SE_NAMESTRING            @"iPhone SE"
#define IPHONE_6s_NAMESTRING            @"iPhone 6s"
#define IPHONE_6sP_NAMESTRING           @"iPhone 6s Plus"
#define IPHONE_7_NAMESTRING             @"iPhone 7 (A1549/A1586)"
#define IPHONE_7P_NAMESTRING            @"iPhone 7 Plus (A1549/A1586)"
#define IPHONE_UNKNOWN_NAMESTRING       @"Unknown iPhone"

#define IPOD_1G_NAMESTRING              @"iPod touch 1G"
#define IPOD_2G_NAMESTRING              @"iPod touch 2G"
#define IPOD_3G_NAMESTRING              @"iPod touch 3G"
#define IPOD_4G_NAMESTRING              @"iPod touch 4G"
#define IPOD_UNKNOWN_NAMESTRING         @"Unknown iPod"

#define IPAD_1G_NAMESTRING              @"iPad 1G"
#define IPAD_2G_NAMESTRING              @"iPad 2G"
#define IPAD_3G_NAMESTRING              @"iPad 3G"
#define IPAD_4G_NAMESTRING              @"iPad 4G"
#define IPAD_UNKNOWN_NAMESTRING         @"Unknown iPad"

#define APPLETV_2G_NAMESTRING           @"Apple TV 2G"
#define APPLETV_3G_NAMESTRING           @"Apple TV 3G"
#define APPLETV_4G_NAMESTRING           @"Apple TV 4G"
#define APPLETV_UNKNOWN_NAMESTRING      @"Unknown Apple TV"

#define IOS_FAMILY_UNKNOWN_DEVICE       @"Unknown iOS device"

#define SIMULATOR_NAMESTRING            @"iPhone Simulator"
#define SIMULATOR_IPHONE_NAMESTRING     @"iPhone Simulator"
#define SIMULATOR_IPAD_NAMESTRING       @"iPad Simulator"
#define SIMULATOR_APPLETV_NAMESTRING    @"Apple TV Simulator" // :)

@interface UIDevice (LEPhoneModel)

/**
 获取手机型号
 */
+ (NSString *)deviceModel;

/**
 获取与当前APP关联的设备唯一标识符
 获取设备UUID后存入keyChain中
 uuid并不唯一，但也是目前用的最多的唯一标识符，我们可以将其存入钥匙串中，以保证用户在卸载或升级系统时仍保证其唯一性。
 */
+ (NSString *)getDeviceUUID;

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
+ (void)getCarrierName;

@end
