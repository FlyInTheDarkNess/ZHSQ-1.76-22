//
//  CheLiangXinXiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheLiangXinXiViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *arr1;
    NSArray *arr2;
    UITableView *mytableview;
    NSString *str;
}
@property (weak, nonatomic) IBOutlet UILabel *label_zhuzhi;
@property (weak, nonatomic) IBOutlet UILabel *label_chepaohao;
@property (weak, nonatomic) IBOutlet UILabel *label_beijing;
@property (weak, nonatomic) IBOutlet UIButton *btn_qicheleixing;
@property (weak, nonatomic) IBOutlet UITextField *textfield_shibiema;
- (IBAction)btn_fanhui:(id)sender;
- (IBAction)btn_wancheng:(id)sender;
- (IBAction)xuanzeqicheleixing:(id)sender;

@end
