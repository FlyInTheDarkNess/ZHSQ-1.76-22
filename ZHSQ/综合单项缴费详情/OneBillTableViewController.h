//
//  OneBillTableViewController.h
//  ZHSQ
//
//  Created by lacom on 15/3/16.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneBillTableViewController : UITableViewController

/*
 账单信息
 */
@property (nonatomic,strong) NSDictionary *detailDic;
/*
 账单类型
 1 水费
 2 物业费
 3 暖气费
 4 停车费
 */
@property (nonatomic,assign) NSInteger billType;

@end
