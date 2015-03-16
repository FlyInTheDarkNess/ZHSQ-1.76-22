//
//  AXHhttpService.h
//  HappyFace
//
//  Created by 安雄浩的mac on 14-12-7.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HttpDataServiceDelegate <NSObject>
//承接数据
-(void)didReceieveSuccess:(NSInteger)tag;
//承接消息
-(void)didReceieveFail:(NSInteger)tag;

@end

@interface AXHhttpService : NSObject


//设置委托
@property (nonatomic,weak)id<HttpDataServiceDelegate>delegate;
//获取数据
-(void)beginQuery;
//取消请求
-(void)cancleQuery;

//请求参数
@property (nonatomic,strong) NSDictionary *requestDict;
//请求方式
@property (nonatomic,copy) NSString *method;
//url
@property (nonatomic,copy) NSString *strUrl;
//错误信息
@property (nonatomic,copy) NSString *msg;
//接收的数据
@property (nonatomic,strong) NSMutableDictionary *responDict;

@end

