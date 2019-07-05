//
//  AFHTTP+Provider.h
//  TRSMobileV2
//
//  Created by  TRS on 16/3/16.
//  Copyright © 2016年  TRS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "SM4Helper.h"

typedef void (^completion)(BOOL success, id _Nullable response, NSError * _Nullable error);

@interface SM4HTTP : NSObject

/**
 * @brief 根据url地址请求数据
 * @param url : 请求url地址
 * @param parameters : 传入POST body的参数, 需为NSDictionary类型
 * @param completion : 回调函数
 */

+ (void)request:(NSString * _Nonnull)url
    parameters:(NSDictionary * _Nullable)parameters
    completion:(completion _Nullable)completion;

@end
