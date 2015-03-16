//
//  ZhuZhiXinXiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-9-22.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhuZhiXinXiViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UILabel *label_title;
    UIButton *fanhui;
    UIButton *wancheng;
    UIImageView *imageview1;
    UIImageView *imageview2;
    UIImageView *imageview3;
    UIImageView *imageview4;
    UILabel *label_shuoming;
    UILabel *label_beijing;
    UILabel *label_wodexiaoqu;
    UILabel *label_wodedanyuan;
    UILabel *label_wodelouyuhao;
    UILabel *label_wodefangjianhao;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    UILabel *label6;
    UILabel *label7;
    UILabel *label8;
    UILabel *label9;
    UILabel *label10;
    UIButton *btn_wodexiaoqu;
    UIButton *btn_louyuhao;
    UIButton *btn_danyuan;
    UIButton *btn_fangjianhao;
    UIButton *btn_queding;
    UIButton *btn_quxiao;
    UITableView *tableview_louyu;
    UITableView *tableview_danyuan;
    UITableView *tableview_fangjian;
    UIView *beijing_view;
    NSMutableArray *arr_info_louyu;
    NSMutableArray *arr_info_danyuan;
    NSMutableArray *arr_info_fangjian;
    NSString *louyuID;
    NSString *danyuanID;
    NSString *fangjianID;
    
}

@end
