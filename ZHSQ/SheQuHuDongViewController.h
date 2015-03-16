//
//  SheQuHuDongViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-7-28.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheQuHuDong.h"
#import "SheQuHuDongZhuJian.h"

#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"

@interface SheQuHuDongViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>
{
    NSDictionary *m_emojiDic;

    UITableView *tableview;
    UIImageView *image;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    NSMutableData *receiveData;
    NSMutableArray *arr;
    NSMutableArray *arr2;
    SheQuHuDong *customers;
    NSArray *workItemss;
    UIButton *fatie;
    int zhuangtai;
    int gaodu;
    
}


@end
