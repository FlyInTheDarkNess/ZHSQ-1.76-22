//
//  YouHuiZiXunViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouHuiZiXunViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UIButton *btn_fanhui;
    UILabel *label_title;
    UIImageView *image_beijing;
    NSMutableArray *Array;
    NSMutableArray *arr;
    NSArray *workItemss;
    UIImageView *imageview;
}

@end
