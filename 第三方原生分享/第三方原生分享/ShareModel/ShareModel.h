//
//  ShareModel.h
//  Test
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ShareType)
{
    ShareTypeWechatSession = 0,      //微信聊天
    ShareTypeWechatTimeLine = 1,     //微信朋友圈
    ShareTypeQQ = 2,                 //qq好友
    ShareTypeQZone = 3,              //qq空间
    ShareTypeSina = 4,     //微信朋友圈
};

@interface ShareModel : NSObject
//分享
+(void)shareWithType:(ShareType)type;
//注册
+(void)registerAll;
//分享后的回调应用
+(BOOL)handleOpenURL:(NSURL *)url delegate:(id)delegate;
//是否安装qq
+(BOOL)isQQInstalled;
//是否安装qq空间
+(BOOL)isQZoneInstalled;
//是否安装了微信
+(BOOL)isWechatInstalled;
@end
