//
//  WeiZhangChaXunViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-9-24.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiZhangChaXunViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIView *view_beijing;
    UITableView *tableview_qichezhonglei;
    UITableView *tableview_diyu;
    __weak IBOutlet UIButton *btn_diming;
    
    __weak IBOutlet UIButton *btn_chaxun;
    __weak IBOutlet UIButton *btn_qichezhonglei;
    __weak IBOutlet UILabel *label_beijing;
    __weak IBOutlet UILabel *label_laiwushi;
    NSMutableArray *arr;
    NSMutableArray *arr2;
    NSString *str_leixing;
}

- (IBAction)fanhui:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfiled_haoma;
@property (weak, nonatomic) IBOutlet UITextField *textfiled_shibiema;
- (IBAction)xuanzezhonglei:(id)sender;
- (IBAction)diming:(id)sender;
- (IBAction)chaxun:(id)sender;

@end
