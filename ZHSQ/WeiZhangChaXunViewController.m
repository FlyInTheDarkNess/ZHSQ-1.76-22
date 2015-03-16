//
//  WeiZhangChaXunViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-9-24.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "WeiZhangChaXunViewController.h"
#import "WeiZhangXiangQingViewController.h"
#import "MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "WeiZhangChaXun.h"
#import "URL.h"
#import "JiaMiJieMi.h"
extern NSDictionary *WeiZhangJiLuDictionary;

@interface WeiZhangChaXunViewController ()

@end

@implementation WeiZhangChaXunViewController

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
    @try
    {

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度

    label_laiwushi.layer.masksToBounds = YES;
    label_laiwushi.layer.cornerRadius = 5;
    label_laiwushi.layer.borderWidth = 0.5;
    label_laiwushi.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_qichezhonglei.layer.masksToBounds = YES;
    btn_qichezhonglei.layer.cornerRadius = 5;
    btn_qichezhonglei.layer.borderWidth = 0.5;
    btn_qichezhonglei.layer.borderColor=[[UIColor grayColor] CGColor];
    label_beijing.layer.masksToBounds = YES;
    label_beijing.layer.cornerRadius = 5;
    label_beijing.layer.borderWidth = 0.5;
    label_beijing.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_diming.layer.masksToBounds = YES;
    btn_diming.layer.cornerRadius = 5;
    btn_diming.layer.borderWidth = 0.5;
    btn_diming.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_chaxun.layer.masksToBounds = YES;
    btn_chaxun.layer.cornerRadius = 5;
    btn_chaxun.layer.borderWidth = 0.5;
    btn_chaxun.layer.borderColor=[[UIColor grayColor] CGColor];
    _textfiled_haoma.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    _textfiled_shibiema.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    view_beijing=[[UIView alloc]initWithFrame:CGRectMake(0, 20, Width, Hidth-20)];
    view_beijing.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.8];
    tableview_qichezhonglei=[[UITableView alloc]initWithFrame:CGRectMake(30, 0.25*Hidth, 260, 210)];
    tableview_qichezhonglei.delegate=self;
    tableview_qichezhonglei.dataSource=self;
    tableview_diyu=[[UITableView alloc]initWithFrame:CGRectMake(30, 0.25*Hidth, 260, 30)];
    tableview_diyu.delegate=self;
    tableview_diyu.dataSource=self;
    arr=[[NSMutableArray alloc]initWithObjects:@"大型汽车",@"小型汽车",@"普通摩托车",@"轻便摩托车",@"低速车",@"拖拉机",@"挂车", nil];
    arr2=[[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07", nil];
    str_leixing=@"02";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tableview_qichezhonglei])
    {
        return arr.count;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [tableview_qichezhonglei setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview_diyu setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 29, 320, 1)];
    label.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [cell addSubview:label];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([tableView isEqual:tableview_qichezhonglei])
    {
        cell.textLabel.text=arr[indexPath.row];
    }
    if ([tableView isEqual:tableview_diyu])
    {
        cell.textLabel.text=@"鲁";
    }
    cell.textLabel.font=[UIFont systemFontOfSize:16];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {

    if ([tableView isEqual:tableview_qichezhonglei])
    {
        [btn_qichezhonglei setTitle:arr[indexPath.row] forState:UIControlStateNormal];
        str_leixing=arr2[indexPath.row];
        [tableview_qichezhonglei removeFromSuperview];
        [view_beijing removeFromSuperview];
    }
    else
    {
        [btn_diming setTitle:@"鲁" forState:UIControlStateNormal];
        [tableview_diyu removeFromSuperview];
        [view_beijing removeFromSuperview];

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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
- (IBAction)xuanzezhonglei:(id)sender {
    [self.view addSubview:view_beijing];
    [view_beijing addSubview:tableview_qichezhonglei];
}

- (IBAction)diming:(id)sender {
    [self.view addSubview:view_beijing];
    [view_beijing addSubview:tableview_diyu];
    
}

- (IBAction)chaxun:(id)sender {
    @try
    {
    
    WeiZhangChaXun*customer =[[WeiZhangChaXun alloc]init];
    customer.platet_num=[NSString stringWithFormat:@"鲁S%@",_textfiled_haoma.text];
    customer.platet_type=str_leixing;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:WeiZhangChaXun_m33_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        //NSLog(@"第2次: %@", result);//result就是NSString类型的返回值
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {

        NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        NSLog(@"第2次: %@", str_jiemi);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        WeiZhangJiLuDictionary = [parser objectWithString:str_jiemi error:&error];
        int intb = [[WeiZhangJiLuDictionary objectForKey:@"ecode"] intValue];

        if (intb==3301)
        {
            [self showWithCustomView:@"输入的车辆识别代码不正确"];
        }
        if (intb==3302)
        {
            [self showWithCustomView:@"选择的车辆类型不正确"];
        }
        if (intb==3007)
        {
            [self showWithCustomView:@"经查询您的车辆无违章记录，感谢支持"];
        }
        if (intb==1000)
        {
            WeiZhangXiangQingViewController *xiangqing=[[WeiZhangXiangQingViewController alloc]init];
            [self presentViewController:xiangqing animated:NO completion:nil];
        }
        }
    }];
    
   // }
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
- (void)showWithCustomView:(NSString*)aString {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}
- (IBAction)fanhui:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [_textfiled_haoma resignFirstResponder];
    [_textfiled_shibiema resignFirstResponder];
    
    return YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



@end
