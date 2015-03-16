//
//  ShangJiaXinXiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fuwushangjiaxiangxi.h"

@interface ShangJiaXinXiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *label_title;
    UIButton *fanhui;
    UIButton *xuanze;
    UIButton *dingwei;
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
    int g;
    fuwushangjiaxiangxi *fwxq;

}

@end
