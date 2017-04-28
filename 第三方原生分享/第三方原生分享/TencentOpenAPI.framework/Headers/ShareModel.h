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
    ShareTypeQQ = 0,                 //qq好友
    ShareTypeQZone = 1,              //qq空间
    ShareTypeWechatSession = 2,      //微信聊天
    ShareTypeWechatTimeLine = 3,     //微信朋友圈
    ShareTypeSina = 4,     //微信朋友圈
};

@interface ShareModel : NSObject

+(void)shareWithType:(ShareType)type;

@end
