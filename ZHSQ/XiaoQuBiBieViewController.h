//
//  XiaoQuBiBieViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-9-18.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "xiaoqubibei.h"
#import "XiaoQuBiBeiXinXi.h"
@interface XiaoQuBiBieViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *label_title;
    UIButton *btn_fanhui;
    UITableView *mytableview;
    NSArray *arr_info;
}

@end
