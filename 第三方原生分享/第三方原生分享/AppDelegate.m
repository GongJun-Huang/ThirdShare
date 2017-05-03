//
//  AppDelegate.m
//  第三方原生分享
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 Jim. All rights reserved.
//

#import "AppDelegate.h"
#import "ShareModel.h"

//微信api
#import "WXApi.h"

//微博
#import <WeiboSDK.h>

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [ShareModel registerAll];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark 需要实现两个回调方法
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
//    return [TencentOAuth HandleOpenURL:url];
    return [ShareModel handleOpenURL:url delegate:self];
}
//
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    return [ShareModel handleOpenURL:url delegate:self];
}

#pragma mark 微博需要实现系统的这个回调方法
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [ShareModel handleOpenURL:url delegate:self];
}


#pragma mark 两个微博的回调，要实现
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    
}

#pragma mark 微信的回调
-(void)onReq:(BaseReq*)req{
    
    NSLog(@"%@",req);
}


@end
