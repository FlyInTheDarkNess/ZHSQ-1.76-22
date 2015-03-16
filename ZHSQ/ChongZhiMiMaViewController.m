//
//  ChongZhiMiMaViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ChongZhiMiMaViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "shouyeViewController.h"
#import "MBProgressHUD.h"
extern NSString *str;
@interface ChongZhiMiMaViewController ()

@end

@implementation ChongZhiMiMaViewController

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
    label=[[UILabel alloc]initWithFrame:CGRectMake(50, 280, 200, 30)];
    label.text=@"后自动返回登录页面";
    [self.view addSubview:label];
    
    
    DaoJiShiBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 280, 30, 30)];
    DaoJiShiBtn.backgroundColor=[UIColor colorWithRed:240/255.0 green:248/255.0 blue:255/255.0 alpha:1];
    [DaoJiShiBtn addTarget:self action:@selector(dianji) forControlEvents:UIControlEventTouchUpInside];
    DaoJiShiBtn.layer.masksToBounds = YES;
    DaoJiShiBtn.layer.cornerRadius = 3;
    DaoJiShiBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [DaoJiShiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    DaoJiShiBtn.layer.borderWidth = 0.2;
    [self.view addSubview:DaoJiShiBtn];
    
    m_pTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                target:self
                                              selector:@selector(calcuRemainTime)
                                              userInfo:nil
                                               repeats:YES];
    //开始时间获取
    m_pStartDate = [NSDate date];
    [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(tiaozhuan) userInfo:nil repeats:NO];
}



-(void)tiaozhuan
{
    shouyeViewController *shouyeviewcontrol=[[shouyeViewController alloc]init];
    [self presentViewController:shouyeviewcontrol animated:NO completion:nil];
}
- (void)showWithCustomView:(NSString*)aString {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

-(void)dianji
{
    m_pTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(calcuRemainTime)userInfo:nil repeats:YES];
    //开始时间获取
    m_pStartDate = [NSDate date];
    
    [self calcuRemainTime];
}
#define TOTAL_TIME 4
- (void)calcuRemainTime
{
	double deltaTime = [[NSDate date] timeIntervalSinceDate:m_pStartDate];
    
    //    NSLog(@"%.f",deltaTime);
    //    NSLog(@"%d",(int)(deltaTime+0.5));
  	int remainTime = TOTAL_TIME - (int)(deltaTime+0.5) ;
    
	if (remainTime < 0.0)
	{
		[m_pTimer invalidate];
		
		//TODO:
		//game over
		return;
	}
	[self showTime:remainTime];
	
}

/*
 *在视图中显示时间
 */
- (void)showTime:(int)time
{
	int inputSeconds = (int)time;
	int hours =  inputSeconds / 3600;
	int minutes = ( inputSeconds - hours * 3600 ) / 60;
	int seconds = inputSeconds - hours * 3600 - minutes * 60;
	
	//NSString *strTime = [NSString stringWithFormat:@"%.2d:%.2d:%d",hours,minutes, seconds];
	
	//显示在文本视图中
	//label.text=strTime;
    
	NSString *strTime2 = [NSString stringWithFormat:@"%d秒",seconds];
    [DaoJiShiBtn setTitle:strTime2 forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
