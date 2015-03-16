//
//  PushAlertViewDelegate.h
//  ProtocolDelegateDemoTest
//
//  Created by Ling yunfenghan on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PushAlertViewDelegate <NSObject>
- (void)RefreshAddressMessage;
- (void)DataInit;
- (void)AddCommunityPreferentialMessageDate;
@end
