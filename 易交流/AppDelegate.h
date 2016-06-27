//
//  AppDelegate.h
//  易交流
//
//  Created by Kael on 16/6/14.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import <RongIMKit/RongIMKit.h>
#import "CommonCrypto/CommonDigest.h"
#import "KTool.h"


#define RCloud_App_Key      @"4z3hlwrv3kudt"
#define RCloud_App_Secret   @"wY7VVYAGNwwaB"
#define RCloud_getToken_url @"https://api.cn.rong.io/user/getToken.json"
#define RCloud_KeFu_ID      @"KEFU146633202455070"



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

