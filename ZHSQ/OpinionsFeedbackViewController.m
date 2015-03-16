//
//  OpinionsFeedbackViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "OpinionsFeedbackViewController.h"
#import "AXHVendors.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "OpinionsFeedback.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"

extern NSString *Session;
extern NSString *mobel_iphone;
@interface OpinionsFeedbackViewController ()

@end

@implementation OpinionsFeedbackViewController
@synthesize textfield_emile,textfield_mobel,textfield_QQ,textview,Btn_Submit;
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
    UIDevice *device = [UIDevice currentDevice];//创建设备对象
    str_device=device.identifierForVendor.UUIDString;
    Btn_Submit.layer.masksToBounds = YES;
    Btn_Submit.layer.cornerRadius = 5;
    Btn_Submit.layer.borderWidth = 0.5;
    Btn_Submit.layer.borderColor=[[UIColor grayColor] CGColor];

    textview.font = [UIFont systemFontOfSize:16];
    textview.scrollEnabled = NO;
    textview.layer.cornerRadius =4;
    textview.layer.masksToBounds = YES;
    //边框宽度及颜色设置
    [textview.layer setBorderWidth:1];
    [textview.layer setBorderColor:[[UIColor grayColor] CGColor]];  //设置边框为蓝色
    [textview becomeFirstResponder];
    textview.keyboardType =UIKeyboardTypeDefault;
    textview.returnKeyType=UIReturnKeyDefault;
    [self->textview.layer setCornerRadius:10];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * button1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [textview setInputAccessoryView:topView];
    
    textfield_mobel.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_mobel.delegate=self;
    textfield_emile.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_emile.delegate=self;
    textfield_QQ.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_QQ.delegate=self;



}
-(void)resignKeyboard
{
    [textview resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textfield_mobel resignFirstResponder];
    
    [textfield_emile resignFirstResponder];
    [textfield_QQ resignFirstResponder];
    
    return YES;
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Submit:(id)sender
{
    OpinionsFeedback*customer =[[OpinionsFeedback alloc]init];
    customer.user_id =mobel_iphone;
    customer.device_id =str_device;
    customer.content =textview.text;
    customer.phone =textfield_mobel.text;
    customer.email =textfield_emile.text;
    customer.qq =textfield_QQ.text;
   
    customer.model =[UIDevice currentDevice].model;
    customer.version =[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    
    [HttpPostExecutor postExecuteWithUrlStr:YiJianFanKui_23_01 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
            // NSLog(@"第二次:登录 %@", str_jiemi);
             SBJsonParser *parser = [[SBJsonParser alloc] init];
             NSError *error = nil;
             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
             NSString *str_tishi=[rootDic objectForKey:@"ecode"];
             int intb = [str_tishi intValue];
             if (intb==1000)
             {
                 
                 [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jieguo) userInfo:nil repeats:NO];
                 
                 [self showWithCustomView:@"提交成功,多谢您的反馈意见！"];
                 
                 
                 
             }
         }
     }];

    
}
-(void)jieguo
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
- (IBAction)fanhui:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
