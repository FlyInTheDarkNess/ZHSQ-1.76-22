//
//  WoDeNuanQiFeiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoDeNuanQiFeiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *label_title;
    UIButton *fanhui;
    UIButton *btn_weijiaofeizhangdan;
    UIButton *btn_lishizhangdan;
    UITableView *tableview_weijiaofei;
    UITableView *tableview_lishizhangdan;
    UILabel *label_tishi;
    int intb;
    NSMutableArray *arr_weijiao;
    NSMutableArray *arr_yijiao;
    
}


@end
