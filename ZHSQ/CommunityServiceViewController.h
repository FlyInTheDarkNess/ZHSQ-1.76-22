//
//  CommunityServiceViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "fuwu.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface CommunityServiceViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>
{
    UITableView*tableview_fanwei;
    UITableView*tableview_fenlei;
    UITableView*tableview_paixu;
    UITableView*tableview_shangjia;
    
    UIButton *btn_fanwei;
    UIButton *btn_fenlei;
    UIButton *btn_paixu;
    NSMutableArray *arr_fanwei;
    NSMutableArray *arr_fenlei;
    NSMutableArray *arr_paixu;
    NSMutableArray *arr_shangjialiebiao;
    
    UILabel *label_fanwei;
    UILabel *label_fenlei;
    UILabel *label_paixu;
    fuwu *fuwu_str;
    UIButton *fanhui;
    UILabel *label_title;
    NSString *fanwei;
    NSString *neirong;
    NSString *paixu;
    NSString *jingdu;
    NSString *weidu;
    
}
@property(nonatomic, strong) CLLocationManager *locationManager;


@end
