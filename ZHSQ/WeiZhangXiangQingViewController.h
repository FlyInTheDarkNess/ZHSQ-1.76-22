//
//  WeiZhangXiangQingViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-9-25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiZhangXiangQingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mytableview;
    UILabel *label_title;
    UIButton *btn_fanhui;
    UILabel *label_chepai;
    NSArray *arr;
}



@end
