//
//  TianJiaCheLiangViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "TianJiaCheLiangViewController.h"
#import "DengLuHouZhuYeViewController.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "cheliangxinxi.h"
extern NSString *Session;
@interface TianJiaCheLiangViewController ()

@end

@implementation TianJiaCheLiangViewController
@synthesize label_beijing,label_zhuzhi,btn_cheliangxinghao,btn_jiancheng,textfield_chepaihao,textfield_shibiema;
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
    self.view.backgroundColor=[UIColor whiteColor];
    arr1=[[NSMutableArray alloc]initWithObjects:@"大型汽车",@"小型汽车",@"普通摩托车",@"轻便摩托车",@"低速车",@"拖拉机",@"挂车", nil];
    arr2=[[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07", nil];
    NSUserDefaults *userDefaulte= [NSUserDefaults standardUserDefaults];
    NSString *myString_zhanghao = [userDefaulte stringForKey:@"dizhixinxi"];
    label_zhuzhi.text=myString_zhanghao;
    
    label_beijing.layer.borderWidth=1;
    label_beijing.layer.masksToBounds=YES;
    label_beijing.layer.cornerRadius=6;
    label_beijing.layer.borderColor=[[UIColor grayColor] CGColor];
    
    btn_cheliangxinghao.layer.borderWidth=1;
    btn_cheliangxinghao.layer.masksToBounds=YES;
    btn_cheliangxinghao.layer.cornerRadius=6;
    btn_cheliangxinghao.layer.borderColor=[[UIColor grayColor] CGColor];
    [btn_cheliangxinghao setTitle:@"大型汽车" forState:UIControlStateNormal];
    
    
    textfield_shibiema.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_shibiema.delegate=self;
    textfield_chepaihao.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    textfield_chepaihao.delegate=self;

    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(50, 100, 220, 210)];
    mytableview.dataSource=self;
    mytableview.delegate=self;
    str=@"01";

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr1.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=arr1[indexPath.row];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 29, 220, 1)];
    label.backgroundColor=[UIColor grayColor];
    [cell.contentView addSubview:label];
    // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    str=arr2[indexPath.row];
    [btn_cheliangxinghao setTitle:arr1[indexPath.row] forState:UIControlStateNormal];
    [mytableview removeFromSuperview];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}


-(void)showWithCustomView:(NSString*)aString
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}
- (IBAction)btn_fanhui:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)btn_wancheng:(id)sender
{
    cheliangxinxi*customer =[[cheliangxinxi alloc]init];
    customer.platet_num =[NSString stringWithFormat:@"鲁s%@",textfield_chepaihao.text];
    customer.session=Session;
    customer.platet_type=str;
    customer.identification_code=textfield_shibiema.text;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:CheLiangXinXi_m1_14 Paramters:Str FinishCallbackBlock:^(NSString *result)
     {
         // 执行post请求完成后的逻辑
         //NSLog(@"第二次:登录 %@", result);
         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
         //NSLog(@"json→ %@", str_jiemi);
         
         SBJsonParser *parser = [[SBJsonParser alloc] init];
         NSError *error = nil;
         NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
         NSString *str_tishi=[rootDic objectForKey:@"ecode"];
         int intb = [str_tishi intValue];
         if (intb==1000)
         {
             DengLuHouZhuYeViewController *zhongxin=[[DengLuHouZhuYeViewController alloc]init];
             [self presentViewController:zhongxin animated:NO completion:nil];
         }
         if (intb==4000)
         {
             [self showWithCustomView:@"系统内部错误"];
             
         }
     }];
    
}

- (IBAction)xuanzeqicheleixing:(id)sender
{
    [self.view addSubview:mytableview];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textfield_shibiema resignFirstResponder];
    [textfield_chepaihao resignFirstResponder];

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
