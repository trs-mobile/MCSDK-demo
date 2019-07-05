//
//  AFHTTP+Provider.m
//  TRSMobileV2
//
//  Created by  TRS on 16/3/16.
//  Copyright © 2016年  TRS. All rights reserved.
//

#import "SM4HTTP.h"

@implementation SM4HTTP

/**
 * 根据url地址请求数据 (真正从服务器请求获取数据)
 * @param url : 请求url地址
 * @param parameters : 传入POST body的参数，需为NSDictionary类型
 * @param completion : 回调函数
 */

+ (void)request:(NSString * _Nonnull)url
     parameters:(NSDictionary * _Nullable)parameters
     completion:(completion _Nullable)completion
{
    //url编码，处理请求中含有中文字符
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    // 请求body参数
    NSString *body = [NSString stringWithFormat:@"data=%@", [SM4Helper changeSM4DataToStr:[SM4Helper SM4EncodeWithDic:parameters]]];
    
    // 发起请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] ];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 60;
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            
            //NSLog(@"请求失败 : %@ --> %@", url, error.localizedDescription);
            if(completion) {completion(NO, nil, error);}
        }
        else {

            //NSLog(@"请求成功 : %@ --> %ld", url, ((NSHTTPURLResponse *)task.response).statusCode);
            NSString *strEncode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *response = [SM4Helper convertjsonStringToDict:[SM4Helper SM4DecodeWithData: [SM4Helper hexStringToByte:strEncode]]];
            if(completion) {completion(YES, response, nil);}
        }
        
    }];
    
    [task resume];
}

@end
