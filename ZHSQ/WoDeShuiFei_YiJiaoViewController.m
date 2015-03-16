//
//  WoDeShuiFei_YiJiaoViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "WoDeShuiFei_YiJiaoViewController.h"
extern NSDictionary *WYF_Dictionary;

@interface WoDeShuiFei_YiJiaoViewController ()

@end

@implementation WoDeShuiFei_YiJiaoViewController
@synthesize label_danbeibianhao,label_danjia,label_jianzhumianji,label_kehudizhi,label_kehuxingming,label_shoufeidanwei,label_wuyefei,label_xufeiqijian,label_xufeiren,label_xufeiriqi,label_yingjiaojine,label_youhuijine;

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
    label_xufeiriqi.text=[WYF_Dictionary objectForKey:@"pay_date"];
    label_xufeiren.text=[WYF_Dictionary objectForKey:@"pay_name"];

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fanhui:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
