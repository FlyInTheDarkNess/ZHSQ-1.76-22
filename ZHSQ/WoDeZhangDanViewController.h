//
//  WoDeZhangDanViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WoDeZhangDanViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btn_wuyefei;
@property (weak, nonatomic) IBOutlet UIButton *btn_nuanqifei;
@property (weak, nonatomic) IBOutlet UIButton *btn_shuifei;
@property (weak, nonatomic) IBOutlet UIButton *btn_tingcheguanlifei;
- (IBAction)chakan_wuyefei:(id)sender;
- (IBAction)chakan_nuanqifei:(id)sender;
- (IBAction)chakan_shuifei:(id)sender;
- (IBAction)chakan_tingchefei:(id)sender;
- (IBAction)fanhui:(id)sender;


@end
