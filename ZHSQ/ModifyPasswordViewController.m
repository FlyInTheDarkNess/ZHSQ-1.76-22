//
//  ModifyPasswordViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-22.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "SerializationComplexEntities.h"
#import "RegistrationAndLoginAndFindHttpService.h"
#import "MyMD5.h"

#import "URL.h"
#import "JiaMiJieMi.h"
#import "xiugaimima.h"
extern NSString *Session;
@interface ModifyPasswordViewController ()
{
    RegistrationAndLoginAndFindHttpService *sqHttpSer;
}
@end

@implementation ModifyPasswordViewController
@synthesize btn_xiugaimima,textfield_jiumima,textfield_querenmima,textfield_xinmima;

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
    btn_xiugaimima.layer.borderWidth=1;
    btn_xiugaimima.layer.masksToBounds=YES;
    btn_xiugaimima.layer.cornerRadius=6;
    btn_xiugaimima.layer.borderColor=[[UIColor grayColor] CGColor];
    
    textfield_jiumima.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_jiumima.secureTextEntry = YES;//不显示密码 ，用圆点代替
    textfield_jiumima.delegate=self;
    
    textfield_xinmima.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_xinmima.secureTextEntry = YES;//不显示密码 ，用圆点代替
    textfield_xinmima.delegate=self;
    
    textfield_querenmima.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_querenmima.secureTextEntry = YES;//不显示密码 ，用圆点代替
    textfield_querenmima.delegate=self;

}
- (IBAction)xiugaimima:(id)sender
{
    @try
    {
        if (textfield_jiumima==nil||textfield_jiumima.text.length==0)
        {
             [SVProgressHUD showErrorWithStatus:@"请输入旧密码" duration:1];
            
        }
        else  if (textfield_xinmima==nil||textfield_xinmima.text.length==0)
            
        {
            [SVProgressHUD showErrorWithStatus:@"请输入新密码" duration:1];
        }
        else if (textfield_querenmima==nil||textfield_querenmima.text.length==0)
        {
            [SVProgressHUD showErrorWithStatus:@"请再次输入新密码" duration:1];
            
        }
        else
        {
            if ([textfield_xinmima.text isEqualToString:textfield_querenmima.text])
            {
                NSString *oldmima;
                NSString *newmima;
                xiugaimima*customer =[[xiugaimima alloc]init];
                
                oldmima=[MyMD5 md5:textfield_jiumima.text];
                newmima=[MyMD5 md5:textfield_querenmima.text];
                
                customer.oldpassword =oldmima;
                customer.session=Session;
                customer.newpassword=newmima;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                sqHttpSer.strUrl = XiuGaiMiMa_m1_09;
                sqHttpSer.delegate = self;
                sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                [sqHttpSer beginQuery];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"俩次输入的密码不一致" duration:1];
            }
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        UIAlertView * alert =
        [[UIAlertView alloc]
         initWithTitle:@"错误"
         message: [[NSString alloc] initWithFormat:@"%@",e]
         delegate:self
         cancelButtonTitle:nil
         otherButtonTitles:@"OK", nil];
        [alert show];
        return;
    }
    
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 5:{
            NSLog(@"%@",sqHttpSer.responDict);
            int inta = [[sqHttpSer.responDict objectForKey:@"ecode"] intValue];
            
            if (inta==1000)
            {
                [SVProgressHUD showErrorWithStatus:@"修改密码成功" duration:1];
                [self dismissViewControllerAnimated:NO completion:nil];

                
            }
            else if (inta==4000)
            {
                [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1];
                return;
                
            }
            
        }
            break;
            default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag
{
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textfield_jiumima resignFirstResponder];
    [textfield_querenmima resignFirstResponder];
    [textfield_xinmima resignFirstResponder];
    
    return YES;
    
}

- (IBAction)fanhui:(id)sender
{
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
