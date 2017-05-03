//
//  ViewController.m
//  第三方原生分享
//
//  Created by Apple on 2017/4/26.
//  Copyright © 2017年 Jim. All rights reserved.
//

#import "ViewController.h"
#import "ShareModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *qq = [[UIButton alloc] initWithFrame:CGRectMake(150, 150, 100, 50)];
    [qq setTitle:@"分享qq" forState:UIControlStateNormal];
    [qq setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qq.backgroundColor = [UIColor redColor];
    [qq addTarget:self action:@selector(qqAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qq];
    
    
    UIButton *qZone = [[UIButton alloc] initWithFrame:CGRectMake(150, 210, 100, 50)];
    [qZone setTitle:@"分享qq空间" forState:UIControlStateNormal];
    [qZone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qZone.backgroundColor = [UIColor redColor];
    [qZone addTarget:self action:@selector(qZoneAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qZone];
    
    UIButton *wechat = [[UIButton alloc] initWithFrame:CGRectMake(150, 270, 100, 50)];
    [wechat setTitle:@"分享微信" forState:UIControlStateNormal];
    [wechat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wechat.backgroundColor = [UIColor redColor];
    [wechat addTarget:self action:@selector(wechatAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechat];
    
    UIButton *timeLine = [[UIButton alloc] initWithFrame:CGRectMake(150, 330, 100, 50)];
    [timeLine setTitle:@"分享朋友圈" forState:UIControlStateNormal];
    [timeLine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    timeLine.backgroundColor = [UIColor redColor];
    [timeLine addTarget:self action:@selector(timeLineAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timeLine];
    
    UIButton *sina = [[UIButton alloc] initWithFrame:CGRectMake(150, 390, 100, 50)];
    [sina setTitle:@"分享微博" forState:UIControlStateNormal];
    [sina setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sina.backgroundColor = [UIColor redColor];
    [sina addTarget:self action:@selector(sinaAct) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sina];
}

-(void)qqAct{
    [ShareModel shareWithType:ShareTypeQQ];
}

-(void)qZoneAct{
    [ShareModel shareWithType:ShareTypeQZone];
}

-(void)wechatAct{
    [ShareModel shareWithType:ShareTypeWechatSession];
}

-(void)timeLineAct{
    [ShareModel shareWithType:ShareTypeWechatTimeLine];
}

-(void)sinaAct{
    [ShareModel shareWithType:ShareTypeSina];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
