//
//  ZhuCeViewController.h
//  ZHSQ
//
//  Created by lacom on 14-4-11.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
#import "zhuce.h"
#import "zhuce_mima.h"
@interface ZhuCeViewController : UIViewController<UITextFieldDelegate,QCheckBoxDelegate>
{
    UILabel *label_title;
    UILabel *label_shijian;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
    UILabel *label6;
    UIButton *fanhui;
    UIButton *zhuceBtn;
    UIButton *yanzhengma;
    NSTimer *timer;
    NSTimer *m_pTimer;
    NSDate *m_pStartDate;
    UILabel *label;
    int i;
    NSMutableData *resultData;
    NSMutableArray *arr;
    NSMutableArray *arr2;
    
    NSArray *workItemss;
    NSString *shuzu;
    NSString *mobileNum;
    NSString *str_device;
    NSString *mima;
}

@property (strong, nonatomic) UITextField *ZhangHaoTextField;
@property (strong, nonatomic) UITextField *yanzhengmaTextField;
@property (strong, nonatomic) UITextField *MiMaTextField;
@property (strong, nonatomic) UITextField *querenMiMaTextField;



@end
