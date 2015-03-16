//
//  XuanZeChengShiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-8-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XuanZeChengShiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tab;
    UILabel *label_title;
    UIButton *fanhui;
    NSMutableArray *arr;
}

@end
