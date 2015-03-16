//
//  CommunityTelViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-21.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "xiaoqubibei.h"
#import "XiaoQuBiBeiXinXi.h"

@interface CommunityTelViewController : AXHBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *label_title;
    UIButton *btn_fanhui;
    UITableView *mytableview;
    NSArray *arr_info;
}


@end
