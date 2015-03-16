//
//  ShangJiaPingJiaViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-7-25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ShangJiaPingJiaViewController.h"
#import "ShangJiaXinXiViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#define kAnimationDuration 0.2
#define kViewHeight 56
extern NSDictionary *FUWUdtDictionary;
extern NSString *UserName;
@interface ShangJiaPingJiaViewController ()

@end

@implementation ShangJiaPingJiaViewController
@synthesize starView,textview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.text=@"评价商家";
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    wancheng=[[UIButton alloc]initWithFrame:CGRectMake(280, 25, 35, 25)];
    [wancheng setImage:[UIImage imageNamed:@"duihao0508.png"] forState:UIControlStateNormal];
    [wancheng addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wancheng];
    [starView setImagesDeselected:@"xingxing01.png" partlySelected:@"1.png" fullSelected:@"xingxing02.png" andDelegate:self];
	[starView displayRating:2.0];
    
    textview.font = [UIFont systemFontOfSize:16];
    textview.scrollEnabled = NO;
    [textview becomeFirstResponder];
    textview.keyboardType =UIKeyboardTypeDefault;
    textview.returnKeyType=UIReturnKeyDefault;
    [self.textview.layer setCornerRadius:10];
    textview.layer.masksToBounds = YES;
    textview.layer.cornerRadius = 5;
    textview.layer.borderWidth = 0.5;
    textview.layer.borderColor=[[UIColor orangeColor] CGColor];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    UIBarButtonItem * button1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray]; [textview setInputAccessoryView:topView];
    
}
-(void)ratingChanged:(float)newRating
{
      filePath=[NSString stringWithFormat:@"%f",newRating];
}
- (void)resignKeyboard
{
    [textview resignFirstResponder];
}
-(void)tijiao
{
    @try
    {

    
    PingJiaXinXi *customer =[[PingJiaXinXi alloc]init];
    customer.community_id =@"102";
    customer.store_id=[FUWUdtDictionary objectForKey:@"store_id"];
    customer.star=filePath;
    customer.username=UserName;
    customer.city_id =@"101";
    customer.feedback=textview.text;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        NSLog(@"%@",str1);
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    
    [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_06
                                  Paramters:Str
                        FinishCallbackBlock:^(NSString *result)
     {
         
         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
         NSLog(@"%@",str_jiemi);
         SBJsonParser *parser=[[SBJsonParser alloc]init];
         NSError *error=nil;
         NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
         NSString *str_tishi=[rootDic objectForKey:@"ecode"];
         int intb =[str_tishi intValue];
         if (intb==1000)
         {
         //[self dismissViewControllerAnimated:NO completion:nil];
             ShangJiaXinXiViewController *xinxi=[[ShangJiaXinXiViewController alloc]init];
             [self presentViewController:xinxi animated:NO completion:nil];
             
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
-(void)keyboardDidShow:(NSNotification *)notification { //获取键盘高度
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey]; CGRect keyboardRect; [keyboardObject getValue:&keyboardRect]; //调整放置有textView的view的位置
    //设置动画
    [UIView beginAnimations:nil context:nil]; //定义动画时间
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往上平移
    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, self.view.frame.size.height-keyboardRect.size.height-kViewHeight, 320, kViewHeight)];
    [UIView commitAnimations];
}
-(void)keyboardDidHidden { //定义动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往下平移
    [(UIView *)[self.view viewWithTag:1000] setFrame:CGRectMake(0, self.view.frame.size.height-kViewHeight, 320, kViewHeight)];
    [UIView commitAnimations];
}


-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
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

@end
