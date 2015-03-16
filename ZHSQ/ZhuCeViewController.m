//
//  ZhuCeViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-11.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ZhuCeViewController.h"
#import "Pay ViewController.h"

#import "DengLuHouZhuYeViewController.h"
#import "MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "MyMD5.h"
#import "URL.h"
#import "JiaMiJieMi.h"
extern NSString *SheQuFuWu_Title;
extern NSString *Payment_url;

@interface ZhuCeViewController ()


@end

@implementation ZhuCeViewController
@synthesize ZhangHaoTextField,MiMaTextField,yanzhengmaTextField,querenMiMaTextField;

- (void)loadView
{
    @try
    {

    [super loadView];
    self.view.backgroundColor=[UIColor whiteColor];
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label_title.text=@"注册";
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 40, 40)];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    label1=[[UILabel alloc]initWithFrame:CGRectMake(15, 90, 290, 80)];
    label1.layer.cornerRadius = 5;
    label1.layer.borderColor = [UIColor grayColor].CGColor;
    label1.layer.borderWidth = 0.5;
    [self.view addSubview:label1];
    label2=[[UILabel alloc]initWithFrame:CGRectMake(20, 130, 280, 1)];
    label2.backgroundColor=[UIColor grayColor];
    [self.view addSubview:label2];
    label3=[[UILabel alloc]initWithFrame:CGRectMake(15, 90, 50, 40)];
    label3.textAlignment=NSTextAlignmentCenter;
    label3.text=@"账  户:";
    label3.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label3];
    label4=[[UILabel alloc]initWithFrame:CGRectMake(15, 130, 50, 40)];
    label4.textAlignment=NSTextAlignmentCenter;
    label4.text=@"验证码:";
    label4.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label4];
    
    ZhangHaoTextField=[[UITextField alloc]init];
    //ZhangHaoTextField.borderStyle=UITextBorderStyleRoundedRect;
    ZhangHaoTextField.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    ZhangHaoTextField.frame=CGRectMake(65, 95, 240, 30);
    ZhangHaoTextField.delegate=self;
    ZhangHaoTextField.placeholder=@"请输入手机号";
    [self.view addSubview:ZhangHaoTextField];
    yanzhengmaTextField=[[UITextField alloc]init];
    //MiMaTextField.borderStyle=UITextBorderStyleRoundedRect;
    yanzhengmaTextField.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    yanzhengmaTextField.frame=CGRectMake(65, 135, 130, 30);
    
    yanzhengmaTextField.delegate=self;
    yanzhengmaTextField.placeholder=@"请输入验证码";
    [self.view addSubview:yanzhengmaTextField];
    
    yanzhengma=[[UIButton alloc]initWithFrame:CGRectMake(220, 135, 80, 30)];
    [yanzhengma setTitle:@"获取验证码" forState:UIControlStateNormal];
    [yanzhengma setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    yanzhengma.titleLabel.font=[UIFont systemFontOfSize: 14.0];
    [yanzhengma addTarget:self action:@selector(huoquyanzhengma) forControlEvents:UIControlEventTouchUpInside];
    yanzhengma.layer.masksToBounds = YES;
    yanzhengma.layer.cornerRadius = 3;
    yanzhengma.layer.borderWidth = 0.5;
    yanzhengma.layer.borderColor=[[UIColor grayColor] CGColor];
    
    [self.view addSubview:yanzhengma];
    
    label5=[[UILabel alloc]initWithFrame:CGRectMake(15, 190, 80, 20)];
    label5.text=@"请输入密码";
    label5.textColor=[UIColor grayColor];
    label5.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label5];
    MiMaTextField=[[UITextField alloc]initWithFrame:CGRectMake(15, 220, 290, 30)];
    MiMaTextField.placeholder=@"请输入6-20位字符密码";
    MiMaTextField.layer.borderWidth =0.5;
    MiMaTextField.secureTextEntry = YES;
    MiMaTextField.delegate=self;
    MiMaTextField.layer.borderColor=[[UIColor grayColor] CGColor];
    MiMaTextField.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:MiMaTextField];
    
    label6=[[UILabel alloc]initWithFrame:CGRectMake(15, 260, 180, 20)];
    label6.text=@"请再次输入密码";
    label6.textColor=[UIColor grayColor];
    label6.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label6];
    
    querenMiMaTextField=[[UITextField alloc]initWithFrame:CGRectMake(15, 290, 290, 30)];
    querenMiMaTextField.delegate=self;
    querenMiMaTextField.secureTextEntry = YES;
    querenMiMaTextField.placeholder=@"请再次输入密码";
    querenMiMaTextField.layer.borderWidth =0.5;
    querenMiMaTextField.layer.borderColor=[[UIColor grayColor] CGColor];
    querenMiMaTextField.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:querenMiMaTextField];
    zhuceBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,370, 290, 35)];
    [zhuceBtn setTitle:@"注册" forState:UIControlStateNormal];
    [zhuceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    zhuceBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    zhuceBtn.layer.masksToBounds = YES;
    zhuceBtn.layer.cornerRadius = 5;
    zhuceBtn.layer.borderWidth = 0.5;
    zhuceBtn.layer.borderColor=[[UIColor grayColor] CGColor];
    [zhuceBtn addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuceBtn];
    
    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.frame = CGRectMake(15, 320, 280, 40);
    [_check1 setTitle:@"我已经同意用户协议" forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [_check1 setImage:[UIImage imageNamed:@"payeco_plugin_checkbox_normal.png"] forState:UIControlStateNormal];
    [_check1 setImage:[UIImage imageNamed:@"payeco_plugin_checkbox_checked.png"] forState:UIControlStateSelected];
    [self.view addSubview:_check1];
    [_check1 setChecked:YES];
    
    label_shijian=[[UILabel alloc]initWithFrame:CGRectMake(260, 180, 60, 20)];

    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"错误"
         message: [[NSString alloc] initWithFormat:@"%@",e]
         delegate:self
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    i=0;
    UIDevice *device_=[[UIDevice alloc] init];
    str_device=device_.identifierForVendor.UUIDString;

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    
    if (i>=2)
    {
       if (i%2==0)
       {
           SheQuFuWu_Title=@"关于我们";
           Payment_url=@"http://www.xiaolianshequ.cn/download/clause.html";
           Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
           [self presentViewController:subViewVCtr animated:NO completion:nil];

       }
    }
    i++;
    
  
}
-(void)zhuce
{
    @try
    {
    [self.view endEditing:YES];
    __block ZhuCeViewController *bSelf=self;
    [UIView animateWithDuration:0.25 animations:^{
        bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
    }];
    if (!ZhangHaoTextField.text||ZhangHaoTextField.text == nil||[ZhangHaoTextField.text isEqualToString:@""]) {
        [self showWithCustomView:@"手机号为空,请输入"];
        return;
    }
    else
    {
        if (!yanzhengmaTextField.text||yanzhengmaTextField.text == nil||[yanzhengmaTextField.text isEqualToString:@""])
        {
            [self showWithCustomView:@"验证码为空,请输入"];
            return;
        }
        else
        {
            if (!MiMaTextField.text||MiMaTextField.text == nil||[MiMaTextField.text isEqualToString:@""])
            {
                [self showWithCustomView:@"请输入新的密码"];
                return;
            }
            else
            {
                if (5<[MiMaTextField.text length]<21)
                {
                    if (!querenMiMaTextField.text||querenMiMaTextField.text == nil||[querenMiMaTextField.text isEqualToString:@""])
                    {
                        [self showWithCustomView:@"请输入再次输入密码"];
                        return;
                    }
                    
                    else
                    {
                        if (![MiMaTextField.text  isEqualToString:querenMiMaTextField.text])
                        {
                            [self showWithCustomView:@"两次输入的密码不相同"];
                        }
                        else
                        {
                            zhuce_mima *customer =[[zhuce_mima alloc]init];
                            mima=[MyMD5 md5:MiMaTextField.text];
                            NSLog(@"**************%@",mima);
                            customer.password =mima;
                            customer.sms=yanzhengmaTextField.text;
                            customer.username=mobileNum;
                            customer.uid=str_device;
                            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                            NSString *str2=@"para=";
                            NSString *Str;
                            Str=[str2 stringByAppendingString:str_jiami];
                            [HttpPostExecutor postExecuteWithUrlStr:ZhuCe_m1_02 Paramters:Str FinishCallbackBlock:^(NSString *result){
                                // 执行post请求完成后的逻辑
                                if (result.length<=0)
                                {
                                    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                    [aler show];
                                }
                                else
                                {

                                NSLog(@"返回结果：%@",result);
                                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                                SBJsonParser *parser = [[SBJsonParser alloc] init];
                                NSError *error = nil;
                                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                                NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                                int intb = [str_tishi intValue];
                                if (intb==1000)
                                {
                                    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jieguo) userInfo:nil repeats:NO];
                                    [self showWithCustomView:@"注册成功"];
                                }
                                else
                                {
                                [self showWithCustomView:@"出错了"];
                                }
                                }
                            }];

   
                            
                        }
                        
                    }

                }
                else
                {
                [self showWithCustomView:@"请输入6-20位字符密码"];
                }
                
            }
            
        }
    }
}
@catch (NSException * e) {
    NSLog(@"Exception: %@", e);
    UIAlertView * alert =
    [[UIAlertView alloc]
     initWithTitle:@"错误"
     message: [[NSString alloc] initWithFormat:@"%@",e]
     delegate:self
     cancelButtonTitle:nil
     otherButtonTitles:@"OK", nil];
    [alert show];
    return;
}
}
-(void)jieguo
{
    DengLuHouZhuYeViewController *ChongZhiview=[[DengLuHouZhuYeViewController alloc]init];
    [self presentViewController:ChongZhiview animated:NO completion:nil];
    


}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [ZhangHaoTextField resignFirstResponder];
    [yanzhengmaTextField resignFirstResponder];
    [MiMaTextField resignFirstResponder];
    [querenMiMaTextField resignFirstResponder];
    return YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)huoquyanzhengma
{
    @try
    {
    [self.view endEditing:YES];
    __block ZhuCeViewController *bSelf=self;
    [UIView animateWithDuration:0.25 animations:^{
        bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
    }];
    if (!ZhangHaoTextField.text||ZhangHaoTextField.text == nil||[ZhangHaoTextField.text isEqualToString:@""])
    {
        [self showWithCustomView:@"手机号为空,请输入"];
        return;
    }
        else
    {
        mobileNum=ZhangHaoTextField.text;
        NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
        NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
        NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        if (([regextestmobile evaluateWithObject:mobileNum] == YES)
            || ([regextestcm evaluateWithObject:mobileNum] == YES)
            || ([regextestct evaluateWithObject:mobileNum] == YES)
            || ([regextestcu evaluateWithObject:mobileNum] == YES))
        {
            zhuce *customer =[[zhuce alloc]init];
            customer.flag=@"1";
            customer.type=@"1";
            customer.username=mobileNum;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            NSLog(@"字符: %@", Str);
            [HttpPostExecutor postExecuteWithUrlStr:HuoQuYanZhengMa_m1_12 Paramters:Str FinishCallbackBlock:^(NSString *result){
                if (result.length<=0)
                {
                    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [aler show];
                }
                else
                {

                NSLog(@"第一次: %@", result);
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                NSLog(@"第一次: 解析%@", rootDic);
                shuzu=[rootDic objectForKey:@"ecode"];
                NSLog(@"第一次返回信息===%@", shuzu);
                int inta = [shuzu intValue];

                if (inta==1000)
                {
                    yanzhengma.userInteractionEnabled=NO;
                    m_pTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                target:self
                                                              selector:@selector(calcuRemainTime)
                                                              userInfo:nil
                                                               repeats:YES];
                    //开始时间获取
                    m_pStartDate = [NSDate date];
                    [NSTimer scheduledTimerWithTimeInterval:240 target:self selector:@selector(quxiao) userInfo:nil repeats:NO];
                    
                    [self.view addSubview:label_shijian];
                    [self showWithCustomView:@"系统已向你的手机发送了一条验证码信息，请注意查收"];
                    
                }
                else if (inta==3002)
                {
                    [self showWithCustomView:@"用户已存在"];
                }
                }
            }];
        }
        else
        {
        [self showWithCustomView:@"号码错误"];
        }

    }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"错误"
         message: [[NSString alloc] initWithFormat:@"%@",e]
         delegate:self
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    
}
#define TOTAL_TIME 240

- (void)calcuRemainTime
{
	double deltaTime = [[NSDate date] timeIntervalSinceDate:m_pStartDate];
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
- (void)showTime:(int)time
{
	int inputSeconds = (int)time;
	int hours =  inputSeconds / 3600;
	int minutes = ( inputSeconds - hours * 3600 ) / 60;
	int seconds = inputSeconds - hours * 3600 - minutes * 60;
    
	NSString *strTime2 = [NSString stringWithFormat:@"%.2d:%d秒",minutes,seconds];
    label_shijian.text=strTime2;
    label_shijian.font=[UIFont systemFontOfSize:14];
    
}

- (void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
-(void)quxiao
{
    [label_shijian removeFromSuperview];
    yanzhengma.userInteractionEnabled=YES;
    label_shijian.text=@"04:00秒";
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
