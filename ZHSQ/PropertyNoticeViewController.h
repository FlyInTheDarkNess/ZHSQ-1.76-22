//
//  PropertyNoticeViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-6.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "xinjian.h"
@interface PropertyNoticeViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *image;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    UIButton *wuyeBtn;
    UIButton *shequBtn;
    
    
}
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (nonatomic, strong) UITableView *tableview;
@end
