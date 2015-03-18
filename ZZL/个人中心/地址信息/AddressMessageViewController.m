//
//  AddressMessageViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-29.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AddressMessageViewController.h"
#import "ShanChuViewController.h"
#import "ZhuZhiXinXiViewController.h"
#import "QieHuanViewController.h"
#import "SwitchAddressViewController.h"
#import "AddHomeAddressViewController.h"
@interface AddressMessageViewController ()

@end

@implementation AddressMessageViewController
@synthesize Btn_QieHuan,Btn_ShanChu,Btn_TianJia;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    Btn_TianJia.layer.masksToBounds = YES;
    Btn_TianJia.layer.cornerRadius = 5;
    Btn_TianJia.layer.borderWidth = 0.5;
    Btn_TianJia.layer.borderColor=[[UIColor grayColor] CGColor];

    Btn_ShanChu.layer.masksToBounds = YES;
    Btn_ShanChu.layer.cornerRadius = 5;
    Btn_ShanChu.layer.borderWidth = 0.5;
    Btn_ShanChu.layer.borderColor=[[UIColor grayColor] CGColor];

    Btn_QieHuan.layer.masksToBounds = YES;
    Btn_QieHuan.layer.cornerRadius = 5;
    Btn_QieHuan.layer.borderWidth = 0.5;
    Btn_QieHuan.layer.borderColor=[[UIColor grayColor] CGColor];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 切换地址
 */
- (IBAction)qiehuan:(id)sender
{
    SwitchAddressViewController *qiehuan=[[SwitchAddressViewController alloc]init];
    [self presentViewController:qiehuan animated:NO completion:nil];
}

/*
 添加地址
 */
- (IBAction)tianjia:(id)sender
{
//    ZhuZhiXinXiViewController *xinxi=[[ZhuZhiXinXiViewController alloc]init];
//    [self presentViewController:xinxi animated:YES completion:nil];
    AddHomeAddressViewController *xinxi=[[AddHomeAddressViewController alloc]init];
    [self presentViewController:xinxi animated:YES completion:nil];

}


- (IBAction)fanhui:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
//IOS 6.0 以上禁止横屏
- (BOOL)shouldAutorotate
{
    return NO;
}
//IOS 6.0 以下禁止横屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end
