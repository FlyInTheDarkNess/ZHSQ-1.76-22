//
//  YouHuiXinXiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "YouHuiXinXiViewController.h"
#import "YouHuiZiXunViewController.h"
//#import "AXHYHGoodsViewController.h"
@interface YouHuiXinXiViewController ()

@end

@implementation YouHuiXinXiViewController

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

- (IBAction)YouHuiZiXun:(id)sender
{
    YouHuiZiXunViewController *zixun=[[YouHuiZiXunViewController alloc]init];
    [self presentViewController:zixun animated:NO completion:nil];
}

- (IBAction)YouHuiShangPin:(id)sender {
//    AXHYHGoodsViewController *yhGoodsVCtr = [[AXHYHGoodsViewController alloc]init];
//    UINavigationController *naVCtr = [[UINavigationController alloc]initWithRootViewController:yhGoodsVCtr];
//    [self presentViewController:naVCtr animated:YES completion:NULL];
    
}

- (IBAction)YouHuiQuan:(id)sender {
}

- (IBAction)MiaoSha:(id)sender {
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
