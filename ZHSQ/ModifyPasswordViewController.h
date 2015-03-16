//
//  ModifyPasswordViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-22.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface ModifyPasswordViewController : AXHBaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield_jiumima;
@property (weak, nonatomic) IBOutlet UITextField *textfield_xinmima;
@property (weak, nonatomic) IBOutlet UITextField *textfield_querenmima;
@property (weak, nonatomic) IBOutlet UIButton *btn_xiugaimima;
- (IBAction)fanhui:(id)sender;
- (IBAction)xiugaimima:(id)sender;

@end
