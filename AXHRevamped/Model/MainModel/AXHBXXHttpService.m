
//
//  AXHBXXHttpService.m
//  ZHSQ
//
//  Created by 安雄浩 on 15/1/19.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBXXHttpService.h"
#import "AXHBXXhttpRequest.h"
@interface AXHBXXHttpService()
{
    AXHBXXhttpRequest *httpRequest;
}
@end
@implementation AXHBXXHttpService
-(void)beginQuery
{
    httpRequest = [[AXHBXXhttpRequest alloc]initWithURL:self.strUrl setRequestDict:self.requestDict forRequestMethod:@"POST" isSynRequest:NO observer:self];
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
        default:
            [self.delegate didReceieveFail:400];
            break;
    }
    
}
@end
