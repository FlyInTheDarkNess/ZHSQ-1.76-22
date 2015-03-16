//
//  ChangTuKeYunViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-11.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangTuKeYunXiangQing_ChangTuViewController.h"
#import "ChangTuKeYunXiangQing_ChengXiangViewController.h"
#import "ChangTuKeYunXiangQing_GuoLuViewController.h"
#import "ChangTuKeYunXiangQing_ShiNeiViewController.h"

@interface ChangTuKeYunViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mytableview;
    UILabel *label_title;
    UILabel *hengxian;
    UILabel *biaoxian;
    UIButton *fanhui;
    UIButton *btn_changtu;
    UIButton *btn_guolu;
    UIButton *btn_shinei;
    UIButton *btn_chengxiang;
    NSMutableArray *Array;
    NSMutableArray *Array_changtu;
    NSMutableArray *Array_guolu;
    NSMutableArray *Array_shinei;
    NSMutableArray *Array_chengxiang;
    int i;
    ChangTuKeYunXiangQing_ChangTuViewController *changtu;
    ChangTuKeYunXiangQing_GuoLuViewController *guolu;
    ChangTuKeYunXiangQing_ShiNeiViewController *shinei;
    ChangTuKeYunXiangQing_ChengXiangViewController *chengxiang;

}

@end
