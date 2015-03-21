//
//  BulletinNoticeHttpService.m
//  ZHSQ
//
//  Created by yanglaobao on 15-1-5.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "BulletinNoticeHttpService.h"
#import "BulletinNoticeHttpRequest.h"
@interface BulletinNoticeHttpService()
{
    BulletinNoticeHttpRequest *httpRequest;
}
@end
@implementation BulletinNoticeHttpService
-(void)beginQuery
{
    httpRequest = [[BulletinNoticeHttpRequest alloc]initWithURL:self.strUrl setRequestDict:self.requestDict forRequestMethod:@"POST" isSynRequest:NO observer:self];
    [httpRequest startRequest];
}
-(void)cancleQuery
{
    [httpRequest cancelRequest];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    switch (httpRequest.errorCode)
    {
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
        case 9:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:9];
            break;
        case 10:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:10];
            break;
        case 11:
            self.responDict = httpRequest.result;
            [self.delegate didReceieveSuccess:11];
            break;


        default:
            [self.delegate didReceieveFail:400];
            break;
    }
    
}

@end
