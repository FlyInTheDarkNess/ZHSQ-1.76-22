//
//  XiTongSheZhiViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "XiTongSheZhiViewController.h"
#import "GuanYuWoMenViewController.h"
@interface XiTongSheZhiViewController ()

@end

@implementation XiTongSheZhiViewController

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
    label_biejing.layer.borderColor=[UIColor lightGrayColor].CGColor;
    label_biejing.layer.borderWidth=1;
    label_biejing.layer.cornerRadius=7;
    label_banbenhao.text=[NSString stringWithFormat:@"当前版本:%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    label_banbenhao.textAlignment=NSTextAlignmentRight;
    label_banbenhao.textColor=[UIColor grayColor];
    
    Btn_tuisong=[[UIButton alloc]initWithFrame:CGRectMake(260, 135, 30, 30)];
    [Btn_tuisong addTarget:self action:@selector(kaiqituisong) forControlEvents:UIControlEventTouchUpInside];
    [Btn_tuisong setImage:[UIImage imageNamed:@"checno.png"] forState:UIControlStateNormal];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"qiyongtuisong"];
    if (myString.length==0)
    {
        str_tuisong=@"yes";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:str_tuisong forKey:@"qiyongtuisong"];
        
    }
    else
    {
        if ([myString isEqualToString:@"yes"])
        {
            [Btn_tuisong setImage:[UIImage imageNamed:@"chec.png"] forState:UIControlStateNormal];

        }
        else if ([myString isEqualToString:@"no"])
        {
            [Btn_tuisong setImage:[UIImage imageNamed:@"checno.png"] forState:UIControlStateNormal];
            
        }
    }
    [self.view addSubview:Btn_tuisong];
}
-(void)kaiqituisong
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"qiyongtuisong"];
    if ([myString isEqualToString:@"yes"])
    {
        str_tuisong=@"no";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:str_tuisong forKey:@"qiyongtuisong"];
        [Btn_tuisong setImage:[UIImage imageNamed:@"chec.png"] forState:UIControlStateNormal];
        NSLog(@"启用推送");
    }
    if ([myString isEqualToString:@"no"])
    {
        str_tuisong=@"yes";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:str_tuisong forKey:@"qiyongtuisong"];
        [Btn_tuisong setImage:[UIImage imageNamed:@"checno.png"] forState:UIControlStateNormal];
        NSLog(@"关闭推送");

        
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fanhui:(id)sender {
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
