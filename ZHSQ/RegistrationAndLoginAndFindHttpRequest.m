//
//  RegistrationAndLoginAndFindHttpRequest.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-21.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "RegistrationAndLoginAndFindHttpRequest.h"
@interface RegistrationAndLoginAndFindHttpRequest()
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


@implementation RegistrationAndLoginAndFindHttpRequest
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
        //  注册接口
        if ([self.urlStr_ isEqualToString:ZhuCe_m1_02])
        {
            self.errorCode = 1;
        }
        //  登录接口
        else if([self.urlStr_ isEqualToString:YongHuBangDingXinXi_m1_17])
        {
            self.errorCode = 2;
        }
        //  找回密码接口
        else if ([self.urlStr_ isEqualToString:CongZhiMiMa_m1_07])
        {
            self.errorCode = 3;
        }
        //  获取验证码接口
        else if ([self.urlStr_ isEqualToString:HuoQuYanZhengMa_m1_12])
        {
            self.errorCode = 4;
        }
        //  修改密码接口
        else if ([self.urlStr_ isEqualToString:XiuGaiMiMa_m1_09])
        {
            self.errorCode = 5;
        }
        //  社区服务列表主键id接口
        else if ([self.urlStr_ isEqualToString:SheQuFuWu_m3_08])
        {
            self.errorCode = 6;
        }
        //  社区服务列表信息接口
        else if ([self.urlStr_ isEqualToString:SheQuFuWu_m3_03])
        {
            self.errorCode = 7;
        }
        //取得团购商品主键列表id
        else if ([self.urlStr_ isEqualToString:TuanGou_m40_10])
        {
            self.errorCode = 8;
        }
        //取得团购商品简略信息
        else if ([self.urlStr_ isEqualToString:TuanGou_m40_11])
        {
            self.errorCode = 9;
        }
        //取得团购商品详细信息  
        else if ([self.urlStr_ isEqualToString:TuanGou_m40_12])
        {
            self.errorCode = 10;
        }
        //团购商品提交
        else if ([self.urlStr_ isEqualToString:TuanGou_m40_13])
        {
            self.errorCode = 11;
        }
        //缴费账单主键列表
        else if ([self.urlStr_ isEqualToString:KuaiJieJiaoFeiZhuJian_m30_01])
        {
            self.errorCode = 12;
        }
        //物业费账单信息
        else if ([self.urlStr_ isEqualToString:WuYeFei_m30_02])
        {
            self.errorCode = 13;
        }
        //水费账单信息
        else if ([self.urlStr_ isEqualToString:ShuiFei_m30_03])
        {
            self.errorCode = 14;
        }
        //暖气费账单信息
        else if ([self.urlStr_ isEqualToString:NuanQiFei_m30_04])
        {
            self.errorCode = 15;
        }
        //停车费账单信息
        else if ([self.urlStr_ isEqualToString:TingCheFei_m30_05])
        {
            self.errorCode = 16;
        }
        //缴费（单项缴费）
        else if ([self.urlStr_ isEqualToString:JiaoFei_c1_02])
        {
            self.errorCode = 17;
        }
        //缴费（综合缴费）
        else if ([self.urlStr_ isEqualToString:ZongHeJiaoFei_c1_05])
        {
            self.errorCode = 18;
        }
        //缴费（综合缴费)统一接口
        else if ([self.urlStr_ isEqualToString:JiaoFei_m45_01])
        {
            self.errorCode = 19;
        }
        //缴费（综合缴费）统一接口
        else if ([self.urlStr_ isEqualToString:JiaoFei_m45_02])
        {
            self.errorCode = 20;
        }
//        //取得ip地址
//        else if ([self.urlStr_ isEqualToString:ipAddress_m1_01])
//        {
//            self.errorCode = 19;
//        }
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
    }
}

@end
