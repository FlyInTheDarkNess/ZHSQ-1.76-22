//
//  CommunitySettingHttpRequest.m
//  ZHSQ
//
//  Created by yanglaobao on 15-1-5.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "CommunitySettingHttpRequest.h"
@interface CommunitySettingHttpRequest()
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

@implementation CommunitySettingHttpRequest
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
        //  社区选择接口
        if ([self.urlStr_ isEqualToString:SheQuXuanZe_m24_02])
        {
            self.errorCode = 1;
        }
        //  城市选择接口
        else if([self.urlStr_ isEqualToString:ChengShiXuanZe_m24_01])
        {
            self.errorCode = 2;
        }
//        else if ([self.urlStr_ isEqualToString:kYHGOODS_GOODS_DETAIL_URL])
//        {
//            self.errorCode = 3;
//        }
//        else if ([self.urlStr_ isEqualToString:kSECKILL_ID_URL])
//        {
//            self.errorCode = 4;
//        }else if ([self.urlStr_ isEqualToString:kSECKILL_LIST_URL]){
//            self.errorCode = 5;
//        }else if ([self.urlStr_ isEqualToString:kSTORE_DETAIL_URL]){
//            self.errorCode = 6;
//        }else if ([self.urlStr_ isEqualToString:kSECKILL_GOODS_DETAIL_URL]){
//            self.errorCode = 7;
//        }else if ([self.urlStr_ isEqualToString:kSECKILL_GOODS_URL]){
//            self.errorCode = 8;
//        }
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
    }
}

@end
