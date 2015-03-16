//
//  QieHuanViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-29.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "QieHuanViewController.h"
#import "DengLuHouZhuYeViewController.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "ZhuXiao.h"
#import "denglu.h"

#import "CheckNetwork.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "UIScrollView+MJRefresh.h"
extern NSString *Session;
extern NSString *community_id;
extern NSString *xiaoquIDString;
extern NSString *xiaoquming;
extern NSString *string_Account;
extern NSString *string_Password;

@interface QieHuanViewController ()

@end

@implementation QieHuanViewController
@synthesize delegate_;
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
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];
   
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.text=@"切换小区";
    label.textColor=[UIColor whiteColor];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:fanhui];
    
    UIButton *fabu=[[UIButton alloc]initWithFrame:CGRectMake(260, 20, 40, 40)];
    [fabu addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [fabu setTitle:@"完成" forState:UIControlStateNormal];
    fabu.titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:fabu];

    

    mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth - 60) style:UITableViewStylePlain];
    mytableview.backgroundColor = [UIColor whiteColor];
    mytableview.delegate = self;
    mytableview.dataSource = self;
    
    [self.view addSubview:mytableview];
    
    [mytableview addHeaderWithTarget:self action:@selector(storeDataInit)];
    [mytableview headerBeginRefreshing];

}
-(void)storeDataInit
{
    ZhuXiao*customer =[[ZhuXiao alloc]init];
    customer.session=Session;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:QieHuanXiaoQu_m1_13 Paramters:Str FinishCallbackBlock:^(NSString *result){
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
            NSLog(@"第2次: %@", str_jiemi);//result就是NSString类型的返回值
            
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
            NSString *a=[rootDic objectForKey:@"ecode"];
            int intb = [a intValue];
            
            if (intb==3007)
            {
                [self showWithCustomView:@"没有查找到数据"];
                [mytableview headerEndRefreshing];
                return ;

            }
            if (intb==1000)
            {
                arr_info=[rootDic objectForKey:@"address_info"];
                [mytableview headerEndRefreshing];
                [mytableview reloadData];
            }
            if (intb==4000)
            {
                [self showWithCustomView:@"服务器内部错误"];
                [mytableview headerEndRefreshing];
            }
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

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (arr_info.count>0)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, 280, 1)];
        label.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [cell addSubview:label];
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[arr_info[indexPath.row] objectForKey:@"community_name"],[arr_info[indexPath.row] objectForKey:@"quarter_name"],[arr_info[indexPath.row] objectForKey:@"building_name"],[arr_info[indexPath.row] objectForKey:@"unit_name"],[arr_info[indexPath.row] objectForKey:@"room_name"]];
        
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];//未选cell时的图片
        if ([[arr_info[indexPath.row] objectForKey:@"isdefaultshow"] isEqualToString:@"1"])
        {
            NSIndexPath *first = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            [mytableview selectRowAtIndexPath:first animated:NO  scrollPosition:UITableViewScrollPositionBottom];
        }
        cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];
        cell.imageView.highlightedImage=[UIImage imageNamed:@"payeco_plugin_radiobt_bg_checked.png"];
        cell.selected = YES;

        
    }
    else
    {
        [self showWithCustomView:@"没有查找到数据"];
    }
        return cell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[mytableview cellForRowAtIndexPath:indexPath];
    sss=cell.textLabel.text;
    str_address_id=[arr_info[indexPath.row] objectForKey:@"address_id"];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arr_info.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)tijiao
{
    @try
    {
        
        QieHuanZhuZhiXinXi*customer =[[QieHuanZhuZhiXinXi alloc]init];
        customer.session=Session;
        customer.address_id=str_address_id;
        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        NSLog(@": %@", str1);
        [HttpPostExecutor postExecuteWithUrlStr:QieHuanZhuZhiXinXi_24_012 Paramters:Str FinishCallbackBlock:^(NSString *result){
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
                NSLog(@"第2次: %@", str_jiemi);//result就是NSString类型的返回值
                
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                NSString *a=[rootDic objectForKey:@"ecode"];
                int intb = [a intValue];
                if (intb==1000)
                {
                    [self showWithCustomView:@"切换成功"];
                    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jieguo) userInfo:nil repeats:NO];
                    
                }
                if (intb==4000)
                {
                    [self showWithCustomView:@"服务器内部错误"];
                }
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:sss forKey:@"dizhixinxi"];
               
                
            }
        }];
        
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
-(void)jieguo
{
    denglu*customer =[[denglu alloc]init];
    
    mima=[MyMD5 md5:string_Password];
    customer.password =mima;
    
    customer.username=string_Account;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    
    
    
    [HttpPostExecutor postExecuteWithUrlStr:YongHuBangDingXinXi_m1_17 Paramters:Str FinishCallbackBlock:^(NSString *result)
     {
         // 执行post请求完成后的逻辑
         //NSLog(@"第二次:登录 %@", result);
         if (result.length<=0)
         {
             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"更新数据失败" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [aler show];
         }
         else
         {
             
             NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
             NSLog(@"第二次:登录 %@", str_jiemi);
             SBJsonParser *parser = [[SBJsonParser alloc] init];
             NSError *error = nil;
             NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
             [SurveyRunTimeData sharedInstance].session = [rootDic objectForKey:@"session"];
             [SurveyRunTimeData sharedInstance].mobilePhone = rootDic[@"person_info"][0][@"mobile_phone"];
             Session=[rootDic objectForKey:@"session"];
             NSString *str_tishi=[rootDic objectForKey:@"ecode"];
             int intb = [str_tishi intValue];
             if (intb==1000)
             {
                 arr_info=[rootDic objectForKey:@"address_info"];
                 arr_addressidentify=[[NSMutableArray alloc]init];
                 for (int i=0; i<[arr_info count]; i++)
                 {
                     NSString *string=[[arr_info objectAtIndex:i] objectForKey:@"isdefaultshow"];
                     [arr_addressidentify addObject:string];
                 }
                 if (arr_info.count>0)
                 {
                     //判断数组中是否有1存在，有则就有默认住址，没有就选择第一个
                     if ([arr_addressidentify containsObject:@"1"])
                     {
                         for (int i=0; i<[arr_info count]; i++)
                         {
                             NSString *string=[[arr_info objectAtIndex:i] objectForKey:@"isdefaultshow"];
                             if ([string isEqualToString:@"1"])
                             {
                                 // NSLog(@"是  1");
                                 NSDictionary *Dic=[arr_info objectAtIndex:i];
                                 xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                                 xiaoquming=[Dic objectForKey:@"quarter_name"];
                                 community_id=[Dic objectForKey:@"community_id"];
                                 NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                 [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                             }
                             else
                             {
                                 //NSLog(@"不是  1");
                             }
                         }
                         
                     }
                     else
                     {
                         NSDictionary *Dic=[arr_info objectAtIndex:0];
                         xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                         xiaoquming=[Dic objectForKey:@"quarter_name"];
                         NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                         [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                         [userDefaults setObject:xiaoquming forKey:@"xiaoqu"];
                         [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];
                         
                     }
                     
                     
                 }
                 DengLuHouZhuYeViewController *denglu=[[DengLuHouZhuYeViewController alloc]init];
                 [self presentViewController:denglu animated:YES completion:nil];
                //[self dismissViewControllerAnimated:NO completion:nil];
                 
                 
             }
             if (intb==3101)
             {
                 [self showWithCustomView:@"用户不存在"];
             }
             
             if (intb==3102)
             {
                 [self showWithCustomView:@"密码错误"];
             }
         }
     }];


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
