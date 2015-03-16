//
//  CommunityNoticeViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-6.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface CommunityNoticeViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *image;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    UIButton *wuyeBtn;
    UIButton *shequBtn;
}

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGestureRecognizer;
@property (nonatomic, strong) UITableView *tableview;


@end
