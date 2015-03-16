//
//  GengDuoViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-23.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "GengDuoViewController.h"
#import "Pay ViewController.h"
#import "XiTongSheZhiViewController.h"
#import "OpinionsFeedbackViewController.h"
#import "Header.h"
extern NSString *SheQuFuWu_Title;
extern NSString *Payment_url;
@interface GengDuoViewController ()

@end

@implementation GengDuoViewController

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
    //self.view.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.33];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    //CGFloat Hidth=size.height;//Hidth 屏幕高度

    label_TitleBackground=[[UILabel alloc]initWithFrame:CGRectMake(0,0,Width,60)];
    label_TitleBackground.backgroundColor=[UIColor colorWithRed:234/255.0 green:87/255.0 blue:83/255.0 alpha:1];
    [self.view addSubview:label_TitleBackground];
    
    label_Title=[[UILabel alloc]initWithFrame:CGRectMake(0,20,Width,40)];
    label_Title.text=@"更多";
    label_Title.textColor=[UIColor whiteColor];
    label_Title.textAlignment=NSTextAlignmentCenter;
    [label_Title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self.view addSubview:label_Title];
    
    label_SystemSetting=[[UILabel alloc]initWithFrame:CGRectMake(53,94,250,21)];
    label_SystemSetting.text=@"系统设置";
    label_SystemSetting.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label_SystemSetting];
    
    label_OpinionsFeedback=[[UILabel alloc]initWithFrame:CGRectMake(53,154,250,21)];
    label_OpinionsFeedback.text=@"意见反馈";
    label_OpinionsFeedback.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label_OpinionsFeedback];
    
    label_AboutUs=[[UILabel alloc]initWithFrame:CGRectMake(53,207,250,21)];
    label_AboutUs.text=@"关于我们";
    label_AboutUs.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label_AboutUs];
    
    label_DetectionUpdate=[[UILabel alloc]initWithFrame:CGRectMake(53,267,250,21)];
    label_DetectionUpdate.text=@"检测更新";
    label_DetectionUpdate.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label_DetectionUpdate];
    
    
    imageview_SystemSetting=[[UIImageView alloc]initWithFrame:CGRectMake(20,90,30,30)];
    imageview_SystemSetting.image=[UIImage imageNamed:@"p033_更多_系统设置.png"];
    [self.view addSubview:imageview_SystemSetting];
    
    imageview_OpinionsFeedback=[[UIImageView alloc]initWithFrame:CGRectMake(20,150,30,30)];
    imageview_OpinionsFeedback.image=[UIImage imageNamed:@"p034_更多_意见反馈.png"];
    [self.view addSubview:imageview_OpinionsFeedback];

    imageview_AboutUs=[[UIImageView alloc]initWithFrame:CGRectMake(20,203,30,30)];
    imageview_AboutUs.image=[UIImage imageNamed:@"p035_更多_关于我们.png"];
    [self.view addSubview:imageview_AboutUs];

    imageview_DetectionUpdate=[[UIImageView alloc]initWithFrame:CGRectMake(20,263,30,30)];
    imageview_DetectionUpdate.image=[UIImage imageNamed:@"p036_更多_检测更新.png"];
    [self.view addSubview:imageview_DetectionUpdate];



    
    Btn_SystemSetting=[[UIButton alloc]initWithFrame:CGRectMake(10,80,300,50)];
    Btn_SystemSetting.backgroundColor=[UIColor clearColor];
    [Btn_SystemSetting setTitle:@"                                         > " forState:UIControlStateNormal];
    [Btn_SystemSetting setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    Btn_SystemSetting.titleLabel.textAlignment=NSTextAlignmentRight;
    Btn_SystemSetting.titleLabel.font=[UIFont systemFontOfSize:20];
    Btn_SystemSetting.layer.masksToBounds = YES;
    Btn_SystemSetting.layer.borderWidth = 0.5;
    Btn_SystemSetting.layer.borderColor=[[UIColor grayColor] CGColor];
    [Btn_SystemSetting addTarget:self action:@selector(SystemSetting) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn_SystemSetting];

    Btn_OpinionsFeedback=[[UIButton alloc]initWithFrame:CGRectMake(10,140,300,50)];
    Btn_OpinionsFeedback.backgroundColor=[UIColor clearColor];
    [Btn_OpinionsFeedback setTitle:@"                                         > " forState:UIControlStateNormal];
    [Btn_OpinionsFeedback setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    Btn_OpinionsFeedback.titleLabel.textAlignment=NSTextAlignmentRight;
    Btn_OpinionsFeedback.titleLabel.font=[UIFont systemFontOfSize:20];
    Btn_OpinionsFeedback.layer.masksToBounds = YES;
    Btn_OpinionsFeedback.layer.borderWidth = 0.5;
    Btn_OpinionsFeedback.layer.borderColor=[[UIColor grayColor] CGColor];
    [Btn_OpinionsFeedback addTarget:self action:@selector(OpinionsFeedback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn_OpinionsFeedback];
    
    Btn_AboutUs=[[UIButton alloc]initWithFrame:CGRectMake(10,189.5,300,50)];
    Btn_AboutUs.backgroundColor=[UIColor clearColor];
    [Btn_AboutUs setTitle:@"                                         > " forState:UIControlStateNormal];
    [Btn_AboutUs setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    Btn_AboutUs.titleLabel.textAlignment=NSTextAlignmentRight;
    Btn_AboutUs.titleLabel.font=[UIFont systemFontOfSize:20];
    Btn_AboutUs.layer.masksToBounds = YES;
    Btn_AboutUs.layer.borderWidth = 0.5;
    Btn_AboutUs.layer.borderColor=[[UIColor grayColor] CGColor];
    [Btn_AboutUs addTarget:self action:@selector(AboutUs) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn_AboutUs];
    
    Btn_DetectionUpdate=[[UIButton alloc]initWithFrame:CGRectMake(10,250,300,50)];
    Btn_DetectionUpdate.backgroundColor=[UIColor clearColor];
    [Btn_DetectionUpdate setTitle:@"                                         > " forState:UIControlStateNormal];
    [Btn_DetectionUpdate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    Btn_DetectionUpdate.titleLabel.textAlignment=NSTextAlignmentRight;
    Btn_DetectionUpdate.titleLabel.font=[UIFont systemFontOfSize:20];
    Btn_DetectionUpdate.layer.masksToBounds = YES;
    Btn_DetectionUpdate.layer.borderWidth = 0.5;
    Btn_DetectionUpdate.layer.borderColor=[[UIColor grayColor] CGColor];
    [Btn_DetectionUpdate addTarget:self action:@selector(DetectionUpdate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn_DetectionUpdate];
    
    Btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0,20,40,40)];
    [Btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [Btn_fanhui setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn_fanhui];
    
    Btn_Exit=[[UIButton alloc]initWithFrame:CGRectMake(10,340,300,50)];
    [Btn_Exit setBackgroundImage:[UIImage imageNamed:@"p退出.png"] forState:UIControlStateNormal];
    [Btn_Exit setTitle:@"退出" forState:UIControlStateNormal];
    [Btn_Exit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Btn_Exit addTarget:self action:@selector(Exit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn_Exit];

}
-(void)SystemSetting
{
    
}
-(void)OpinionsFeedback
{
    }
-(void)AboutUs
{
    

}
-(void)DetectionUpdate
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}


- (void)Exit
{
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]) exitApplication];
}
@end
