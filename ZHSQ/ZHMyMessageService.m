//
//  ZHMyMessageService.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-24.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ZHMyMessageService.h"
#import "ZHMyMessageHttpRequest.h"
@interface ZHMyMessageService()
{
    ZHMyMessageHttpRequest *httpRequest;
}
@end
@implementation ZHMyMessageService
-(void)beginQuery
{
    httpRequest = [[ZHMyMessageHttpRequest alloc]initWithURL:self.strUrl setRequestDict:self.requestDict forRequestMethod:@"POST" isSynRequest:NO observer:self];
    [httpRequest startRequest];
}
-(void)cancleQuery{
    [httpRequest cancelRequest];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    switch (httpRequest.errorCode) {
        case 1:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:1];
            break;
        case 2:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:2];
            break;
           }
    
}

@end
