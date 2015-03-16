//
//  AXHhttpService.m
//  HappyFace
//
//  Created by 安雄浩的mac on 14-12-7.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//

#import "SQDynamicHttpService.h"
#import "SQDynamicHttpRequest.h"
@interface SQDynamicHttpService()
{
    SQDynamicHttpRequest *httpRequest;
}
@end
@implementation SQDynamicHttpService
-(void)beginQuery
{
    httpRequest = [[SQDynamicHttpRequest alloc]initWithURL:self.strUrl setRequestDict:self.requestDict forRequestMethod:@"POST" isSynRequest:NO observer:self];
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
            
        default:
            [self.delegate didReceieveFail:400];
            break;
    }
    
}

@end
