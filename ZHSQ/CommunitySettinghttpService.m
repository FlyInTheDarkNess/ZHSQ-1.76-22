//
//  CommunitySettinghttpService.m
//  ZHSQ
//
//  Created by yanglaobao on 15-1-5.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "CommunitySettinghttpService.h"
#import "CommunitySettingHttpRequest.h"
@interface CommunitySettinghttpService()
{
    CommunitySettingHttpRequest *httpRequest;
}
@end
@implementation CommunitySettinghttpService
-(void)beginQuery
{
    httpRequest = [[CommunitySettingHttpRequest alloc]initWithURL:self.strUrl setRequestDict:self.requestDict forRequestMethod:@"POST" isSynRequest:NO observer:self];
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
//        case 3:
//            self.responDict = httpRequest.result;
//            [self.delegate didReceieveSuccess:3];
//            break;
//        case 4:
//            self.responDict = httpRequest.result;
//            [self.delegate didReceieveSuccess:4];
//            break;
//        case 5:
//            self.responDict = httpRequest.result;
//            [self.delegate didReceieveSuccess:5];
//            break;
//        case 6:
//            self.responDict = httpRequest.result;
//            [self.delegate didReceieveSuccess:6];
//            break;
//        case 7:
//            self.responDict = httpRequest.result;
//            [self.delegate didReceieveSuccess:7];
//            break;
//        case 8:
//            self.responDict = httpRequest.result;
//            [self.delegate didReceieveSuccess:8];
//            break;
        default:
            [self.delegate didReceieveFail:400];
            break;
    }
    
}

@end
