//
//  XiuGaiMiMaViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-12.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XiuGaiMiMaViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield_jiumima;
@property (weak, nonatomic) IBOutlet UITextField *textfield_xinmima;
@property (weak, nonatomic) IBOutlet UITextField *textfield_querenmima;
@property (weak, nonatomic) IBOutlet UIButton *btn_xiugaimima;
- (IBAction)fanhui:(id)sender;
- (IBAction)xiugaimima:(id)sender;

@end
