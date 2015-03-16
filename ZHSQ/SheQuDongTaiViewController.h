//
//  SheQuDongTaiViewController.h
//  ZHSQ
//
//  Created by lacom on 14-6-17.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQDT.h"
@interface SheQuDongTaiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UILabel *label;
    UIButton *button;
    UIButton *wuyeBtn;
    UIButton *shequBtn;
    NSMutableData *receiveData;
    NSMutableArray *arr;
    NSMutableArray *arr2;
    SQDT *customers;
    NSArray *workItemss;
    
    UIImageView *image;
    UILabel *labelline;
    


}

@end
