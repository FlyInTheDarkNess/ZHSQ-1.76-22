//
//  KuaiJieJiaoFeiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-9-26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "KuaiJieJiaoFeiViewController.h"



#import "shouyeViewController.h"
#import "MBProgressHUD.h"
//#import "WuYeFeiViewController.h"
//#import "NuanQiFeiViewController.h"
//#import "DianFeiViewController.h"
#import "WoDeShuiFeiViewController.h"
#import "WoDeTingCheFeiViewController.h"
#import "SBJson.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "CheckNetwork.h"

#import "URL.h"
#import "JiaMiJieMi.h"

#import "Pay ViewController.h"
#import "AXHBaseViewController.h"

#import "LefeToHelpSubViewController.h"

#import "WoDeWuYeFeiViewController.h"
#import "WoDeShuiFeiViewController.h"
#import "WoDeNuanQiFeiViewController.h"
#import "WoDeTingCheFeiViewController.h"
//我的账单
#import "MyBillViewController.h"


extern NSString *Session;
extern NSString *Payment_url;
extern NSString *SheQuFuWu_Title;
@interface KuaiJieJiaoFeiViewController ()

@end

@implementation KuaiJieJiaoFeiViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_fanhui:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)btn_wuyefei:(id)sender {
    
    if (![Session isEqualToString:@""] && Session.length>0)
    {
        MyBillViewController *wuye=[[MyBillViewController alloc]init];
        [self presentViewController:wuye animated:NO completion:nil];
        
    }
    else
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }

}

- (IBAction)btn_tingcheguanlifei:(id)sender
{
        if (![Session isEqualToString:@""] && Session.length>0)
    {
        WoDeTingCheFeiViewController *tingchefei=[[WoDeTingCheFeiViewController alloc]init];
        [self presentViewController:tingchefei animated:NO completion:nil];
        
    }
    else
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }

}

- (IBAction)btn_shuifei:(id)sender
{
        if (![Session isEqualToString:@""] && Session.length>0)
    {
        WoDeShuiFeiViewController *shuifei=[[WoDeShuiFeiViewController alloc]init];
        [self presentViewController:shuifei animated:NO completion:nil];
        
    }
    else
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }

}

- (IBAction)btn_dianfei:(id)sender {
    
    if (![Session isEqualToString:@""] && Session.length>0)
    {
        
        NSString *str1=@"{\"city_id\":\"371200\",\"type1\":\"010\",\"type2\":\"1002\"}";
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        
        arr=[[NSMutableArray alloc]init];
        
        [HttpPostExecutor postExecuteWithUrlStr:YueShengHuo_c1_03 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                //NSLog(@">>>>>>>>>>>%@",str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                int intb = [str_tishi intValue];
                if (intb==1000)
                {
                    SheQuFuWu_Title=@"电费";
                    Payment_url=[rootDic objectForKey:@"url"];
                    Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
                    [self presentViewController:subViewVCtr animated:NO completion:nil];
                }
                if (intb==3007)
                {
                    [self showWithCustomView:@"没有查找到数据"];
                }
                if (intb==4000)
                {
                    [self showWithCustomView:@"服务器内部错误"];
                }

                
            }
        }];
    }
    else
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }

}

- (IBAction)btn_nuanqifei:(id)sender
{
        if (![Session isEqualToString:@""] && Session.length>0)
    {
        WoDeNuanQiFeiViewController *nuanqi=[[WoDeNuanQiFeiViewController alloc]init];
        [self presentViewController:nuanqi animated:NO completion:nil];
    }
    else
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }

}
//手机费
- (IBAction)btn_yidongjiaofei:(id)sender {
    if (![Session isEqualToString:@""] && Session.length>0)
    {
        
        NSString *str1=@"{\"city_id\":\"371200\",\"type1\":\"010\",\"type2\":\"1009\"}";
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        
        arr=[[NSMutableArray alloc]init];
        
        [HttpPostExecutor postExecuteWithUrlStr:YueShengHuo_c1_03 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                //NSLog(@">>>>>>>>>>>%@",str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                int intb = [str_tishi intValue];
                if (intb==1000)
                {
                    SheQuFuWu_Title=@"手机费";
                    Payment_url=[rootDic objectForKey:@"url"];
                    Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
                    [self presentViewController:subViewVCtr animated:NO completion:nil];
                }
                if (intb==3007)
                {
                    [self showWithCustomView:@"没有查找到数据"];
                }
                if (intb==4000)
                {
                    [self showWithCustomView:@"服务器内部错误"];
                }
                
                
            }
        }];
    }
    else
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }
}
//话费充值
- (IBAction)btn_liantongjiaofei:(id)sender {
    if (![Session isEqualToString:@""] && Session.length>0)
    {
        
        NSString *str1=@"{\"city_id\":\"371200\",\"type1\":\"010\",\"type2\":\"1010\"}";
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        
        arr=[[NSMutableArray alloc]init];
        
        [HttpPostExecutor postExecuteWithUrlStr:YueShengHuo_c1_03 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                //NSLog(@">>>>>>>>>>>%@",str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                int intb = [str_tishi intValue];
                if (intb==1000)
                {
                    SheQuFuWu_Title=@"话费充值";
                    Payment_url=[rootDic objectForKey:@"url"];
                    Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
                    [self presentViewController:subViewVCtr animated:NO completion:nil];
                }
                if (intb==3007)
                {
                    [self showWithCustomView:@"没有查找到数据"];
                }
                if (intb==4000)
                {
                    [self showWithCustomView:@"服务器内部错误"];
                }
                
                
            }
        }];
    }
    else
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }
}
//交通罚款
- (IBAction)btn_dianxinjiaofei:(id)sender {
    if (![Session isEqualToString:@""] && Session.length>0)
    {
        
        NSString *str1=@"{\"city_id\":\"371200\",\"type1\":\"020\",\"type2\":\"1006\"}";
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        
        arr=[[NSMutableArray alloc]init];
        
        [HttpPostExecutor postExecuteWithUrlStr:YueShengHuo_c1_03 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                //NSLog(@">>>>>>>>>>>%@",str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                int intb = [str_tishi intValue];
                if (intb==1000)
                {
                    SheQuFuWu_Title=@"交通罚款";
                    Payment_url=[rootDic objectForKey:@"url"];
                    Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
                    [self presentViewController:subViewVCtr animated:NO completion:nil];
                }
                if (intb==3007)
                {
                    [self showWithCustomView:@"没有查找到数据"];
                }
                if (intb==4000)
                {
                    [self showWithCustomView:@"服务器内部错误"];
                }
                
                
            }
        }];
    }
    else
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }

}

- (IBAction)btn_youxiandianshi:(id)sender {
//    if (![Session isEqualToString:@""] && Session.length>0)
//    {
//        WuYeFeiViewController *wuye=[[WuYeFeiViewController alloc]init];
//        [self presentViewController:wuye animated:NO completion:nil];
//        
//    }
//    else
//    {
//        shouyeViewController *denglu=[[shouyeViewController alloc]init];
//        [self presentViewController:denglu animated:NO completion:nil];
//    }

    [self showWithCustomView:@"敬请期待..."];
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
