//
//  shouyeViewController.h
//  ZHSQ
//
//  Created by lacom on 14-4-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
#import "ZhaiHuimimaViewController.h"
#import "MyMD5.h"
#import "PushAlertViewDelegate.h"
@interface shouyeViewController : UIViewController<UITextFieldDelegate,QCheckBoxDelegate>
{
    id<PushAlertViewDelegate> delegate;
    
    UILabel *label_title;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label_zidong;
    UIButton *fanhui;
    UIButton *zhuceBtn;
    UIButton *dengluBtn;
    UIButton *zhaohui_mima;
    UIButton *zidongdenglu;
    UIButton *Btn_Tourist;
    ZhaiHuimimaViewController *viewcontrol;
    NSString *mobileNum;
    NSString *mima;
    
    NSString *str_zidongdenglu;
    NSMutableArray *arr_info;
    NSMutableArray *arr_addressidentify;
    BOOL y;
}

@property (strong, nonatomic) UITextField *ZhangHaoTextField;
@property (strong, nonatomic) UITextField *MiMaTextField;
@property (strong, nonatomic) UIButton *zhaohuimima;
@property (nonatomic, assign) id<PushAlertViewDelegate> delegate_;
//@property(nonatomic,assign)BOOL isFristIn;//判断登陆界面
@end
