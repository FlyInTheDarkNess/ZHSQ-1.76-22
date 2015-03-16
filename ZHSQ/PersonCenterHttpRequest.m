//
//  PersonCenterHttpRequest.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-20.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "PersonCenterHttpRequest.h"
#import "URL.h"
@interface PersonCenterHttpRequest()
{
    //该方法提供了一个通过多个参数创建的NewsNethelper对象的途径
    ASIFormDataRequest *request_;
    // ASIHTTPRequest *request_
    //请求参数值字典
    NSDictionary *dict_;
    //是否同步请求
    BOOL isSyn_;
    //观察者
    id  observer_;
    
    NSMutableString *nameStr_;
    NSString *currentTag_;
    BOOL isSecuess;
    
    NSMutableDictionary *responDict;
}
@end

@implementation PersonCenterHttpRequest
//联网失败
-(void)requestFailed:(ASIHTTPRequest *)request
{
    self.errorCode = 400;
    [SVProgressHUD showErrorWithStatus:@"网络连接失败!" duration:1.5];
}
//联网成功
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:request.responseString];
    NSError *error;
    NSData *resonData = [str_jiemi dataUsingEncoding:NSUTF8StringEncoding];
    id data = [NSJSONSerialization JSONObjectWithData:resonData options:NSJSONReadingAllowFragments error:&error];
    if(!error)
    {
        
        self.result = data;
        //  查询用户绑定住址信息
        if ([self.urlStr_ isEqualToString:QieHuanXiaoQu_m1_13])
        {
            self.errorCode = 1;
        }
        //  切换住址
        else if([self.urlStr_ isEqualToString:QieHuanZhuZhiXinXi_24_012])
        {
            self.errorCode = 2;
        }
        //  更新用户切换的住址信息
        else if ([self.urlStr_ isEqualToString:YongHuBangDingXinXi_m1_17])
        {
            self.errorCode = 3;
        }
        //  添加新住址-楼宇号
        else if ([self.urlStr_ isEqualToString:LouYuHao_m24_07])
        {
            self.errorCode = 4;
        }
        //  添加新住址-单元号
        else if ([self.urlStr_ isEqualToString:DanYuanHao_m24_08])
        {
            self.errorCode = 5;
        }
        //  添加新住址-房间号
        else if ([self.urlStr_ isEqualToString:FangJianHao_m24_09])
        {
            self.errorCode = 6;
        }
        //  绑定小区、楼宇、单元、房间等详细信息
        else if ([self.urlStr_ isEqualToString:BaoCunGeRenXinXi_m24_10])
        {
            self.errorCode = 7;
        }
        //  绑定小区
        else if ([self.urlStr_ isEqualToString:BaoCunXiaoQuXinXi_m24_03])
        {
            self.errorCode = 8;
        }
        //  我的帖子主键id
        else if ([self.urlStr_ isEqualToString:MyPosts_m10_08])
        {
            self.errorCode = 9;
        }
        //  我的帖子列表信息
        else if ([self.urlStr_ isEqualToString:MyPosts_m10_11])
        {
            self.errorCode = 10;
        }
        //  小区电话主键id
        else if ([self.urlStr_ isEqualToString:XiaoQuBiBei_m27_01])
        {
            self.errorCode = 11;
        }
        //  小区电话列表信息
        else if ([self.urlStr_ isEqualToString:XiaoQuBiBei_m27_02])
        {
            self.errorCode = 12;
        }
        //  我的笑脸币收入主键id
        else if ([self.urlStr_ isEqualToString:WoDeXiaoLianBi_m19_01])
        {
            self.errorCode = 13;
        }
        //  我的笑脸币收入列表信息
        else if ([self.urlStr_ isEqualToString:WoDeXiaoLianBi_m19_02])
        {
            self.errorCode = 14;
        }
        //  我的笑脸币合计总数
        else if ([self.urlStr_ isEqualToString:WoDeXiaoLianBi_m19_03])
        {
            self.errorCode = 15;
        }
        //  我的笑脸币消费主键id
        else if ([self.urlStr_ isEqualToString:WoDeXiaoLianBi_m19_04])
        {
            self.errorCode = 16;
        }
        //  我的笑脸币消费列表信息
        else if ([self.urlStr_ isEqualToString:WoDeXiaoLianBi_m19_05])
        {
            self.errorCode = 17;
        }
        //  我的收藏主键id
        else if ([self.urlStr_ isEqualToString:WoDeShouCang_m28_03])
        {
            self.errorCode = 18;
        }
        //  我的收藏-论坛信息列表
        else if ([self.urlStr_ isEqualToString:SheQuHuDong_m10_03])
        {
            self.errorCode = 19;
        }
        //  我的收藏-商家信息列表
        else if ([self.urlStr_ isEqualToString:SheQuFuWu_m3_03])
        {
            self.errorCode = 20;
        }
        //  绑定银行卡
        else if ([self.urlStr_ isEqualToString:YinHangKa_m1_21])
        {
            self.errorCode = 21;
        }
        //  取得绑定银行卡信息
        else if ([self.urlStr_ isEqualToString:YinHangKa_m1_22])
        {
            self.errorCode = 22;
        }
        //  解除绑定银行卡
        else if ([self.urlStr_ isEqualToString:YinHangKa_m1_23])
        {
            self.errorCode = 23;
        }
        //  我得爆料主键id
        else if ([self.urlStr_ isEqualToString:BaoLiao_m44_08])
        {
            self.errorCode = 24;
        }
        //  我得爆料信息
        else if ([self.urlStr_ isEqualToString:BaoLiao_m44_03])
        {
            self.errorCode = 25;
        }
        //  我得帖子-删除
        else if ([self.urlStr_ isEqualToString:SheQuHuDong_m10_09])
        {
            self.errorCode = 26;
        }



    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
    }
}

@end
