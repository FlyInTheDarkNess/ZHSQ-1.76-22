//
//  SheQuHuDongXiangQingViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-7-29.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuHuDong_pinglunID.h"
#import "SheQuHuDong_pinglunxinxi.h"
#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"

@interface SheQuHuDongXiangQingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>
{
    NSDictionary *m_emojiDic;

    UITableView *DataTable;
    UILabel *label;
    UILabel *label_beijing;
    UIButton *fanhui_btn;
    UIButton *fenxiang_btn;
    UIButton *fatie;
    NSMutableData *receiveData;
    NSMutableArray *arr;
    NSMutableArray *arr2;
    int g;
    int gaodu;
    UILabel *Titlecount;
}

@end
