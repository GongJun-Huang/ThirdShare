//
//  ShareModel.m
//  Test
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ShareModel.h"
//#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

@implementation ShareModel

+(void)shareWithType:(ShareType)type{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"Icon-60" ofType:@"png"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    

    [self shareWithType:type URLStr:@"http://vlinkyun.net" Title:@"奔流淘客助手" description:@"淘客的发单神器" previewImageData:imageData];
    
    
    
}


+(void)shareWithType:(ShareType)type URLStr:(NSString *)urlStr Title:(NSString *)title description:(NSString *)description previewImageData:(NSData *)data{
    switch (type) {
        case ShareTypeQQ:{
            [self shareTencentWithType:type URLStr:@"http://vlinkyun.net" Title:@"奔流淘客助手" description:@"淘客的发单神器" previewImageData:data];
            break;
        }
        case ShareTypeQZone:{
            [self shareTencentWithType:type URLStr:@"http://vlinkyun.net" Title:@"奔流淘客助手" description:@"淘客的发单神器" previewImageData:data];
            break;
        }
        case ShareTypeWechatSession:{
            
            break;
        }
        case ShareTypeWechatTimeLine:{
            
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

//-(void)shareWith
//
//-(void)


@end
