//
//  AXHHttpRequest.m
//  HappyFace
//
//  Created by 安雄浩的mac on 14-12-7.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//
#import "AXHBaseHttpRequest.h"
@interface AXHBaseHttpRequest()
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
@implementation AXHBaseHttpRequest
-(id)initWithURL:(NSString *)urlStr setRequestDict:(NSDictionary *)setRequestDict forRequestMethod:(NSString *)method isSynRequest:(BOOL)isSynRequest observer:(id)observer
{
    self = [super init];
    if(self)
    {
        self.urlStr_ = urlStr;
        dict_ = setRequestDict;
        if([method isEqualToString:@"POST"])
        {
            request_ = [self requestInitForPost];
        }
        else
        {
            request_ = [self requestInitForGet];
        }
        isSyn_ = isSynRequest;
        request_.requestMethod = method;
        request_.timeOutSeconds = 5.0;
        request_.delegate = self;
        if (observer) {
            observer_ = observer;
            [self addObserver:observer_ forKeyPath:@"errorCode" options:NSKeyValueObservingOptionNew context:NULL];
        }
        
    }
    return self;
}
- (ASIFormDataRequest*)requestInitForPost{
    ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:self.urlStr_]];
    if (dict_) {
        for (NSString *key in dict_) {
            if ([key isEqualToString:@"pictures"]) {
                [postRequest addFile:dict_[key] forKey:@"pictures"];
            }else if ([key isEqualToString:@"mediafile"]) {
                [postRequest addFile:dict_[key] forKey:@"mediafile"];
            }
            else{
                [postRequest addPostValue:dict_[key] forKey:key];
            }
        }
    }
    return postRequest;
}

//- (ASIFormDataRequest*)requestInitForPost{
//    ASIFormDataRequest *postRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:self.urlStr_]];
//    if (dict_) {
//        for (NSString *key in dict_) {
//            [postRequest setPostValue:dict_[key]  forKey:key];
//        }
//        
//    }
//    return postRequest;
//}
- (ASIFormDataRequest*)requestInitForGet{
    NSMutableString *urlMutableStr = [NSMutableString stringWithString:self.urlStr_];
    if (dict_.count > 0) {
        [urlMutableStr appendString:@"?"];
        for (NSString *key in dict_) {
            [urlMutableStr appendString:key];
            [urlMutableStr appendString:@"="];
            [urlMutableStr appendString:[NSString stringWithFormat:@"%@",dict_[key]]];
            [urlMutableStr appendString:@"&"];
        }
        NSRange range = NSMakeRange(urlMutableStr.length - 1, 1);
        [urlMutableStr deleteCharactersInRange:range];
    }
    NSString *str = [NSString stringWithFormat:@"%@",urlMutableStr];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlMutableStr]];
}
-(void)startRequest
{
    if(isSyn_)
    {
        [request_ startSynchronous];
    }
    else
    {
        [request_ startAsynchronous];
    }
}
-(void)cancelRequest
{
    if(observer_)
    {
        [self removeObserver:observer_ forKeyPath:@"errorCode"];
        observer_ = nil;
    }
    if(request_)
    {
        [request_ clearDelegatesAndCancel];
        request_ = nil;
    }
}

//联网失败
-(void)requestFailed:(ASIHTTPRequest *)request
{
    self.errorCode = 400;
    [SVProgressHUD showErrorWithStatus:@"网络连接失败!" duration:1.5];
}
//联网成功
-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    /*NSString *str_jiemi=[SurveyRunTimeData stringFromHexString:request.responseString];
    NSError *error;
    NSLog(@"%@",str_jiemi);
    NSData *resonData = [str_jiemi dataUsingEncoding:NSUTF8StringEncoding];
    id data = [NSJSONSerialization JSONObjectWithData:resonData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"----%@",data);
    if(!error)
    {
        self.result = data;
        if ([urlStr_ isEqualToString:SheQuDongTai_m7_01]) {
            self.errorCode = 1;
        }else if ([urlStr_ isEqualToString:SheQuDongTai_m7_02]){
            self.errorCode = 2;
        }
    }
    else
    {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
    }*/
}
@end
