//
//  FangChanYeWuViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-9-25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import "WorkItem.h"

@interface FangChanYeWuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    NSMutableData *receiveData;
    NSMutableArray *arr;
    NSArray *workItemss;
    
}


@end
