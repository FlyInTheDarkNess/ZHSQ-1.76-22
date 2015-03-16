//
//  AXHLTHelpHttpService.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/17.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHLTHelpHttpService.h"
#import "AXHLTHelpHttpRequest.h"
@interface AXHLTHelpHttpService()
{
    AXHLTHelpHttpRequest *httpRequest;
}
@end
@implementation AXHLTHelpHttpService
-(void)beginQuery
{
    httpRequest = [[AXHLTHelpHttpRequest alloc]initWithURL:self.strUrl setRequestDict:self.requestDict forRequestMethod:@"POST" isSynRequest:NO observer:self];
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
        default:
            [self.delegate didReceieveFail:400];
            break;
    }
    
}

@end
