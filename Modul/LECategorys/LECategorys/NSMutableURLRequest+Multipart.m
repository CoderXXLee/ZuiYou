//
//  NSMutableURLRequest+Multipart.m
//  CallCar
//
//  Created by MaoBing Ran on 15/11/8.
//  Copyright © 2015年 com. All rights reserved.
//

#import "NSMutableURLRequest+Multipart.h"
/**随便的字符串作为分隔符*/
static NSString *boundary = @"ccupload";


@implementation NSMutableURLRequest (Multipart)

+ (instancetype)requestWithURL:(NSURL *)url andLoaclFilePath:(NSString *)loaclFilePath andFileName:(NSString *)fileName
{
    // 2. post请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:2.0f];
    // 2.1 指定post方法
    request.HTTPMethod = @"POST";
    
    // 2.2 拼接数据体
    NSMutableData *dataM = [NSMutableData data];
    
    //   1. \r\n--(可以随便写, 但是不能有中文)\r\n
    NSString *str = [NSString stringWithFormat:@"\r\n--%@\r\n", boundary];
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //   2. Content-Disposition: form-data; name="userfile(php脚本中用来读取文件的字段)"; filename="demo.json(要保存到服务器的文件名)"
    
    str = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@\" \r\n", fileName];
    
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //   3. Content-Type: application/octet-stream(上传文件的类型)\r\n\r\n
    str = @"Content-Type: application/octet-stream\r\n\r\n";
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //   4. 要上传的文件的二进制流
    // 要上传图片的二进制
    [dataM appendData:[NSData dataWithContentsOfFile:loaclFilePath]];
    
    //   5. \r\n--(可以随便写, 但是不能有中文)--\r\n
    str = [NSString stringWithFormat:@"\r\n--%@--\r\n", boundary];
    [dataM appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 2.4 设置请求体
    request.HTTPBody = dataM;
    
    // 设置请求头
    //    Content-Length(文件的大小)	290
    //    Content-Type	multipart/form-data; boundary(分隔符)=(可以随便写, 但是不能有中文)
    
    NSString *headerStr = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request setValue:headerStr forHTTPHeaderField:@"Content-Type"];
    
    return request;
}


@end
