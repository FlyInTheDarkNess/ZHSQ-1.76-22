//
//  ZHMyMessageViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-24.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "ZHMyMessageService.h"
@interface ZHMyMessageViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    //新闻ID
    NSArray *idList;
    //请求
    ZHMyMessageService  *sqLtHttpSer;
    //当前列表数据
    NSMutableArray *postArr;
    
    int startIndex;
    
    BOOL isUp;
    UIImageView *imageview;
    UILabel *label_title;
    UIButton *btn_fanhui;

}
@property (nonatomic,strong) UITableView *MyMessageTableView;

@end
