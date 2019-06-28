//
//  MCSDK.m
//  MediaCloud
//
//  Created by  TRS on 2019/6/27.
//  Copyright © 2019  TRS. All rights reserved.
//

#import "MCSDK.h"
#import "SM4Helper.h"
#import "AFHTTP+Provider.h"

@interface MCSDK ()

// 采编服务地址
@property (nonatomic, strong) NSString *mcUrl;

@end

@implementation MCSDK

/**
 * @brief MCSDK单例
 */
+ (instancetype)sharedInsatnce {
    
    static MCSDK *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MCSDK alloc] init];
    });
    return instance;
}

/**
 * @brief 注册MCSDK组件服务
 * @param url 采编地址
 */
+ (void)initMCSDKWithUrl:(NSString *)url {
    
    [MCSDK sharedInsatnce].mcUrl = url;
}

/**
 * @brief 获取栏目数
 * @param siteId 站点Id
 * @param completion 操作结果回调
 */
+ (void)getChannelsBySiteId:(NSInteger)siteId
                 completion:(void(^)(BOOL success, NSDictionary* ressponse, NSError *error))completion {
    
    NSString *url = [[MCSDK sharedInsatnce].mcUrl stringByAppendingPathComponent:@"appmedia/getChannelsBySiteId"];
    NSDictionary *params = @{@"siteId" : @(siteId)};
    
    [AFHTTP SM4request:url method:@"POST" parameters:params progress:nil completion:^(BOOL success, id  _Nullable response, NSError * _Nullable error) {
        
    }];
}

/**
 * @brief 获取栏目列表
 * @param pageNo 当前页数
 * @param pageSize 页数大小
 * @param completion 操作结果回调
 */
+ (void)getChnlDocs:(NSInteger)channelId
             pageNo:(NSInteger)pageNo
           pageSize:(NSInteger)pageSize
         completion:(void(^)(BOOL success, NSDictionary* ressponse, NSError *error))completion {
 
    NSString *url = [[MCSDK sharedInsatnce].mcUrl stringByAppendingPathComponent:@"appmedia/getChnlDocs"];
    NSDictionary *params = @{@"channelId" : @(channelId),
                             @"pageNo" : @(pageNo),
                             @"pageSize" : @(pageSize)};
    
    [AFHTTP SM4request:url method:@"POST" parameters:params progress:nil completion:^(BOOL success, id  _Nullable response, NSError * _Nullable error) {
        
    }];
}

/**
 * @brief 获取稿件详情
 * param docId 稿件ID
 * @param completion 操作结果回调
 */
+ (void)getDocument:(NSInteger)docId
         completion:(void(^)(BOOL success, NSDictionary* ressponse, NSError *error))completion {
    
    NSString *url = [[MCSDK sharedInsatnce].mcUrl stringByAppendingPathComponent:@"appmedia/getDocument"];
    NSDictionary *params = @{@"docId" : @(docId)};
    
    [AFHTTP SM4request:url method:@"POST" parameters:params progress:nil completion:^(BOOL success, id  _Nullable response, NSError * _Nullable error) {
        
    }];
}

@end
