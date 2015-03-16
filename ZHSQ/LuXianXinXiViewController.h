//
//  LuXianXinXiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-9-23.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LuXianXinXiViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *label_title;
    UIButton *btn_fanhui;
    UITableView *mytableview;
    NSArray  * array;
}

@end
