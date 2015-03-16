//
//  CheLiangXinXiYiLanViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "CheLiangXinXiYiLanViewController.h"
#import "CheLiangXinXiViewController.h"
#import "TianJiaCheLiangViewController.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "BangDingXinXi.h"
extern NSString *Session;
extern NSDictionary *QiChe_Dictionary;
extern NSDictionary *PersonInformationDictionary;
@interface CheLiangXinXiYiLanViewController ()

@end

@implementation CheLiangXinXiYiLanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.text=@"我的汽车";
    label_title.textColor=[UIColor whiteColor];
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label_title];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn_fanhui];
    btn_tianjia=[[UIButton alloc]initWithFrame:CGRectMake(270, 20, 40, 40)];
    [btn_tianjia setTitle:@"添加" forState:UIControlStateNormal];
    [btn_tianjia setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_tianjia addTarget:self action:@selector(tianjia) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_tianjia];
    
    
    
    
    
    
    BangDingXinXi*customer =[[BangDingXinXi alloc]init];
    customer.session =Session;
    
    NSString *str1_bangding = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jia=[JiaMiJieMi hexStringFromString:str1_bangding];
    NSString *str2=@"para=";
    NSString *Str_bangding;
    Str_bangding=[str2 stringByAppendingString:str_jia];
    [HttpPostExecutor postExecuteWithUrlStr:YongHuBangDingXinXi_m1_13 Paramters:Str_bangding FinishCallbackBlock:^(NSString *result)
     {
         // 执行post请求完成后的逻辑
         //NSLog(@"第二次:登录 %@", result);
         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        // NSLog(@"住址信息： %@", str_jiemi);
         
         SBJsonParser *parser = [[SBJsonParser alloc] init];
         NSError *error = nil;
         NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
         
         
         NSString *a=[rootDic objectForKey:@"ecode"];
         int intb = [a intValue];
         
         if (intb==1000)
         {
             arr_Car=[rootDic objectForKey:@"car_info"];
             if (arr_Car.count>0)
             {
                 mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 65, 320, Hidth-65)];
                 mytableview.dataSource=self;
                 mytableview.delegate=self;
                 [self.view addSubview:mytableview];
             }
             else
             {
                 label_PromptInformation=[[UILabel alloc]initWithFrame:CGRectMake(0, 70, Width, 40)];
                 label_PromptInformation.text=@"无车辆记录";
                 label_PromptInformation.textColor=[UIColor grayColor];
                 label_PromptInformation.textAlignment=NSTextAlignmentCenter;
                 [self.view addSubview:label_PromptInformation];
                 
             }

         }
         if (intb==4000)
         {
             [self showWithCustomView:@"服务器内部错误"];
         }
     }];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    {
    if (50*arr_Car.count<Hidth-65)
    {
        mytableview.frame=CGRectMake(0, 65, 320, 50*arr_Car.count);
    }
    else
    {
        mytableview.frame=CGRectMake(0, 65, 320, Hidth-65);

    }
    }
    return arr_Car.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (arr_Car.count>0)
    {
        cell.textLabel.text=[arr_Car[indexPath.row] objectForKey:@"car_code"];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
        label.backgroundColor=[UIColor grayColor];
        [cell.contentView addSubview:label];
    }
    else
    {
         cell.textLabel.text=@"没有车辆记录";
    }
    // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QiChe_Dictionary=arr_Car[indexPath.row];
    CheLiangXinXiViewController *xinxi=[[CheLiangXinXiViewController alloc]init];
    [self presentViewController:xinxi animated:NO completion:nil];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)tianjia
{
    TianJiaCheLiangViewController *tianjia=[[TianJiaCheLiangViewController alloc]init];
    [self presentViewController:tianjia animated:NO completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
