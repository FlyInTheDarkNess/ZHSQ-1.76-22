//
//  GeRenZhongXinViewController.h
//  ZHSQ
//
//  Created by lacom on 14-5-6.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QieHuanZhuZhiXinXi.h"
@interface GeRenZhongXinViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mytableview;
    UILabel *label_title;
    UIButton *fanhui;
    UIImageView *imageview1;
    UIImageView *imageview2;
    UIImageView *imageview3;
    UIImageView *imageview4;
    UIImageView *imageview5;
    UIImageView *imageview6;
    UIImageView *imageview7;
    UIScrollView *myscrollview;
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
    UILabel *label11;
    UILabel *label12;
    UILabel *label13;
    UILabel *label14;
    UILabel *label15;
    UILabel *label16;
    UILabel *label17;
    UILabel *label18;
    UILabel *label19;
    UILabel *label20;
    UILabel *label21;
    UILabel *label_jiantou1;
    UILabel *label_jiantou2;
    UILabel *label_jiantou3;
    UILabel *label_jiantou4;
    UILabel *label_jiantou5;
    UILabel *label_jiantou6;
    UILabel *label_jiantou7;
    UILabel *label_jiantou8;
    UILabel *label_jiantou9;
    UILabel *label_jiantou10;
    UILabel *label_jiantou11;
    UILabel *label_jiantou12;
    UILabel *label_jiantou13;
    UILabel *label_jiantou14;
    
    UIButton *btn_gerenziliao;
    UIButton *btn_youxiandianshixinxi;
    UIButton *btn_cheliangxinxi;
    UIButton *btn_tianjiaxinzhuzhi;
    UIButton *btn_yajuyuan;
    UIButton *btn_wodexiaolianbi;
    UIButton *btn_xiaolianbishangcheng;
    UIButton *btn_wodexiaoxi;
    UIButton *btn_wodehuifu;
    UIButton *btn_wodeshoucang;
    UIButton *btn_wodetiezi;
    UIButton *btn_wodeyujiaofei;
    UIButton *btn_wodezhangdan;
    UIButton *btn_zhuxiao;
    UIButton *btn_xiugaimima;
    UIButton *btn_queding;
    UIButton *btn_quxiao;
    NSArray *arr_info;
    NSMutableArray *arr_zhuzhi;
    UIView *beijing_view;
    NSString *sss;
    NSString *str_zhuzhi;
    NSString *str_address_id;
}

@end
