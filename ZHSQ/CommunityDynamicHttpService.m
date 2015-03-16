//
//  CommunityDynamicHttpService.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "CommunityDynamicHttpService.h"
#import "CommunityDynamicHttpRequest.h"
#import "AXHVendors.h"
@interface CommunityDynamicHttpService()
{
    CommunityDynamicHttpRequest *httpRequest;
}
@end

@implementation CommunityDynamicHttpService
-(void)beginQuery
{
    httpRequest = [[CommunityDynamicHttpRequest alloc]initWithURL:self.strUrl setRequestDict:self.requestDict forRequestMethod:@"POST" isSynRequest:NO observer:self];
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
