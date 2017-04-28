//
//  ShareModel.m
//  Test
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ShareModel.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信api
#import "WXApi.h"

#define kQQAppId @"1234567891"
#define kWechatAppId @"wx123456a12345d02"

@interface ShareModel()

@end

@implementation ShareModel

+(void)registerAll{
    //腾讯注册
    TencentOAuth *tencent = [[TencentOAuth alloc] initWithAppId:kQQAppId andDelegate:nil];
    NSLog(@"%@",tencent);
    
    //微信注册
    [WXApi registerApp:kWechatAppId];
}

//分享后的回调应用
+(BOOL)handleOpenURL:(NSURL *)url delegate:(id)delegate{
    if ([url.scheme isEqualToString:kWechatAppId]) {
        return [WXApi handleOpenURL:url delegate:delegate];
    }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",kQQAppId]]) {
        return [TencentOAuth HandleOpenURL:url];
    }else {
        return YES;
    }
}




+(void)shareWithType:(ShareType)type{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"shareImage" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    

    [self shareWithType:type URLStr:@"https://www.baidu.com" Title:@"分享标题" description:@"分享详细描述" previewImageData:imageData];
    
    
}


+(void)shareWithType:(ShareType)type URLStr:(NSString *)urlStr Title:(NSString *)title description:(NSString *)description previewImageData:(NSData *)data{
    switch (type) {
        case ShareTypeQQ:{
            [self shareTencentWithType:type URLStr:urlStr Title:title description:description previewImageData:data];
            break;
        }
        case ShareTypeQZone:{
            [self shareTencentWithType:type URLStr:urlStr Title:title description:description previewImageData:data];
            break;
        }
        case ShareTypeWechatSession:{
            [self shareWechatWithType:type URLStr:urlStr Title:title description:description previewImageData:data];
            break;
        }
        case ShareTypeWechatTimeLine:{
            [self shareWechatWithType:type URLStr:urlStr Title:title description:description previewImageData:data];
            break;
        }
        default:
            break;
    }
}

+(void)shareTencentWithType:(ShareType)type URLStr:(NSString *)urlStr Title:(NSString *)title description:(NSString *)description previewImageData:(NSData *)data{
    
    //创建分享新闻实例
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlStr] title:title description:description previewImageData:data];
    newsObj.shareDestType = ShareDestTypeQQ;
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    //根据类型分享至qq还是空间
    QQApiSendResultCode sentQQ;
    switch (type) {
        case ShareTypeQQ:{
            sentQQ = [QQApiInterface sendReq:req];
            break;
        }
        case ShareTypeQZone:{
            sentQQ = [QQApiInterface SendReqToQZone:req];
            break;
        }
        default:
            break;
    }
    NSLog(@"QQApiSendResultCode %d",sentQQ);
}

//分享微信，scene为场景 0:会话  1:朋友圈 利用此特性构造type
+(void)shareWechatWithType:(ShareType)type URLStr:(NSString *)urlStr Title:(NSString *)title description:(NSString *)description previewImageData:(NSData *)data{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:[UIImage imageWithData:data]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlStr;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = type;
    
    [WXApi sendReq:req];

}


//是否安装qq
+(BOOL)isQQInstalled{
    return [TencentOAuth iphoneQQInstalled];
}

//是否安装qq空间
+(BOOL)isQZoneInstalled{
    return [TencentOAuth iphoneQZoneInstalled];
}

//是否安装了微信
+(BOOL)isWechatInstalled{
    return [WXApi isWXAppInstalled];
}


@end
