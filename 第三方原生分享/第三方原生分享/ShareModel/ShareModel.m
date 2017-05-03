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

//微博
#import <WeiboSDK.h>

#define kQQAppId @"1234567891"
#define kWechatAppId @"wx123456a12345d02"
#define kSinaAppKey @"2045436852"
#define kRedirectURI    @"https://www.sina.com"

@interface ShareModel()

@end

@implementation ShareModel

+(void)registerAll{
    //腾讯注册
    TencentOAuth *tencent = [[TencentOAuth alloc] initWithAppId:kQQAppId andDelegate:nil];
    NSLog(@"%@",tencent);
    
    //微信注册
    [WXApi registerApp:kWechatAppId];
    
    //微博注册
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaAppKey];
}

//分享后的回调应用
+(BOOL)handleOpenURL:(NSURL *)url delegate:(id)delegate{
    if ([url.scheme isEqualToString:kWechatAppId]) {
        return [WXApi handleOpenURL:url delegate:delegate];
    }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"tencent%@",kQQAppId]]) {
        return [TencentOAuth HandleOpenURL:url];
    }else if ([url.scheme isEqualToString:[NSString stringWithFormat:@"wb%@",kSinaAppKey]]) {
        return [WeiboSDK handleOpenURL:url delegate:delegate];
    }else{
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
        case ShareTypeSina:{
            [self shareSinaWithURLStr:urlStr Title:title description:description previewImageData:data];
            break;
        }
        default:
            break;
    }
}

#pragma mark 
#pragma mark 分享至qq或qq空间
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

#pragma mark
#pragma mark 分享至微信或微信朋友圈，scene为场景 0:会话  1:朋友圈 利用此特性构造type
+(void)shareWechatWithType:(ShareType)type URLStr:(NSString *)urlStr Title:(NSString *)title description:(NSString *)description previewImageData:(NSData *)data{
    //构造消息实例
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:[UIImage imageWithData:data]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlStr;
    message.mediaObject = ext;
    
    //构造分享实例（包含消息、消息类型、场景）
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = type; //scene为场景 0:会话  1:朋友圈 利用此特性构造type
    
    //发送
    [WXApi sendReq:req];

}

#pragma mark 
#pragma mark 分享至新浪微博
+(void)shareSinaWithURLStr:(NSString *)urlStr Title:(NSString *)title description:(NSString *)description previewImageData:(NSData *)data{
    
    //授权信息
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    //构建消息实例
    WBMessageObject *message = [WBMessageObject message];
//    message.text = title;
//    WBImageObject *image = [WBImageObject object];
//    image.imageData = data;
//    message.imageObject = image;
    
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = @"identifier1";
    webpage.title = title;
    webpage.description = description;
    webpage.thumbnailData = data;
    webpage.webpageUrl = urlStr;
    message.mediaObject = webpage;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:nil];
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
    
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

//是否安装了微博
+(BOOL)isSinaInstalled{
    return [WeiboSDK isWeiboAppInstalled];
}

@end
