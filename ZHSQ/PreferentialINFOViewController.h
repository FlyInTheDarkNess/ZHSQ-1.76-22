//
//  PreferentialINFOViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-8.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface PreferentialINFOViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UIImageView *image;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;

}


@end
