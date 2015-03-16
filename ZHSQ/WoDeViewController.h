//
//  WoDeViewController.h
//  ZHSQ
//
//  Created by lacom on 14-4-30.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoDeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview_laiwu;
    UITableView *tableview_shandong;
    UITableView *tableview_yangshi;
    UIButton *LaiWuBtn;
    UIButton *ShanDongBtn;
    UIButton *YangShiBtn;
    UIButton *fanhui;
    UILabel *label;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UIView *view_LaiWu;
    UIView *view_ShanDong;
    UIView *view_YangShi;
    NSMutableData *receiveData;
    NSMutableArray *arr;
    NSMutableArray *arr2;
}
@end
