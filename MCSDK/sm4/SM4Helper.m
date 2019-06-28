//
//  SM4Helper.m
//  MediaCloud
//
//  Created by 曹舸 on 2019/6/20.
//  Copyright © 2019  TRS. All rights reserved.
//

#import "SM4Helper.h"
#import "sm4test.h"
#import "sms4.h"

@implementation SM4Helper

+ (NSData *)SM4EncodeWithStr:(NSString * _Nonnull)str{
    
    NSData *plainInData =[str dataUsingEncoding:NSUTF8StringEncoding];
    long plainInDataLength =plainInData.length;
    int p = 16 - plainInDataLength % 16;
    unsigned char plainInChar[plainInDataLength + p];
    memcpy(plainInChar, plainInData.bytes, plainInDataLength);
    for (int i = 0; i < p; i++) {
        plainInChar[plainInDataLength + i] =  p;
    }
    unsigned char cipherOutChar[plainInDataLength + p];
    testEncodejiami(plainInDataLength + p, plainInChar, cipherOutChar);
    NSData *cipherTextData =  [[NSData alloc]initWithBytes:cipherOutChar length:sizeof(cipherOutChar)];
    //NSLog(@"密文NSData=%@",cipherTextData);

    return cipherTextData;
}

+ (NSData *)SM4EncodeWithDic:(NSDictionary * _Nonnull)dic{
    
    NSString *plainIn = [self changeDicToStrAsSM4Type:dic];
    NSData *plainInData =[plainIn dataUsingEncoding:NSUTF8StringEncoding];
    long plainInDataLength =plainInData.length;
    int p = 16 - plainInDataLength % 16;
    unsigned char plainInChar[plainInDataLength + p];
    memcpy(plainInChar, plainInData.bytes, plainInDataLength);
    for (int i = 0; i < p; i++) {
        plainInChar[plainInDataLength + i] =  p;
    }
    unsigned char cipherOutChar[plainInDataLength + p];
    testEncodejiami(plainInDataLength + p, plainInChar, cipherOutChar);
    //对加密的数据输出
    NSData *cipherTextData =  [[NSData alloc]initWithBytes:cipherOutChar length:sizeof(cipherOutChar)];
    //NSLog(@"密文NSData=%@",cipherTextData);
    
    return cipherTextData;
}

+ (NSString *)SM4DecodeWithData:(NSData * _Nonnull)data{

    unsigned char cipherTextChar[data.length];
    memcpy(cipherTextChar, data.bytes, data.length);
    //调用解密方法，输出是明文plainOutChar
    unsigned char plainOutChar[data.length];
    testDecodejiemi(data.length, cipherTextChar, plainOutChar);
    //由于明文是填充过的，解密时候要去填充，去填充要在解密后才可以，在解密前是去不了的
    int p2 = plainOutChar[sizeof(plainOutChar) - 1];//p2是填充的数据，也是填充的长度
    int outLength = data.length-p2;//明文的长度
    //去掉填充得到明文
    unsigned char plainOutWithoutPadding[outLength];
    memcpy(plainOutWithoutPadding, plainOutChar, outLength);
    //明文转成NSData 再转成NSString打印
    NSData *outData = [[NSData alloc]initWithBytes:plainOutWithoutPadding length:sizeof(plainOutWithoutPadding)];
    
    NSString *str =[[NSString alloc]initWithData:outData encoding:NSUTF8StringEncoding];
    //NSLog(@"解密得到的明文是:%@",str);
    
    return str;
}

+ (NSString *)changeSM4DataToStr:(NSData * _Nonnull)data{
    
    NSString *deStr =[NSString stringWithFormat:@"%@",data];
    deStr = [deStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    deStr = [deStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deStr = [deStr stringByReplacingOccurrencesOfString:@">" withString:@""];
    return deStr;
}

+ (NSString *)changeDicToStrAsSM4Type:(NSDictionary * _Nonnull)dic{
    
    NSString *plainIn = [self dictionaryToJSONString:dic];
    plainIn = [plainIn stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    plainIn = [plainIn stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    plainIn = [plainIn stringByReplacingOccurrencesOfString:@" : " withString:@"="];
    plainIn = [plainIn stringByReplacingOccurrencesOfString:@" " withString:@""];
    plainIn = [plainIn stringByReplacingOccurrencesOfString:@"{" withString:@""];
    plainIn = [plainIn stringByReplacingOccurrencesOfString:@"}" withString:@""];
    plainIn = [plainIn stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    
    return plainIn;
}

+ (NSData *)hexStringToByte:(NSString * _Nonnull)hexString
{
    hexString=[[hexString uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0)
    {
        return nil;
    }
    
    Byte tmpByt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i = 0; i < [hexString length]; i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i];
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16;
        else
            return nil;
        
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i];
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48);
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55;
        else
            return nil;
        
        tmpByt[0] = int_ch1+int_ch2;
        [bytes appendBytes:tmpByt length:1];
    }
    
    return bytes;
}

+ (NSDictionary *)convertjsonStringToDict:(NSString * _Nonnull)jsonString{
    
    NSDictionary *retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }
}

+ (NSString *)dictionaryToJSONString:(NSDictionary * _Nonnull)dictionary {
    
    NSString *jsonString = nil;
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
    if(error) {
        //NSLog(@"字典转化为JSON字符串错误: %@", error.localizedDescription);
    }
    else {
        jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

@end
