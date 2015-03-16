//
//  WoDeWuYeFei_WeiJiaoViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "WoDeWuYeFei_WeiJiaoViewController.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "URL.h"
#import "JiaoFei.h"
#import "shouyeViewController.h"
#import "UIImage+TOWebViewControllerIcons.h"
#import "JiaMiJieMi.h"
#import "Header.h"
extern NSDictionary *WYF_Dictionary;
extern NSString *Session;
extern NSString *Payment_url;
extern NSString *SheQuFuWu_Title;
NSString *string_Ip;
@interface WoDeWuYeFei_WeiJiaoViewController ()

@end

@implementation WoDeWuYeFei_WeiJiaoViewController
@synthesize label_danbeibianhao,label_danjia,label_jianzhumianji,label_kehudizhi,label_kehuxingming,label_shoufeidanwei,label_wuyefei,label_xufeiqijian,label_yingjiaojine,label_youhuijine;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)AcquireIp
{
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\"}"];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str1];
    [HttpPostExecutor postExecuteWithUrlStr:ipAddress_m1_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示:未能取得用户ip地址" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {
            
            // NSLog(@"ip地址: %@", result);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:result error:&error];
            NSString *daima=[rootDic objectForKey:@"ecode"];
            int intString = [daima intValue];
            if (intString==4000)
            {
                [self showWithCustomView:@"服务器内部错误"];
            }
            if (intString==1000)
            {
                string_Ip=[rootDic objectForKey:@"ip"];
            }
        }
        
        
    }];
}
- (void)showWithCustomView:(NSString*)aString
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

- (void)viewDidLoad
{
    @try
    {
        
        
        [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
        label_danbeibianhao.text=[WYF_Dictionary objectForKey:@"pay_id"];
        label_shoufeidanwei.text=[WYF_Dictionary objectForKey:@"property_name"];
        label_kehuxingming.text=[WYF_Dictionary objectForKey:@"username"];
        label_kehudizhi.text=[NSString stringWithFormat:@"%@%@%@%@%@",[WYF_Dictionary objectForKey:@"community_name"],[WYF_Dictionary objectForKey:@"quarter_name"],[WYF_Dictionary objectForKey:@"building_name"],[WYF_Dictionary objectForKey:@"unit_name"],[WYF_Dictionary objectForKey:@"room_name"]];
        label_jianzhumianji.text=[WYF_Dictionary objectForKey:@"square"];
        label_danjia.text=[WYF_Dictionary objectForKey:@"price"];
        label_xufeiqijian.text=[NSString stringWithFormat:@"%@-%@", [WYF_Dictionary objectForKey:@"period_start"],[WYF_Dictionary objectForKey:@"peroid_end"]];
        label_wuyefei.text=[WYF_Dictionary objectForKey:@"money1"];
        label_youhuijine.text=[WYF_Dictionary objectForKey:@"money2"];
        label_yingjiaojine.text=[WYF_Dictionary objectForKey:@"money_sum"];
        QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
        _check1.frame = CGRectMake(20, 325, 60, 40);
        [_check1 setTitle:@"同意" forState:UIControlStateNormal];
        [_check1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [self.view addSubview:_check1];
        [_check1 setChecked:YES];
        label=[[UILabel alloc]initWithFrame:CGRectMake(60, 325, 200, 40)];
        label.text=@"《支付服务协议》";
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1];
        [self.view addSubview:label];
        
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
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    
    if (checked==0)
    {
        btn_jiaofei.userInteractionEnabled=YES;
        [btn_jiaofei addTarget:self action:@selector(jiaofei) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        btn_jiaofei.userInteractionEnabled=NO;
        
    }
}
-(void)jiaofei
{
    @try
    {
     //   [self AcquireIp];
        
        
        
        
        NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\"}"];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str1];
        [HttpPostExecutor postExecuteWithUrlStr:ipAddress_m1_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示:未能取得用户ip地址" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                // NSLog(@"ip地址: %@", result);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:result error:&error];
                NSString *daima=[rootDic objectForKey:@"ecode"];
                int intString = [daima intValue];
                if (intString==4000)
                {
                    [self showWithCustomView:@"服务器内部错误"];
                }
                if (intString==1000)
                {
                    string_Ip=[rootDic objectForKey:@"ip"];
                    
                    
                    NSLog(@"ip地址：%@",string_Ip);
                    JiaoFei *zhangdanid=[[JiaoFei alloc]init];
                    zhangdanid.session=Session;
                    zhangdanid.remark1=[NSString stringWithFormat:@"用户住址:%@%@%@%@%@%@",[WYF_Dictionary objectForKey:@"city_name"],[WYF_Dictionary objectForKey:@"community_name"],[WYF_Dictionary objectForKey:@"quarter_name"],[WYF_Dictionary objectForKey:@"building_name"],[WYF_Dictionary objectForKey:@"unit_name"],[WYF_Dictionary objectForKey:@"room_name"]];
                    zhangdanid.remark2=[NSString stringWithFormat:@"%@:物业费", [WYF_Dictionary objectForKey:@"username"]];
                    zhangdanid.payment=label_yingjiaojine.text;
                    //zhangdanid.payment=@"0.1";
                    zhangdanid.ip=string_Ip;
                    zhangdanid.property_id=[WYF_Dictionary objectForKey:@"property_id"];
                    zhangdanid.proinfo=[NSString stringWithFormat:@"姓名:%@田缴费项目:物业费 期间:%@-%@",[WYF_Dictionary objectForKey:@"username"],[WYF_Dictionary objectForKey:@"period_start"],[WYF_Dictionary objectForKey:@"peroid_end"]];
                    zhangdanid.proinfo=@"";
                    zhangdanid.order_id=[WYF_Dictionary objectForKey:@"pay_id"];
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:zhangdanid childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    NSLog(@"%@",str1);
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:JiaoFei_c1_02 Paramters:Str FinishCallbackBlock:^(NSString *result)
                     {
                         if (result.length<=0)
                         {
                             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"更新数据失败" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                             [aler show];
                         }
                         else
                         {

                         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                         NSLog(@"%@",str_jiemi);
                         SBJsonParser *parser=[[SBJsonParser alloc]init];
                         NSError *error=nil;
                         NSDictionary *Dic=[parser objectWithString:str_jiemi error:&error];
                         NSString *str_tishi=[Dic objectForKey:@"ecode"];
                         int intb =[str_tishi intValue];
                         if (intb==1000)
                         {
                             
                             NSString * url=[NSString stringWithFormat:@"%@",[Dic objectForKey:@"url"]];
                             
                             SheQuFuWu_Title=@"物业费";
                             Payment_url=url;
                             Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
                             [self presentViewController:subViewVCtr animated:NO completion:nil];

                           //  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                         }
                         if (intb==3007)
                         {
                             [self showWithCustomView:@"因网络原因，未能获得缴费连接地址"];
                         }
                         if (intb==4000)
                         {
                             [self showWithCustomView:@"服务器内部错误"];
                         }
                         }
                     }];

                }
            }
            
            
        }];

        
        
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
