//
//  SQDynamicHttpRequest.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/9.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "SQForumHttpRequest.h"
@interface SQForumHttpRequest()
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
@implementation SQForumHttpRequest
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
        if ([self.urlStr_ isEqualToString:SheQuHuDong_m10_02]) {
            self.errorCode = 1;
        }else if ([self.urlStr_ isEqualToString:SheQuHuDong_m10_03]){
            self.errorCode = 2;
        } else if ([self.urlStr_ isEqualToString:SheQuHuDong_m10_04] || [self.urlStr_ isEqualToString:kSOURCE_NEW_ID_URL]){
            self.errorCode = 3;
        }else if ([self.urlStr_ isEqualToString:SheQuHuDong_m10_05] || [self.urlStr_ isEqualToString:kSOURCE_NEW_LIST_URL]){
            self.errorCode = 4;
        }else if ([self.urlStr_ isEqualToString:SheQuHuDong_m10_07]){
            self.errorCode = 5;
        }else if ([self.urlStr_ isEqualToString:SheQuHuDong_m10_06] ||[self.urlStr_ isEqualToString:kSOURCE_NEW_FEEDBACK_URL]){
            self.errorCode = 6;
        }else if ([self.urlStr_ isEqualToString:kUSER_BUSINESS_URL]){
            self.errorCode = 7;
        }else if ([self.urlStr_ isEqualToString:kUSER_NEWS_UPORDOWN_URL]){
            self.errorCode = 8;
        }else if ([self.urlStr_ isEqualToString:kSOURCE_NEW_URL]){
            self.errorCode = 9;
        }else if ([self.urlStr_ isEqualToString:kBXX_NEW_URL]){
            self.errorCode = 10;
        }
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
    }
}

@end
