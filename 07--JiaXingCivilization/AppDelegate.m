//
//  AppDelegate.m
//  07--JiaXingCivilization
//
//  Created by dc007 on 16/6/22.
//  Copyright © 2016年 NSObject. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import "ShareViewController.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"

@interface AppDelegate ()
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.初始化ShareSDK应用,字符串"5559f92aa230"换成http://www.mob.com/后台申请的ShareSDK应用的Appkey
    [ShareSDK registerApp:@"5559f92aa230"];
    
    ShareViewController *share = [[ShareViewController alloc] init];
    [share.shareButton setTitle:@"分享" forState:UIControlStateNormal];

    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"
                             weiboSDKCls:[WeiboSDK class]];

    
    return YES;
}

@end
