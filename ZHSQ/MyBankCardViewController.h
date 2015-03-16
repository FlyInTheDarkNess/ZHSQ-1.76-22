//
//  MyBankCardViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-2-4.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "PushAlertViewDelegate.h"
@interface MyBankCardViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate,PushAlertViewDelegate>
{
    UITableView *Mytableview;
}

@end
