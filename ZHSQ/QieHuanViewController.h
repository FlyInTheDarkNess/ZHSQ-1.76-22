//
//  QieHuanViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-29.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QieHuanZhuZhiXinXi.h"
#import "PushAlertViewDelegate.h"
#import "MyMD5.h"
@interface QieHuanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    id<PushAlertViewDelegate> delegate;
    UITableView *mytableview;
    NSMutableArray *arr_zhuzhi;
    NSString *sss;
    NSString *str_zhuzhi;
    NSString *str_address_id;
    NSArray *arr_info;
    NSMutableArray *arr_addressidentify;
    NSString *mima;
}
@property (nonatomic, assign) id<PushAlertViewDelegate> delegate_;

@end
