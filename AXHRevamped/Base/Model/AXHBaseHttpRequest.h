//
//  AXHHttpRequest.h
//  HappyFace
//
//  Created by 安雄浩的mac on 14-12-7.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AXHBaseHttpRequest : NSObject
//存储信息
@property (nonatomic,copy) NSString *msg;
//存储errorCode
@property (nonatomic,assign) int errorCode;
//存储网络请求完毕后的数据
@property (nonatomic,strong) id result;
//请求的URL地址
@property (nonatomic,strong) NSString *urlStr_;

@property (nonatomic,strong) NSArray *arrImages;
/**
 *@brief NewsNethelper 初始化方法
 *@discussion
 *  该方法提供了一个通过多个参数创建的NewsNethelper对象的途径
 *@param urlStr NSString
 * 请求的url地址
 *@param setRequestDict Dictionary
 *  请求参数值-字典
 *@param method NSString
 *  请求方法：@“GET” OR @"POST"
 *@param isSynRequest BOOL
 *      是否同步请求 YES：同步 NO ：异步
 *@param observer id
 *      观察者对象
 *@return NewsNethelper 对象
 */

-(id)initWithURL:(NSString *)urlStr
  setRequestDict:(NSDictionary *)setRequestDict
forRequestMethod:(NSString *)method
    isSynRequest:(BOOL)isSynRequest
        observer:(id)observer;

//开始请求
-(void)startRequest;
//取消请求
-(void)cancelRequest;
//get请求
- (ASIFormDataRequest*)requestInitForPost;
//post请求
- (ASIFormDataRequest*)requestInitForGet;

@end
