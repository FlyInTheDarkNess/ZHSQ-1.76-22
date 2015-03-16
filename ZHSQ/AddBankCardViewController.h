//
//  AddBankCardViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-2-6.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "PushAlertViewDelegate.h"
@interface AddBankCardViewController : AXHBaseViewController<UITextFieldDelegate>
{
    int offset;
    id<PushAlertViewDelegate> delegate;
}
@property (nonatomic, assign) id<PushAlertViewDelegate> delegate_;
@property (weak, nonatomic) IBOutlet UILabel *beijing_label;
@property (weak, nonatomic) IBOutlet UIButton *tianjia_btn;
@property (weak, nonatomic) IBOutlet UITextField *textfield_yinhangka;
@property (weak, nonatomic) IBOutlet UITextField *textfield_shenfenzheng;
- (IBAction)textfiled_shenfenzheng:(id)sender;
- (IBAction)tianjia:(id)sender;

@end
