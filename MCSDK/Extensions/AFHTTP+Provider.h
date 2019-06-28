//
//  AFHTTP+Provider.h
//  TRSMobileV2
//
//  Created by  TRS on 16/3/16.
//  Copyright © 2016年  TRS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^progress)(float progress);
typedef void (^completion)(BOOL success, id _Nullable response, NSError * _Nullable error);

@interface AFHTTP : NSObject

/**
 * @brief 根据url地址请求数据
 * @param url : 请求url地址
 * @param method : 数据方式，在如下常用的GET、POST中选择，默认为GET
 * @param parameters : 传入POST body的参数, 需为NSDictionary类型
 * @param progress : 进度回调
 * @param completion : 回调函数
 */

+ (void)SM4request:(NSString * _Nonnull)url
            method:(NSString * _Nonnull)method
        parameters:(NSDictionary * _Nullable)parameters
          progress:(progress _Nullable)progress
        completion:(completion _Nullable)completion;
@end
