//
//  RetrievePasswordViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-22.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import "SerializationComplexEntities.h"
#import "RegistrationAndLoginAndFindHttpService.h"
#import "MyMD5.h"
#import "zhaohuimima.h"
extern NSString *str;

@interface RetrievePasswordViewController ()
{
    RegistrationAndLoginAndFindHttpService *sqHttpSer;
}
@end

@implementation RetrievePasswordViewController
@synthesize ZhangHaoTextField,MiMaTextField,yanzhengmaTextField,querenMiMaTextField;

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
   
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label_beijing=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    label_beijing.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijing];
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label_title.text=@"找回密码";
    label_title.font=[UIFont systemFontOfSize:18];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
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
    ZhangHaoTextField.placeholder=@"请输入注册的手机号";
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
    yanzhengma.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [yanzhengma setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    MiMaTextField.placeholder=@"请输入新密码";
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
    querenMiMaTextField.placeholder=@"请再次输入新密码";
    querenMiMaTextField.layer.borderWidth =0.5;
    querenMiMaTextField.layer.borderColor=[[UIColor grayColor] CGColor];
    querenMiMaTextField.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:querenMiMaTextField];
    zhuceBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,340, 290, 35)];
    [zhuceBtn setTitle:@"重置密码" forState:UIControlStateNormal];
    zhuceBtn.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [zhuceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhuceBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    zhuceBtn.layer.masksToBounds = YES;
    zhuceBtn.layer.cornerRadius = 5;
    zhuceBtn.layer.borderWidth = 0.5;
    zhuceBtn.layer.borderColor=[[UIColor grayColor] CGColor];
    [zhuceBtn addTarget:self action:@selector(chongzhimima) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuceBtn];
    
    label_shijian=[[UILabel alloc]initWithFrame:CGRectMake(260, 180, 60, 20)];
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
        
        if (!ZhangHaoTextField.text||ZhangHaoTextField.text == nil||[ZhangHaoTextField.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"手机号为空,请输入" duration:1];
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
                customer.flag=@"0";
                customer.type=@"3";
                customer.username=mobileNum;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                sqHttpSer.strUrl = HuoQuYanZhengMa_m1_12;
                sqHttpSer.delegate = self;
                sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                [sqHttpSer beginQuery];

            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"号码错误" duration:1];
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
- (void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)chongzhimima
{
    @try
    {
        
        
        if (!ZhangHaoTextField.text||ZhangHaoTextField.text == nil||[ZhangHaoTextField.text isEqualToString:@""])
        {
        
            [SVProgressHUD showErrorWithStatus:@"手机号为空,请输入" duration:1];
            return;
        }
        if (!yanzhengmaTextField.text||yanzhengmaTextField.text == nil||[yanzhengmaTextField.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码" duration:1];
            return;
        }
        if (!MiMaTextField.text||MiMaTextField.text == nil||[MiMaTextField.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请输入新密码" duration:1];
            return;
        }
        if (!querenMiMaTextField.text||querenMiMaTextField.text == nil||[querenMiMaTextField.text isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"请输入新密码" duration:1];
            return;
        }
        if (![MiMaTextField.text isEqualToString:querenMiMaTextField.text])
        {
            [SVProgressHUD showErrorWithStatus:@"输入的两次密码不相同" duration:1];
            return;

        }
        else
        {
            zhaohuimima *customer =[[zhaohuimima alloc]init];
            customer.auth_code=yanzhengmaTextField.text;
            customer.username=ZhangHaoTextField.text;
            NSString *mima;
            mima=[MyMD5 md5:MiMaTextField.text];
            customer.password=mima;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
            sqHttpSer.strUrl = CongZhiMiMa_m1_07;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];

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
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 4:{
            NSLog(@"%@",sqHttpSer.responDict);
            int inta = [[sqHttpSer.responDict objectForKey:@"ecode"] intValue];
            
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
                [SVProgressHUD showErrorWithStatus:@"系统已向你的手机发送了一条验证码信息，请注意查收" duration:1.5];
                
            }
            else if (inta==3002)
            {
                [SVProgressHUD showErrorWithStatus:@"用户已存在" duration:1.5];
            }
            
        }
            break;
        case 3:
        {
            NSLog(@"%@",sqHttpSer.responDict);
            NSString *str_tishi=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intb = [str_tishi intValue];
            if (intb==1000)
            {
                [SVProgressHUD showSuccessWithStatus:@"密码重置成功" duration:1.5];
                [self dismissViewControllerAnimated:NO completion:nil];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"出错了" duration:1.5];
            }

        }
            break;
        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag
{
    
}
-(void)quxiao
{
    [label_shijian removeFromSuperview];
    yanzhengma.userInteractionEnabled=YES;
    label_shijian.text=@"04:00秒";
}
#define TOTAL_TIME 240

- (void)calcuRemainTime
{
	double deltaTime = [[NSDate date] timeIntervalSinceDate:m_pStartDate];
    int remainTime = TOTAL_TIME - (int)(deltaTime+0.5) ;
    
	if (remainTime < 0.0)
	{
		[m_pTimer invalidate];
	
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
