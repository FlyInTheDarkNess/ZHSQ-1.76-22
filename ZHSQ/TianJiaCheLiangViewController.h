//
//  TianJiaCheLiangViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TianJiaCheLiangViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr1;
    NSArray *arr2;
    NSString *str;
    UITableView *mytableview;
}
@property (weak, nonatomic) IBOutlet UILabel *label_zhuzhi;
@property (weak, nonatomic) IBOutlet UIButton *btn_cheliangxinghao;
@property (weak, nonatomic) IBOutlet UITextField *textfield_chepaihao;
@property (weak, nonatomic) IBOutlet UITextField *textfield_shibiema;
@property (weak, nonatomic) IBOutlet UILabel *label_beijing;
@property (weak, nonatomic) IBOutlet UIButton *btn_jiancheng;
- (IBAction)btn_fanhui:(id)sender;
- (IBAction)btn_wancheng:(id)sender;
- (IBAction)xuanzeqicheleixing:(id)sender;

@end
