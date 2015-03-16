//
//  MyBillViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-3-11.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "QCheckBox.h"
#import "AXHButton.h"
@interface MyBillViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate,QCheckBoxDelegate>
{
    UITableView *MyBliiTableview;
    UIButton *fanhui;
    UILabel *label_title;
    UIButton *btn_weijiaofeizhangdan;
    UIButton *btn_lishizhangdan;
    NSString *PayStatus;
    NSString *str_Status;
    NSMutableArray *Type_Arr;
    UIButton *Pay_btn;
    UILabel *label;
    UILabel *total_label;
    float JinE;
    NSString *string_Ip;
    NSString *order_id;
    NSString *payment;
    NSString *remark1;
    NSString *remark2;
    NSString *proinfo;
    NSString *property_id;
    BOOL y;
    AXHButton *seckillBtn;
}


@end
