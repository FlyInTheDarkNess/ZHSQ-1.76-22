//
//  WoDeShuiFei_WeiJiaoViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
@interface WoDeShuiFei_WeiJiaoViewController : UIViewController<QCheckBoxDelegate>
{
    UILabel *label;
    IBOutlet UIButton *btn_jiaofei;
}
@property (weak, nonatomic) IBOutlet UILabel *label_shangcishuibiaoshu;
@property (weak, nonatomic) IBOutlet UILabel *label_bencishuibiaoshu;

@property (weak, nonatomic) IBOutlet UILabel *label_danbeibianhao;
@property (weak, nonatomic) IBOutlet UILabel *label_shoufeidanwei;
@property (weak, nonatomic) IBOutlet UILabel *label_kehuxingming;
@property (weak, nonatomic) IBOutlet UILabel *label_kehudizhi;
@property (weak, nonatomic) IBOutlet UILabel *label_jianzhumianji;
@property (weak, nonatomic) IBOutlet UILabel *label_danjia;
@property (weak, nonatomic) IBOutlet UILabel *label_xufeiqijian;
@property (weak, nonatomic) IBOutlet UILabel *label_wuyefei;
@property (weak, nonatomic) IBOutlet UILabel *label_youhuijine;
@property (weak, nonatomic) IBOutlet UILabel *label_yingjiaojine;
- (IBAction)fanhui:(id)sender;


@end
