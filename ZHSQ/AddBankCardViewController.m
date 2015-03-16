//
//  AddBankCardViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-2-6.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "PersonCenterHttpService.h"
#import "MyBankCardViewController.h"
extern NSString *Session;
@interface AddBankCardViewController ()
{
    
    //评论ID
    NSArray *idList;
    //请求
    PersonCenterHttpService  *sqLtHttpSer;
    //当前列表数据
    NSMutableArray *postArr;
    
    int startIndex;
    NSInteger btnIndexPath;
    BOOL isUp;
}

@end

@implementation AddBankCardViewController
@synthesize tianjia_btn,beijing_label,textfield_shenfenzheng,textfield_yinhangka,delegate_;
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
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = @"添加新银行卡";

    tianjia_btn.layer.masksToBounds = YES;
    tianjia_btn.layer.cornerRadius = 6;
    beijing_label.layer.masksToBounds = YES;
    beijing_label.layer.cornerRadius = 6;
    textfield_yinhangka.returnKeyType=UIReturnKeyDone;
    textfield_shenfenzheng.returnKeyType=UIReturnKeyDone;

    
    
}
-(void)backUpper
{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    
}
//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [textfield_shenfenzheng resignFirstResponder];
    [textfield_yinhangka resignFirstResponder];
    
    return YES;
    
}


- (IBAction)tianjia:(id)sender {
    [SVProgressHUD showWithStatus:@"正在向服务器提交信息，请稍等..."];
    if (!textfield_yinhangka.text.length>0 ||!textfield_shenfenzheng.text.length>0)
    {
        [SVProgressHUD showErrorWithStatus:@"银行卡号或身份证号未填写" duration:1.5];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"card1\":%@,\"card2\":%@}",Session,textfield_yinhangka.text,textfield_shenfenzheng.text];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtHttpSer = [[PersonCenterHttpService alloc]init];
    sqLtHttpSer.strUrl = YinHangKa_m1_21;
    sqLtHttpSer.delegate = self;
    sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtHttpSer beginQuery];
    isUp = YES;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 21:{
            NSLog(@"%@",sqLtHttpSer.responDict);
            NSDictionary *dic=sqLtHttpSer.responDict;
            int ecode=[[dic objectForKey:@"ecode"] intValue];
            if (ecode==1000)
            {
                [SVProgressHUD showSuccessWithStatus:@"绑定成功" duration:1.5];
                [delegate_ DataInit];
                [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"绑定失败" duration:1.5];
            }
        }
            break;
              default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    
}

@end
