//
//  KTool.h
//  易交流
//
//  Created by Kael on 16/6/18.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import <Foundation/Foundation.h>
//哈希算法 必需
#import "CommonCrypto/CommonDigest.h"

@interface KTool : NSObject
/**
 *  @author Kael
 *
 *  @brief 哈希算法
 *  @param input 输入参数
 *  @return 输出哈希结果
 */
+ (NSString *) sha1:(NSString *)input;




-(void)getRCloudTokenWithParamDic:(NSDictionary *)paramDic andSuccessBlock:(void(^)(NSDictionary *paramDic))sucessBlock;




@end
