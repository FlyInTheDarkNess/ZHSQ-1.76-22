//
//  MyFaceMoneyViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-26.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface MyFaceMoneyViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
}
@property (weak, nonatomic) IBOutlet UILabel *NoResult_label;
@property (weak, nonatomic) IBOutlet UIButton *dianjishuaxin_btn;

@property (weak, nonatomic) IBOutlet UILabel *zongshu_label;
@property (weak, nonatomic) IBOutlet UIButton *huoqu_btn;
@property (weak, nonatomic) IBOutlet UIButton *xiaofei_btn;
- (IBAction)fanhui:(id)sender;
- (IBAction)huoqu:(id)sender;
- (IBAction)xiaofei:(id)sender;
- (IBAction)dianjishuaxin:(id)sender;
- (IBAction)xiaolianbigonglue:(id)sender;

@end
