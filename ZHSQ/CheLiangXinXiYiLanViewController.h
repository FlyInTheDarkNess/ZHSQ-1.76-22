//
//  CheLiangXinXiYiLanViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheLiangXinXiYiLanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mytableview;
    UILabel *label_title;
    UILabel *label_PromptInformation;
    UIButton *btn_fanhui;
    UIButton *btn_tianjia;
    NSArray *arr_Car;
}

@end
