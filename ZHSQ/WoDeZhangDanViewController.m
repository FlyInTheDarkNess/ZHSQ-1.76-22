//
//  WoDeZhangDanViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "WoDeZhangDanViewController.h"
#import "WoDeWuYeFeiViewController.h"
#import "WoDeNuanQiFeiViewController.h"
#import "WoDeShuiFeiViewController.h"
#import "WoDeTingCheFeiViewController.h"
@interface WoDeZhangDanViewController ()

@end

@implementation WoDeZhangDanViewController
@synthesize btn_nuanqifei,btn_shuifei,btn_tingcheguanlifei,btn_wuyefei;
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
    btn_wuyefei.layer.borderWidth=1;
    btn_wuyefei.layer.masksToBounds=YES;
    btn_wuyefei.layer.cornerRadius=6;
    btn_wuyefei.layer.borderColor=[[UIColor orangeColor] CGColor];
    
    btn_shuifei.layer.borderWidth=1;
    btn_shuifei.layer.masksToBounds=YES;
    btn_shuifei.layer.cornerRadius=6;
    btn_shuifei.layer.borderColor=[[UIColor orangeColor] CGColor];
    
    btn_nuanqifei.layer.borderWidth=1;
    btn_nuanqifei.layer.masksToBounds=YES;
    btn_nuanqifei.layer.cornerRadius=6;
    btn_nuanqifei.layer.borderColor=[[UIColor orangeColor] CGColor];
    
    btn_tingcheguanlifei.layer.borderWidth=1;
    btn_tingcheguanlifei.layer.masksToBounds=YES;
    btn_tingcheguanlifei.layer.cornerRadius=6;
    btn_tingcheguanlifei.layer.borderColor=[[UIColor orangeColor] CGColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chakan_wuyefei:(id)sender
{
    WoDeWuYeFeiViewController *wuyefei=[[WoDeWuYeFeiViewController alloc]init];
    [self presentViewController:wuyefei animated:NO completion:nil];
}

- (IBAction)chakan_nuanqifei:(id)sender
{
    WoDeNuanQiFeiViewController *wuyefei=[[WoDeNuanQiFeiViewController alloc]init];
    [self presentViewController:wuyefei animated:NO completion:nil];
}

- (IBAction)chakan_shuifei:(id)sender
{
    WoDeShuiFeiViewController *wuyefei=[[WoDeShuiFeiViewController alloc]init];
    [self presentViewController:wuyefei animated:NO completion:nil];
}

- (IBAction)chakan_tingchefei:(id)sender
{
    WoDeTingCheFeiViewController *wuyefei=[[WoDeTingCheFeiViewController alloc]init];
    [self presentViewController:wuyefei animated:NO completion:nil];
}

- (IBAction)fanhui:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
