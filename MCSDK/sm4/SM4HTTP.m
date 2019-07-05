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
    NSDictionary *__parameters = @{@"data":[SM4Helper changeSM4DataToStr:[SM4Helper SM4EncodeWithDic:parameters]]};

    //请求数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    manager.responseSerializer = [AFHTTPResponseSerializer new];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/html",
                                                         @"text/plain",
                                                         @"application/xml",
                                                         @"text/xml", nil];
    
    id __success = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //NSLog(@"请求成功 : %@ --> %ld", task.response.URL.absoluteString, ((NSHTTPURLResponse *)task.response).statusCode);

        NSString *strEncode = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *response = [SM4Helper convertjsonStringToDict:[SM4Helper SM4DecodeWithData: [SM4Helper hexStringToByte:strEncode]]];
        
        if(completion) {completion(YES, response, nil);}
    };
    
    id __failure = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //NSLog(@"请求失败 : %@ --> %@", (task.response.URL.absoluteString ? : url), error.localizedDescription);
        
        if(completion) {completion(NO, nil, error);}
    };
    
    //Creates and runs an `NSURLSessionDataTask` with a `POST` request.
    [manager POST:url
       parameters:__parameters
         progress:nil
          success:__success
          failure:__failure];
}

@end