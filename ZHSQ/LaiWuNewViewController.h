//
//  LaiWuNewViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-9.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "MoviePlayerViewController.h"

@interface LaiWuNewViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate,MoviePlayerViewControllerDataSource>
{
    UITableView *tableview;
    UIImageView *image;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    UILabel *label_columns_introduction;
    UILabel *label_first_play_time;
    UILabel *label_repeat_play_time;
    NSString *video_url;
    
}


@end
