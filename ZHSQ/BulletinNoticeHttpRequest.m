//
//  BulletinNoticeHttpRequest.m
//  ZHSQ
//
//  Created by yanglaobao on 15-1-5.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "BulletinNoticeHttpRequest.h"
@interface BulletinNoticeHttpRequest()
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

@implementation BulletinNoticeHttpRequest
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
        //  物业通知接口
        if ([self.urlStr_ isEqualToString:WuYeTongZhi_m12_01])
        {
            self.errorCode = 1;
        }
        //  物业通知接口
        else if([self.urlStr_ isEqualToString:WuYeTongZhi_m12_02])
        {
            self.errorCode = 2;
        }
        //  社区通知接口
        else if ([self.urlStr_ isEqualToString:SheQuTongZhi_m13_01])
        {
            self.errorCode = 3;
        }
        //  社区通知接口
        else if ([self.urlStr_ isEqualToString:SheQuTongZhi_m13_02])
        {
            self.errorCode = 4;
        }
        //  市政新闻接口
        else if ([self.urlStr_ isEqualToString:ZiXunXinXi_m38_01])
        {
            self.errorCode = 5;
        }
        //  市政新闻接口
        else if ([self.urlStr_ isEqualToString:ZiXunXinXi_m38_02])
        {
            self.errorCode = 6;
        }
        //  热推荐主键id
        else if ([self.urlStr_ isEqualToString:HitRecommend_m29_01])
        {
            self.errorCode = 7;
        }
        //  热推荐主键信息
        else if ([self.urlStr_ isEqualToString:HitRecommend_m29_02])
        {
            self.errorCode = 8;
        }
        //  热推荐频道信息
        else if ([self.urlStr_ isEqualToString:HitRecommend_m29_03])
        {
            self.errorCode = 9;
        }
        //  热推荐频道信息
        else if ([self.urlStr_ isEqualToString:QieHuanZhuZhiXinXi_24_012])
        {
            self.errorCode = 10;
        }

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
    }
}

@end
