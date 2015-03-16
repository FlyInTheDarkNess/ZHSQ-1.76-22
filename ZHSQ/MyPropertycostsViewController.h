//
//  MyPropertycostsViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-21.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface MyPropertycostsViewController : AXHBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    UIImageView *image;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
}


@end
