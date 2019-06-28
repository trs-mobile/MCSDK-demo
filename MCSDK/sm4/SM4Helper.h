//
//  SM4Helper.h
//  MediaCloud
//
//  Created by 曹舸 on 2019/6/20.
//  Copyright © 2019  TRS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SM4Helper : NSObject

+ (NSData *)SM4EncodeWithDic:(NSDictionary * _Nonnull)dic;
+ (NSString *)SM4DecodeWithData:(NSData * _Nonnull)data;
+ (NSString *)changeSM4DataToStr:(NSData * _Nonnull)data;
+ (NSData *)hexStringToByte:(NSString* _Nonnull)hexString;
+ (NSDictionary *)convertjsonStringToDict:(NSString * _Nonnull)jsonString;

@end

NS_ASSUME_NONNULL_END
