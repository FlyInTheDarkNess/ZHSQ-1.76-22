//
//  SwitchAddressViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-14.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "MyMD5.h"
@interface SwitchAddressViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UIImageView *image;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    NSMutableArray *arr_zhuzhi;
    NSString *sss;
    NSString *str_zhuzhi;
    NSString *str_address_id;
    NSString *mima;
    NSArray *arr_info;
    NSMutableArray *arr_addressidentify;
}

@property (nonatomic,assign) NSInteger type;// 0 切换 1 删除


@end
