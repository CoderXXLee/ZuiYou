//
//  NSMutableURLRequest+Multipart.h
//  CallCar
//
//  Created by MaoBing Ran on 15/11/8.
//  Copyright © 2015年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (Multipart)
/**
 url: 要上传的服务器的地址
 loaclFilePath: 要上传的文件的全路径
 fileName：保存到服务器的文件名
 */
+ (instancetype)requestWithURL:(NSURL *)url andLoaclFilePath:(NSString *)loaclFilePath andFileName:(NSString *)fileName;
@end
