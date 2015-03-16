//
//  KuaiJieJiaoFeiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-9-26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KuaiJieJiaoFeiViewController : UIViewController
{
    NSMutableArray *arr;
}
- (IBAction)btn_fanhui:(id)sender;
- (IBAction)btn_wuyefei:(id)sender;
- (IBAction)btn_tingcheguanlifei:(id)sender;
- (IBAction)btn_shuifei:(id)sender;
- (IBAction)btn_dianfei:(id)sender;
- (IBAction)btn_nuanqifei:(id)sender;

- (IBAction)btn_yidongjiaofei:(id)sender;
- (IBAction)btn_liantongjiaofei:(id)sender;
- (IBAction)btn_dianxinjiaofei:(id)sender;
- (IBAction)btn_youxiandianshi:(id)sender;

@end
