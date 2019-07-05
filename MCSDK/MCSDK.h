//
//  MCSDK.h
//  MediaCloud
//
//  Created by  TRS on 2019/6/27.
//  Copyright © 2019  TRS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCSDK : NSObject

/**
 * @brief 注册MCSDK组件服务
 * @param url 采编地址
 */
+ (void)initMCSDKWithUrl:(NSString *)url;

/**
 * @brief 获取栏目数
 * @param siteId 站点ID
 * @param completion 操作结果回调
 */
+ (void)getChannelsBySiteId:(NSInteger)siteId
                 completion:(void(^)(BOOL success, NSDictionary* response, NSError *error))completion;

/**
 * @brief 获取栏目列表
 * @param pageNo 当前页数
 * @param pageSize 页数大小
 * @param completion 操作结果回调
 */
+ (void)getChnlDocs:(NSInteger)channelId
             pageNo:(NSInteger)pageNo
           pageSize:(NSInteger)pageSize
         completion:(void(^)(BOOL success, NSDictionary* response, NSError *error))completion;

/**
 * @brief 获取稿件详情
 * param docId 稿件ID
 * @param completion 操作结果回调
 */
+ (void)getDocument:(NSInteger)docId
         completion:(void(^)(BOOL success, NSDictionary* response, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
