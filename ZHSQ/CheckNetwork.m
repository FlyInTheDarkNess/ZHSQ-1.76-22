//
//  CheckNetwork.m
//  testNet
//
//  Created by b126 on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CheckNetwork.h"
#import "Reachability.h"
@implementation CheckNetwork
+(BOOL)isExistenceNetwork
{
	BOOL isExistenceNetwor;
	Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
			isExistenceNetwor=FALSE;
            break;
        case ReachableViaWWAN:
			isExistenceNetwor=TRUE;
            break;
        case ReachableViaWiFi:
			isExistenceNetwor=TRUE;
            break;
    }
	if (!isExistenceNetwor) {
		UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"服务器连接失败,请检查网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
		[myalert show];
		[myalert release];
	}
	return isExistenceNetwor;
}
@end
