//
//  AXHYHGoodsHttpService.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHYHGoodsHttpService.h"
#import "AXHYHGoodsHttpRequest.h"
@interface AXHYHGoodsHttpService()
{
    AXHYHGoodsHttpRequest *httpRequest;
}
@end
@implementation AXHYHGoodsHttpService
-(void)beginQuery
{
    httpRequest = [[AXHYHGoodsHttpRequest alloc]initWithURL:self.strUrl setRequestDict:self.requestDict forRequestMethod:@"POST" isSynRequest:NO observer:self];
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
        case 3:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:3];
            break;
        case 4:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:4];
            break;
        case 5:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:5];
            break;
        case 6:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:6];
            break;
        case 7:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:7];
            break;
        case 8:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:8];
            break;
        case 3007:
            [self.delegate didReceieveFail:3007];
            break;
        default:
            [self.delegate didReceieveFail:400];
            break;
    }
    
}
@end
