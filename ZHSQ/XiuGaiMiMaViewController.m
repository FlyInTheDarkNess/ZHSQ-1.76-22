//
//  XiuGaiMiMaViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-12.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "XiuGaiMiMaViewController.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "MyMD5.h"
#import "xiugaimima.h"

extern NSString *Session;
@interface XiuGaiMiMaViewController ()

@end

@implementation XiuGaiMiMaViewController
@synthesize btn_xiugaimima,textfield_jiumima,textfield_querenmima,textfield_xinmima;
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
    btn_xiugaimima.layer.borderWidth=1;
    btn_xiugaimima.layer.masksToBounds=YES;
    btn_xiugaimima.layer.cornerRadius=6;
    btn_xiugaimima.layer.borderColor=[[UIColor grayColor] CGColor];
    
    textfield_jiumima.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_jiumima.secureTextEntry = YES;//不显示密码 ，用圆点代替
    textfield_jiumima.delegate=self;
    
    textfield_xinmima.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_xinmima.secureTextEntry = YES;//不显示密码 ，用圆点代替
    textfield_xinmima.delegate=self;

    textfield_querenmima.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_querenmima.secureTextEntry = YES;//不显示密码 ，用圆点代替
    textfield_querenmima.delegate=self;


}

-(void)showWithCustomView:(NSString*)aString
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textfield_jiumima resignFirstResponder];
    [textfield_querenmima resignFirstResponder];
    [textfield_xinmima resignFirstResponder];
    
    return YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)fanhui:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)xiugaimima:(id)sender
{
    @try
    {
    if (textfield_jiumima==nil||textfield_jiumima.text.length==0)
    {
        [self showWithCustomView:@"请输入旧密码"];

    }
    else  if (textfield_xinmima==nil||textfield_xinmima.text.length==0)

    {
        
            [self showWithCustomView:@"请输入新密码"];
    }
    else if (textfield_querenmima==nil||textfield_querenmima.text.length==0)
    {
            [self showWithCustomView:@"请再次输入新密码"];
        
    }
    else
    {
                if ([textfield_xinmima.text isEqualToString:textfield_querenmima.text])
                {
                    NSString *oldmima;
                    NSString *newmima;
                    xiugaimima*customer =[[xiugaimima alloc]init];
                    
                    oldmima=[MyMD5 md5:textfield_jiumima.text];
                    newmima=[MyMD5 md5:textfield_querenmima.text];

                    customer.oldpassword =oldmima;
                    customer.session=Session;
                    customer.newpassword=newmima;
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    NSLog(@"json→ %@", Str);
                    [HttpPostExecutor postExecuteWithUrlStr:XiuGaiMiMa_m1_09 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                         NSLog(@"json→ %@", str_jiemi);
                         
                         SBJsonParser *parser = [[SBJsonParser alloc] init];
                         NSError *error = nil;
                         NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                         NSString *str_tishi=[rootDic objectForKey:@"ecode"];
                         int intb = [str_tishi intValue];
                         if (intb==1000)
                         {
                            [self showWithCustomView:@"修改密码成功"];
                             [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(tiaozhuan) userInfo:nil repeats:NO];
                         }
                         if (intb==4000)
                         {
                             [self showWithCustomView:@"系统内部错误"];

                         }
                         }
                     }];

                }
                else
                {
                [self showWithCustomView:@"俩次输入的密码不一致"];
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
-(void)tiaozhuan
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
