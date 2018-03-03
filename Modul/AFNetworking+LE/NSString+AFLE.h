//
//  NSString+AFLE.h
//  Pods
//
//  Created by mac on 2017/3/29.
//
//

#import <Foundation/Foundation.h>

@interface NSString (AFLE)

- (BOOL)isEmpty;

/*!
 *  jsonStr转NSDictionary
 */
- (NSDictionary *)jsonStringToDictionary;
@end
