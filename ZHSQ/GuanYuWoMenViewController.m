//
//  GuanYuWoMenViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "GuanYuWoMenViewController.h"

@interface GuanYuWoMenViewController ()

@end

@implementation GuanYuWoMenViewController

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

- (IBAction)fanhui:(id)sender {
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
