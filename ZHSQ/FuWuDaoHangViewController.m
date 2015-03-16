//
//  FuWuDaoHangViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-10-16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "FuWuDaoHangViewController.h"
#import "SBJson.h"

#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "CheckNetwork.h"
#import "UIImageView+WebCache.h"
#import "zhujianliebiao.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "fuwu.h"
#import "FuWwYingYongViewController.h"

#import "CommunityServiceViewController.h"
extern NSMutableArray *arr_shequfuwu;
extern NSString *Session;
extern NSMutableArray *arr_info_shequfuwu;
extern NSString *Type;
@interface FuWuDaoHangViewController ()

@end

@implementation FuWuDaoHangViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)JiuDianYuDing:(id)sender
{
    Type=@"7";
    CommunityServiceViewController *fuwu=[[CommunityServiceViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}

- (IBAction)KuaiChanWaiMai:(id)sender
{
    Type=@"8";
    CommunityServiceViewController *fuwu=[[CommunityServiceViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}

- (IBAction)ShangMenWeiXiu:(id)sender
{
    Type=@"1";
     CommunityServiceViewController *fuwu=[[CommunityServiceViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}

- (IBAction)JiaZhengFuWu:(id)sender
{
    Type=@"3";
    CommunityServiceViewController *fuwu=[[CommunityServiceViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}

- (IBAction)SheQuYiLiao:(id)sender
{
    Type=@"4";
     CommunityServiceViewController *fuwu=[[CommunityServiceViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}

- (IBAction)fanhui:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
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
