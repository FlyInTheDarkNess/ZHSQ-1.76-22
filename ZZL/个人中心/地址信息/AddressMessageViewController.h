//
//  AddressMessageViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-29.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface AddressMessageViewController : AXHBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *Btn_ShanChu;
@property (weak, nonatomic) IBOutlet UIButton *Btn_TianJia;
@property (weak, nonatomic) IBOutlet UIButton *Btn_QieHuan;

- (IBAction)qiehuan:(id)sender;
- (IBAction)tianjia:(id)sender;
- (IBAction)shanchu:(id)sender;
- (IBAction)fanhui:(id)sender;
@end
