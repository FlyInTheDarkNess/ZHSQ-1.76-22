//
//  OpinionsFeedbackViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpinionsFeedbackViewController : UIViewController<UITextFieldDelegate>
{
    NSString *str_device;
}
@property (weak, nonatomic) IBOutlet UITextField *textfield_QQ;
@property (weak, nonatomic) IBOutlet UITextField *textfield_emile;
@property (weak, nonatomic) IBOutlet UITextField *textfield_mobel;
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *Btn_Submit;
- (IBAction)Submit:(id)sender;
- (IBAction)fanhui:(id)sender;

@end
