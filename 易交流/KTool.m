//
//  KTool.m
//  易交流
//
//  Created by Kael on 16/6/18.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import "KTool.h"

@implementation KTool

/*使用下面方法需要导入 CommonCrypto/CommonDigest.h*/
//  哈希计算
+ (NSString *) sha1:(NSString *)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end
