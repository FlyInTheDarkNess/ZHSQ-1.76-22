//
//  shouyeViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "shouyeViewController.h"
#import "SheQuXuanZeViewController.h"
#import "AddressMessageViewController.h"
#import "APService.h"
#import "AppDelegate.h"
#import "ZhuCeViewController.h"

#import "RetrievePasswordViewController.h"
//#import "DengLuHouZhuYeViewController.h"
#import "wViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "denglu.h"
#import "MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "BangDingXinXi.h"




extern NSString *Session;
extern NSString *Card_id;
extern NSString *email;
extern NSString *Name;
extern NSString *LoginPass;
extern NSString *community_id;
extern NSString *icon_path;
extern NSString *str_zhuzhi;
extern NSString *mobel_iphone;
extern NSString *xiaoquIDString;
extern NSString *xiaoquming;
extern NSString *area_id;
extern NSString *string_Account;
extern NSString *string_Password;
extern NSString *Address_id;
extern NSString *charge_mode;
extern int CommunitySelectionSource;

extern UserInfo *user;

@interface shouyeViewController ()

@end

@implementation shouyeViewController
@synthesize delegate_;
@synthesize ZhangHaoTextField,MiMaTextField;
@synthesize zhaohuimima;
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
    @try
    {
        CGRect rect=[[UIScreen mainScreen]bounds];
        CGSize size=rect.size;
        CGFloat Width=size.width;//Width 屏幕宽度
        //CGFloat Hidth=size.height;//Hidth 屏幕高度

    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 35)];
    label_title.text=@"登录";
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 35, 35)];
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
    label4.text=@"密  码:";
    label4.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label4];
    NSUserDefaults *userDefaulte= [NSUserDefaults standardUserDefaults];
    NSString *myString_zhanghao = [userDefaulte stringForKey:@"denglu_zhanghao"];
    NSString *myString_mima = [userDefaulte stringForKey:@"denglu_mima"];
    ZhangHaoTextField=[[UITextField alloc]init];
    //ZhangHaoTextField.borderStyle=UITextBorderStyleRoundedRect;
    ZhangHaoTextField.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    ZhangHaoTextField.frame=CGRectMake(65, 95, 240, 30);
    ZhangHaoTextField.delegate=self;
    ZhangHaoTextField.text=myString_zhanghao;
    ZhangHaoTextField.placeholder=@"请输入手机号";
    [self.view addSubview:ZhangHaoTextField];
    MiMaTextField=[[UITextField alloc]init];
    //MiMaTextField.borderStyle=UITextBorderStyleRoundedRect;
    MiMaTextField.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    MiMaTextField.frame=CGRectMake(65, 135, 240, 30);
    MiMaTextField.secureTextEntry = YES;//不显示密码 ，用圆点代替
    MiMaTextField.delegate=self;
    MiMaTextField.text=myString_mima;
    MiMaTextField.placeholder=@"密码";
    [self.view addSubview:MiMaTextField];
    
    
    zidongdenglu=[[UIButton alloc]initWithFrame:CGRectMake(20, 175, 20, 20)];
    [zidongdenglu addTarget:self action:@selector(zhidongdenglu) forControlEvents:UIControlEventTouchUpInside];
    [zidongdenglu setImage:[UIImage imageNamed:@"checno.png"] forState:UIControlStateNormal];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"zidong"];
    if (myString.length==0)
    {
        str_zidongdenglu=@"yes";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:str_zidongdenglu forKey:@"zidong"];

    }
    else
    {
        if ([myString isEqualToString:@"yes"])
    {
    [zidongdenglu setImage:[UIImage imageNamed:@"checno.png"] forState:UIControlStateNormal];
    }
    else if ([myString isEqualToString:@"no"])
    {
    [zidongdenglu setImage:[UIImage imageNamed:@"chec.png"] forState:UIControlStateNormal];
        
    }
    }
    [self.view addSubview:zidongdenglu];
    label_zidong=[[UILabel alloc]initWithFrame:CGRectMake(50, 175, 100, 20)];
    label_zidong.text=@"自动登录";
    label_zidong.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label_zidong];
    
    zhaohui_mima=[[UIButton alloc]initWithFrame:CGRectMake(15, 320, 60, 40)];
    [zhaohui_mima setTitle:@"找回密码" forState:UIControlStateNormal];
    [zhaohui_mima setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    zhaohui_mima.titleLabel.font=[UIFont systemFontOfSize:13];
    [zhaohui_mima addTarget:self action:@selector(zhaohuimm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhaohui_mima];
    zhuceBtn=[[UIButton alloc]initWithFrame:CGRectMake(260,320, 60, 28)];
    zhuceBtn.backgroundColor=[UIColor whiteColor];
    [zhuceBtn setTitle:@"注册" forState:UIControlStateNormal];
    zhuceBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [zhuceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [zhuceBtn addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuceBtn];
    
    dengluBtn=[[UIButton alloc]initWithFrame:CGRectMake(15,220, 290, 35)];
    dengluBtn.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [dengluBtn setTitle:@"登录" forState:UIControlStateNormal];
    [dengluBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    dengluBtn.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    dengluBtn.layer.masksToBounds = YES;
    dengluBtn.layer.cornerRadius = 5;
    dengluBtn.layer.borderWidth = 0.5;
    dengluBtn.layer.borderColor=[[UIColor grayColor] CGColor];
    [dengluBtn addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dengluBtn];
    
        
    Btn_Tourist=[[UIButton alloc]initWithFrame:CGRectMake(15,275, 290, 35)];
    Btn_Tourist.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [Btn_Tourist setTitle:@"游客浏览(免注册)" forState:UIControlStateNormal];
    [Btn_Tourist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Btn_Tourist.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    Btn_Tourist.layer.masksToBounds = YES;
    Btn_Tourist.layer.cornerRadius = 5;
    Btn_Tourist.layer.borderWidth = 0.5;
    Btn_Tourist.layer.borderColor=[[UIColor grayColor] CGColor];
    [Btn_Tourist addTarget:self action:@selector(Touristdenglu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn_Tourist];

        
    viewcontrol=[[ZhaiHuimimaViewController alloc]init];
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


//无语，自动登录
-(void)zhidongdenglu
{
    @try
    {
        

    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"zidong"];
    if ([myString isEqualToString:@"yes"])
    {
        str_zidongdenglu=@"no";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:str_zidongdenglu forKey:@"zidong"];
        [zidongdenglu setImage:[UIImage imageNamed:@"chec.png"] forState:UIControlStateNormal];
        y=YES;
    }
    if ([myString isEqualToString:@"no"])
    {
        str_zidongdenglu=@"yes";
        NSString *zidongdenglu_zhanghao=@"";
        NSString *zidongdenglu_mima=@"";
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:zidongdenglu_zhanghao forKey:@"denglu_zhanghao"];
        [userDefaults setObject:zidongdenglu_mima forKey:@"denglu_mima"];
        [userDefaults setObject:str_zidongdenglu forKey:@"zidong"];
        [zidongdenglu setImage:[UIImage imageNamed:@"checno.png"] forState:UIControlStateNormal];
        y=NO;
        
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




-(void)Touristdenglu
{
    CommunitySelectionSource=1;
    SheQuXuanZeViewController *xuanze=[[SheQuXuanZeViewController alloc]init];
    [self presentViewController:xuanze animated:YES completion:nil];
}


-(void)zhuce
{
    ZhuCeViewController *viewcontroller=[[ZhuCeViewController alloc]init];
    [self presentViewController:viewcontroller animated:NO completion:nil];
}

-(void)denglu
{
    @try
    {
 
    
    [self.view endEditing:YES];
    __block shouyeViewController *bSelf=self;
    [UIView animateWithDuration:0.25 animations:^
    {
        bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
    }];
    
    if (!ZhangHaoTextField.text||ZhangHaoTextField.text == nil||[ZhangHaoTextField.text isEqualToString:@""])
    {
        [self showWithCustomView:@"账号不能为空"];
    
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
            
            if (!MiMaTextField.text||MiMaTextField.text == nil||[MiMaTextField.text isEqualToString:@""])
            {
                [self showWithCustomView:@"登录密码不能为空"];
              
            }
            else
            {
                if (5<[MiMaTextField.text length]<21)
                {
                    denglu*customer =[[denglu alloc]init];
                    mima=[MyMD5 md5:MiMaTextField.text];
                    customer.password =mima;
                    
                    customer.username=mobileNum;
                    
                    [SurveyRunTimeData sharedInstance].username = mobileNum;
                    [SurveyRunTimeData sharedInstance].password = mima;
                    
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    NSLog(@"%@",str1);
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    
                    [HttpPostExecutor postExecuteWithUrlStr:YongHuBangDingXinXi_m1_17 Paramters:Str FinishCallbackBlock:^(NSString *result)
                     {
                    
                         // 执行post请求完成后的逻辑
                         //NSLog(@"第二次:登录 %@", result);
                         if (result.length<=0)
                         {
                             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                             [aler show];
                         }
                         else
                         {

                         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                         NSLog(@"第二次:登录 %@", str_jiemi);
                         SBJsonParser *parser = [[SBJsonParser alloc] init];
                         NSError *error = nil;
                         NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                             
                             /*
                              修改时间 3.23 
                              修改人 赵忠良
                              修改内容 添加存储用户信息的全局变量
                              */
                             //**************************
                             NSArray *person = [rootDic objectForKey:@"person_info"];
                             NSArray *car_info = [rootDic objectForKey:@"car_info"];
                             NSArray *jdh_info = [rootDic objectForKey:@"jdh_info"];
                             NSArray *address_info = [rootDic objectForKey:@"address_info"];
                             user = [[UserInfo alloc]initWithPersonArr:person CarArr:car_info JdhArr:jdh_info AddressArr:address_info Session:[rootDic objectForKey:@"session"]];
                             //******************************
                         Session=[rootDic objectForKey:@"session"];
                         NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                         int intb = [str_tishi intValue];
                         if (intb==1000)
                         {
                             string_Account=ZhangHaoTextField.text;
                             string_Password=MiMaTextField.text;
                             NSString *nickname=[[[rootDic objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"nickname"];
                             UserName=nickname;
//                             Address_id=[[[rootDic objectForKey:@"address_info"] objectAtIndex:0] objectForKey:@"address_id"];
//                             charge_mode=[[[rootDic objectForKey:@"address_info"] objectAtIndex:0] objectForKey:@"charge_mode"];
                             email=[[[rootDic objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"email"];
                             Name=[[[rootDic objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"name"];
                             Card_id=[[[rootDic objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"idnumber"];
                             icon_path=[[[rootDic objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"icon_path"];
                             
                             mobel_iphone=[[[rootDic objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"mobile_phone"];
                            arr_info=[rootDic objectForKey:@"address_info"];
                             
                             NSArray *arr=[[NSArray alloc] initWithObjects:@"city101",@"city102",@"community102",@"tag9", @"city103",nil];
                             [((AppDelegate*)[[UIApplication sharedApplication]delegate]) SetTag:arr  withAlias:mobel_iphone];

                             arr_addressidentify=[[NSMutableArray alloc]init];
                             for (int i=0; i<[arr_info count]; i++)
                             {
                                 NSString *string=[[arr_info objectAtIndex:i] objectForKey:@"isdefaultshow"];
                                 [arr_addressidentify addObject:string];
                             }
                             if (arr_info.count>0)
                             {
                                 [SurveyRunTimeData sharedInstance].session = [rootDic objectForKey:@"session"];
                                 [SurveyRunTimeData sharedInstance].mobilePhone = rootDic[@"person_info"][0][@"mobile_phone"];
                                 [SurveyRunTimeData sharedInstance].user_id = rootDic[@"person_info"][0][@"id"];
                                
                                 //判断数组中是否有1存在，有则就有默认住址，没有就选择第一个
                                 if ([arr_addressidentify containsObject:@"1"])
                                 {
                                     for (int i=0; i<[arr_info count]; i++)
                                     {
                                         NSString *string=[[arr_info objectAtIndex:i] objectForKey:@"isdefaultshow"];
                                         if ([string isEqualToString:@"1"])
                                         {
                                             
                                             // NSLog(@"是  1");
                                             NSDictionary *Dic=[arr_info objectAtIndex:i];
                                             Address_id=[Dic objectForKey:@"address_id"];
                                             charge_mode=[Dic objectForKey:@"charge_mode"];
                                             
                                             
                                             [SurveyRunTimeData sharedInstance].community_id = Dic[@"community_id"];
                                             [SurveyRunTimeData sharedInstance].quarter_id = Dic[@"quarter_id"];
                                             [SurveyRunTimeData sharedInstance].city_id =  Dic[@"city_id"];
                                             [SurveyRunTimeData sharedInstance].area_id = Dic[@"area_id"];

                                             xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                                             xiaoquming=[Dic objectForKey:@"quarter_name"];
                                             community_id=[Dic objectForKey:@"community_id"];
                                             area_id=[Dic objectForKey:@"area_id"];
                                             NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                                             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                             [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                                         }
                                         else
                                         {
                                             //NSLog(@"不是  1");
                                         }
                                     }
                                     
                                 }
                                 else
                                 {
                                     NSDictionary *Dic=[arr_info objectAtIndex:0];
                                     xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                                     xiaoquming=[Dic objectForKey:@"quarter_name"];
                                     NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                                     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                     [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                                     [userDefaults setObject:xiaoquming forKey:@"xiaoqu"];
                                     [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];

                                }
                                 
                                 //登录成功，切有绑定小区信息，进入主页面
                                 DengLuHouZhuYeViewController *denglu=[[DengLuHouZhuYeViewController alloc]init];
                                 [self presentViewController:denglu animated:YES completion:nil];

                             }
                             else
                             {
                                //登录成功，没有绑定小区信息，进入小区绑定页面，添加小区，获取小区信息
                                 AddressMessageViewController *denglu=[[AddressMessageViewController alloc]init];
                                 [self presentViewController:denglu animated:YES completion:nil];


                             }
   
                             if (y==YES)
                             {
                                 NSString *zidongdenglu_zhanghao=ZhangHaoTextField.text;
                                 NSString *zidongdenglu_mima=MiMaTextField.text;
                                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                 [userDefaults setObject:zidongdenglu_zhanghao forKey:@"denglu_zhanghao"];
                                 [userDefaults setObject:zidongdenglu_mima forKey:@"denglu_mima"];
                             }
                             
                             [delegate_ RefreshAddressMessage];
                             DengLuHouZhuYeViewController *denglu=[[DengLuHouZhuYeViewController alloc]init];
                             [self presentViewController:denglu animated:YES completion:nil];

                             //[self dismissViewControllerAnimated:NO completion:nil];

                             
                         }
                         if (intb==3101)
                         {
                             [self showWithCustomView:@"用户不存在"];
                         }
                         
                         if (intb==3102)
                         {
                             [self showWithCustomView:@"密码错误"];
                         }
                         }
                     }];
                }
                else
                {
                    [self showWithCustomView:@"请正确输入密码(6~20位)"];
                    return;
                }

            }
            
        }
        else
        {
            [self showWithCustomView:@"不是正确的手机号"];
        }
    }
    
}
@catch (NSException * e)
    {
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
#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
    if (checked==0)
    {
        NSString *zidongdenglu_zhanghao=ZhangHaoTextField.text;
        NSString *zidongdenglu_mima=MiMaTextField.text;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:zidongdenglu_zhanghao forKey:@"denglu_zhanghao"];
        [userDefaults setObject:zidongdenglu_mima forKey:@"denglu_mima"];
        checkbox.imageView.image=[UIImage imageNamed:@"payeco_plugin_checkbox_normal.png"];
    }
}


//开始编辑输入框的时候，软键盘出现，执行此事件
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
- (void)showWithCustomView:(NSString*)aString {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}
//- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
//{
//    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    [ZhangHaoTextField resignFirstResponder];
    [MiMaTextField resignFirstResponder];
    
    return YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)zhaohuimm
{
    RetrievePasswordViewController *zhaohui=[[RetrievePasswordViewController alloc]init];
    //ZhaiHuimimaViewController *zhaohui=[[ZhaiHuimimaViewController alloc]init];
    [self presentViewController:zhaohui animated:NO completion:nil];
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
