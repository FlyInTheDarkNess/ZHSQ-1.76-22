//
//  GovernmentNoticeViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 15-1-5.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "zhengfugonggao.h"
@interface GovernmentNoticeViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    NSMutableData *receiveData;
    NSMutableArray *arr;
    zhengfugonggao *gonggao;
    NSArray *workItemss;
    
}


@end
