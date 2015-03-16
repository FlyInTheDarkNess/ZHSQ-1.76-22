//
//  FuWuYingYongXiangQingViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-7-22.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fuwushangjiaxiangxi.h"

@interface FuWuYingYongXiangQingViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UILabel *label_title;
    UIButton *fanhui;
    UIButton *xuanze;
    UIButton *dingwei;
    UIScrollView *myscrollview;
    UIButton *fabiao;
    UILabel *label;
    UILabel *label_biaoti;
    UILabel *label_jibie;
    UILabel *label_jibie_tu;
    UILabel *label_dizhi;
    UILabel *label_dianhua1;
    UILabel *label_dianhua2;
    UILabel *label_yewu;
    UILabel *label_dianjiaxiangxi;
    UILabel *label_zhuyingxiangmu;
    UILabel *label_fankuipinglun;
    UILabel *label_pinglun;
    UITableView *mytableview;
    NSArray *arr_pinglun;
    int h;
    fuwushangjiaxiangxi *fwxq;
}

@end
