//
//  AppDelegate.m
//  易交流
//
//  Created by Kael on 16/6/14.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initRCloudData];
    return YES;
}


-(void)getRCloudTokenWithParamDic:(NSDictionary *)paramDic andSuccessBlock:(void(^)(NSString *RToken))successBlock{

    [[RCIM sharedRCIM] initWithAppKey:RCloud_App_Key];
    
    AFHTTPSessionManager *nManage = [AFHTTPSessionManager manager];
    
    nManage.responseSerializer = [AFHTTPResponseSerializer serializer];
    //  ***************  随机数，无长度限制
    NSString *Nonce = [NSString stringWithFormat:@"%d",arc4random()];
    //  **************  以1970/01/01 GMT为基准时间，返回实例保存的时间与1970/01/01 GMT的时间间隔
    NSDate *dateObc = [NSDate date];
    NSString *Timestamp = [NSString stringWithFormat:@"%d",(int)[dateObc timeIntervalSince1970]];
    //  **************  将系统分配的 AppSecret、Nonce (随机数)、Timestamp (时间戳)三个字符串按先后顺序拼接成一个字符串并进行 SHA1哈希计算
    NSString *Signature = [self sha1:[NSString stringWithFormat:@"%@%@%@",RCloud_App_Secret,Nonce,Timestamp]];
    
    //    每次请求 API接口时，均需要提供 4个 HTTP Request Header
    [nManage.requestSerializer setValue:RCloud_App_Key forHTTPHeaderField:@"App-Key"];
    [nManage.requestSerializer setValue:Nonce forHTTPHeaderField:@"Nonce"];
    [nManage.requestSerializer setValue:Timestamp forHTTPHeaderField:@"Timestamp"];
    [nManage.requestSerializer setValue:Signature forHTTPHeaderField:@"Signature"];
    
    nManage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"multipart/form-data",@"text/json",@"text/javascript",@"ication/json", nil];
    //    表单参数
    
//    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
//    parameter[@"userId"] =@"10101011";
//    parameter[@"name"] =@"张三";
//    parameter[@"portraitUri"] =@"https://www.baidu.com/img/baidu_jgylogo3.gif";
    
    [nManage POST:@"https://api.cn.rong.io/user/getToken.json" parameters:paramDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"-----UserInfomation---%@",dic);
        
        NSString *myToken = [dic objectForKey:@"token"];
        successBlock(myToken);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    

}
-(void)initRCloudData{
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"userId"] =@"10101013";
    parameter[@"name"] =@"李四";
    parameter[@"portraitUri"] =@"https://www.baidu.com/img/baidu_jgylogo3.gif";
    
    [self getRCloudTokenWithParamDic:parameter andSuccessBlock:^(NSString *RToken) {
        NSLog(@"我获取token成功了！----------%@",RToken);
        //获取token令牌
        [[RCIM sharedRCIM] connectWithToken:RToken success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    }];
    
    return;

//    [[RCIM sharedRCIM] initWithAppKey:RCloud_App_Key];
//    
//    AFHTTPSessionManager *nManage = [AFHTTPSessionManager manager];
//
//    nManage.responseSerializer = [AFHTTPResponseSerializer serializer];
//    //  ***************  随机数，无长度限制
//    NSString *Nonce = [NSString stringWithFormat:@"%d",arc4random()];
//    //  **************  以1970/01/01 GMT为基准时间，返回实例保存的时间与1970/01/01 GMT的时间间隔
//    NSDate *dateObc = [NSDate date];
//    NSString *Timestamp = [NSString stringWithFormat:@"%d",(int)[dateObc timeIntervalSince1970]];
//    //  **************  将系统分配的 AppSecret、Nonce (随机数)、Timestamp (时间戳)三个字符串按先后顺序拼接成一个字符串并进行 SHA1哈希计算
//    NSString *Signature = [self sha1:[NSString stringWithFormat:@"%@%@%@",RCloud_App_Secret,Nonce,Timestamp]];
//    
//    //    每次请求 API接口时，均需要提供 4个 HTTP Request Header
//    [nManage.requestSerializer setValue:RCloud_App_Key forHTTPHeaderField:@"App-Key"];
//    [nManage.requestSerializer setValue:Nonce forHTTPHeaderField:@"Nonce"];
//    [nManage.requestSerializer setValue:Timestamp forHTTPHeaderField:@"Timestamp"];
//    [nManage.requestSerializer setValue:Signature forHTTPHeaderField:@"Signature"];
//
//    nManage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"multipart/form-data",@"text/json",@"text/javascript",@"ication/json", nil];
//    //    表单参数
//    
//    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
//    parameter[@"userId"] =@"10101011";
//    parameter[@"name"] =@"张三";
//    parameter[@"portraitUri"] =@"https://www.baidu.com/img/baidu_jgylogo3.gif";
//    
//    [nManage POST:@"https://api.cn.rong.io/user/getToken.json" parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        NSLog(@"-----UserInfomation---%@",dic);
//       
//        NSString *myToken = [dic objectForKey:@"token"];
//        
//        //获取token令牌
//        [[RCIM sharedRCIM] connectWithToken:myToken success:^(NSString *userId) {
//            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
//        } error:^(RCConnectErrorCode status) {
//            NSLog(@"登陆的错误码为:%ld", (long)status);
//        } tokenIncorrect:^{
//            //token过期或者不正确。
//            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
//            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
//            NSLog(@"token错误");
//        }];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//
//    }];
    
}


/*使用下面方法需要导入 CommonCrypto/CommonDigest.h*/
//  哈希计算
- (NSString *) sha1:(NSString *)input
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
