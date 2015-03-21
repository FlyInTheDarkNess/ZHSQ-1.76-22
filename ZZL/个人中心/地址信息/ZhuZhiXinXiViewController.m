//
//  ZhuZhiXinXiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-9-22.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ZhuZhiXinXiViewController.h"
#import "SheQuXuanZeViewController.h"
#import "DengLuHouZhuYeViewController.h"
#import "MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "LouYuHao.h"
#import "DanYuan.h"
#import "FangJian.h"
#import "BaoCunXinXi.h"
#import "URL.h"
#import "JiaMiJieMi.h"

extern NSString *Session;
extern NSString *rowString;
extern NSString *xiaoquIDString;
extern NSString *xiaoquming;
extern NSString *str_zhuzhi;
extern int CommunitySelectionSource;
extern int IsFiirst;
@interface ZhuZhiXinXiViewController ()

@end

@implementation ZhuZhiXinXiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    label1.text=xiaoquming;
}

- (void)viewDidLoad
{
    @try
    {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    IsFiirst=2;
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

    beijing_view=[[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, Hidth-20)];
    beijing_view.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.8];
    label9=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 40)];
    label9.backgroundColor=[UIColor blackColor];
    label9.text=@"选择前往地址";
    [label9 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label9.textColor=[UIColor whiteColor];
    [beijing_view addSubview:label9];
    tableview_louyu=[[UITableView alloc]initWithFrame:CGRectMake(20, 60, 280, Hidth-160)];
    tableview_louyu.delegate=self;
    tableview_louyu.dataSource=self;
    tableview_danyuan=[[UITableView alloc]initWithFrame:CGRectMake(20, 60, 280, Hidth-160)];
    tableview_danyuan.delegate=self;
    tableview_danyuan.dataSource=self;
    tableview_fangjian=[[UITableView alloc]initWithFrame:CGRectMake(20, 60, 280, Hidth-160)];
    tableview_fangjian.delegate=self;
    tableview_fangjian.dataSource=self;
    
    label10=[[UILabel alloc]initWithFrame:CGRectMake(20, Hidth-100, 280, 40)];
    label10.backgroundColor=[UIColor grayColor];
    [beijing_view addSubview:label10];
    btn_queding=[[UIButton alloc]initWithFrame:CGRectMake(30, Hidth-95, 120, 30)];
    [btn_queding setTitle:@"确定" forState:UIControlStateNormal];
    [btn_queding setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_queding.backgroundColor=[UIColor whiteColor];
    [btn_queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [beijing_view addSubview:btn_queding];
    btn_quxiao=[[UIButton alloc]initWithFrame:CGRectMake(170, Hidth-95, 120, 30)];
    [btn_quxiao setTitle:@"取消" forState:UIControlStateNormal];
    btn_quxiao.backgroundColor=[UIColor whiteColor];
    [btn_quxiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_quxiao addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [beijing_view addSubview:btn_quxiao];


    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.text=@"住址信息";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:fanhui];
    wancheng=[[UIButton alloc]initWithFrame:CGRectMake(270, 20, 40, 40)];
    [wancheng setTitle:@"完成" forState:UIControlStateNormal];
    [wancheng setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [wancheng addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wancheng];
    label_shuoming=[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 280, 50)];
    label_shuoming.numberOfLines=3;
    label_shuoming.text = @"     笑脸社区会严格保密你的小区、楼宇号、单元号、房间等信息，请放心填写。真实的信息会让您在物业缴费、小区通知等方面第一时间得到信息";
    label_shuoming.font=[UIFont systemFontOfSize:12];
    [self.view addSubview:label_shuoming];
    label_beijing=[[UILabel alloc]initWithFrame:CGRectMake(20, 140, 280, 280)];
    label_beijing.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:label_beijing];
    imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 143, 25, 25)];
    imageview1.image=[UIImage imageNamed:@"icon_xiaoxu0707.png"];
    [self.view addSubview:imageview1];
    label_wodexiaoqu=[[UILabel alloc]initWithFrame:CGRectMake(55, 143, 200, 25)];
    label_wodexiaoqu.text=@"我的小区";
    label_wodexiaoqu.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label_wodexiaoqu];
    btn_wodexiaoqu=[[UIButton alloc]initWithFrame:CGRectMake(20,170, 280, 40)];
    btn_wodexiaoqu.layer.masksToBounds = YES;
    btn_wodexiaoqu.layer.cornerRadius = 5;
    btn_wodexiaoqu.layer.borderWidth = 1;
    btn_wodexiaoqu.layer.borderColor=[[UIColor grayColor] CGColor];
    [btn_wodexiaoqu addTarget:self action:@selector(wodexiaoqu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_wodexiaoqu];

    label1=[[UILabel alloc]initWithFrame:CGRectMake(23, 180, 200, 20)];
    
    label1.textColor=[UIColor blueColor];
    label1.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label1];
    label2=[[UILabel alloc]initWithFrame:CGRectMake(280, 180, 20, 20)];
    label2.text=@">";
    label2.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    
    imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(20, 213, 25, 25)];
    imageview2.image=[UIImage imageNamed:@"icon_xiaoxu0707.png"];
    [self.view addSubview:imageview2];
    label_wodexiaoqu=[[UILabel alloc]initWithFrame:CGRectMake(55, 213, 200, 25)];
    label_wodexiaoqu.text=@"我的楼宇号";
    label_wodexiaoqu.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label_wodexiaoqu];
    btn_wodexiaoqu=[[UIButton alloc]initWithFrame:CGRectMake(20,240, 280, 40)];
    btn_wodexiaoqu.layer.masksToBounds = YES;
    btn_wodexiaoqu.layer.cornerRadius = 5;
    btn_wodexiaoqu.layer.borderWidth = 1;
    btn_wodexiaoqu.layer.borderColor=[[UIColor grayColor] CGColor];
    [btn_wodexiaoqu addTarget:self action:@selector(wodelouyuhao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_wodexiaoqu];
    label3=[[UILabel alloc]initWithFrame:CGRectMake(23, 250, 200, 20)];
    label3.textColor=[UIColor blueColor];
    label3.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label3];
    label4=[[UILabel alloc]initWithFrame:CGRectMake(280, 250, 20, 20)];
    label4.text=@">";
    label4.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label4];
    
    imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(20, 283, 25, 25)];
    imageview3.image=[UIImage imageNamed:@"icon_xiaoxu0707.png"];
    [self.view addSubview:imageview3];
    label_wodexiaoqu=[[UILabel alloc]initWithFrame:CGRectMake(55, 283, 200, 25)];
    label_wodexiaoqu.text=@"我的单元";
    label_wodexiaoqu.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label_wodexiaoqu];
    btn_wodexiaoqu=[[UIButton alloc]initWithFrame:CGRectMake(20,310, 280, 40)];
    btn_wodexiaoqu.layer.masksToBounds = YES;
    btn_wodexiaoqu.layer.cornerRadius = 5;
    btn_wodexiaoqu.layer.borderWidth = 1;
    btn_wodexiaoqu.layer.borderColor=[[UIColor grayColor] CGColor];
    [btn_wodexiaoqu addTarget:self action:@selector(wodedanyuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_wodexiaoqu];
    label5=[[UILabel alloc]initWithFrame:CGRectMake(23, 320, 200, 20)];
    label5.textColor=[UIColor blueColor];
    label5.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label5];
    label6=[[UILabel alloc]initWithFrame:CGRectMake(280, 320, 20, 20)];
    label6.text=@">";
    label6.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label6];
    
    imageview4=[[UIImageView alloc]initWithFrame:CGRectMake(20, 353, 25, 25)];
    imageview4.image=[UIImage imageNamed:@"icon_xiaoxu0707.png"];
    [self.view addSubview:imageview4];
    label_wodexiaoqu=[[UILabel alloc]initWithFrame:CGRectMake(55, 353, 200, 25)];
    label_wodexiaoqu.text=@"我的房间号";
    label_wodexiaoqu.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label_wodexiaoqu];
    btn_wodexiaoqu=[[UIButton alloc]initWithFrame:CGRectMake(20,380, 280, 40)];
    btn_wodexiaoqu.layer.masksToBounds = YES;
    btn_wodexiaoqu.layer.cornerRadius = 5;
    btn_wodexiaoqu.layer.borderWidth = 1;
    btn_wodexiaoqu.layer.borderColor=[[UIColor grayColor] CGColor];
    [btn_wodexiaoqu addTarget:self action:@selector(wodefangjianhao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_wodexiaoqu];
    label7=[[UILabel alloc]initWithFrame:CGRectMake(23, 390, 200, 20)];
    label7.textColor=[UIColor blueColor];
    label7.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label7];
    label8=[[UILabel alloc]initWithFrame:CGRectMake(280, 390, 20, 20)];
    label8.text=@">";
    label8.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label8];
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
-(void)queding
{
    
    [beijing_view removeFromSuperview];
   // [tableView isEqual:tableview_louyu];
}
-(void)quxiao
{
    [beijing_view removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([tableView isEqual:tableview_louyu])
    {
        return arr_info_louyu.count;
    }
    else if ([tableView isEqual:tableview_danyuan])
    {
        return arr_info_danyuan.count;
    }
    else
    {
        return arr_info_fangjian.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [tableview_louyu setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview_danyuan setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview_fangjian setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, 280, 1)];
    label.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [cell addSubview:label];
   // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([tableView isEqual:tableview_louyu])
    {
        cell.textLabel.text=[arr_info_louyu[indexPath.row] objectForKey:@"building_name"];
        
    }
    if ([tableView isEqual:tableview_danyuan])
    {
        cell.textLabel.text=[arr_info_danyuan[indexPath.row] objectForKey:@"unit_name"];
        
    }
    if ([tableView isEqual:tableview_fangjian])
    {
        cell.textLabel.text=[arr_info_fangjian[indexPath.row] objectForKey:@"room_name"];
    }
    cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];
    cell.imageView.highlightedImage=[UIImage imageNamed:@"payeco_plugin_radiobt_bg_checked.png"];
    cell.selected = YES;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tableview_louyu])
    {
        louyuID=[arr_info_louyu[indexPath.row] objectForKey:@"building_id"];
        label3.text=[arr_info_louyu[indexPath.row] objectForKey:@"building_name"];
    
    }
    if ([tableView isEqual:tableview_danyuan])
    {
        danyuanID=[arr_info_danyuan[indexPath.row] objectForKey:@"unit_id"];
        label5.text=[arr_info_danyuan[indexPath.row] objectForKey:@"unit_name"];
        
        
    }
    if ([tableView isEqual:tableview_fangjian])
    {
        fangjianID=[arr_info_fangjian[indexPath.row] objectForKey:@"room_id"];
        label7.text=[arr_info_fangjian[indexPath.row] objectForKey:@"room_name"];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)wodelouyuhao
{
//    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
//    NSString *myString = [userDefaultes stringForKey:@"xiaoquID"];
    @try
    {

    LouYuHao*customer =[[LouYuHao alloc]init];
    customer.session=Session;
    customer.quarter_id=xiaoquIDString;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    
    [HttpPostExecutor postExecuteWithUrlStr:LouYuHao_m24_07 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {

         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
        arr_info_louyu=[rootDic objectForKey:@"info"];
        [self.view addSubview:beijing_view];
        [beijing_view addSubview:tableview_louyu];
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

-(void)wodedanyuan
{
    @try
    {

    DanYuan*customer =[[DanYuan alloc]init];
    customer.session=Session;
    customer.building_id=louyuID;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:DanYuanHao_m24_08 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        //NSLog(@"++++++++++++++++++%@",result);
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {

          NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
        arr_info_danyuan=[rootDic objectForKey:@"info"];
        [self.view addSubview:beijing_view];
        [beijing_view addSubview:tableview_danyuan];
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
-(void)wodefangjianhao
{
    FangJian*customer =[[FangJian alloc]init];
    customer.session=Session;
    customer.unit_id=danyuanID;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:FangJianHao_m24_09 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
       // NSLog(@"++++++++++++++++++%@",result);
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {

          NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
        arr_info_fangjian=[rootDic objectForKey:@"info"];
        [self.view addSubview:beijing_view];
        [beijing_view addSubview:tableview_fangjian];
        }
    }];

}

-(void)wodexiaoqu
{
    CommunitySelectionSource=2;
    SheQuXuanZeViewController *xuanze=[[SheQuXuanZeViewController alloc]init];
    [self presentViewController:xuanze animated:NO completion:nil];
}
-(void)tijiao
{
    @try
    {

        if (label3.text.length==0 || label5.text.length==0 || label7.text.length==0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"" message:@"楼宇号、单元号或房间号还没有填写！" delegate:self cancelButtonTitle:@"只填这些" otherButtonTitles:@"继续完善", nil];
            [aler show];

        }
       
        if (label1.text.length>0 && label3.text.length>0 && label5.text.length>0 && label7.text.length>0)
        {
            BaoCunXinXi*customer =[[BaoCunXinXi alloc]init];
            customer.session=Session;
            customer.unit_id=danyuanID;
            customer.isdefaultshow=@"1";
            customer.room_id=fangjianID;
            customer.quarter_id=xiaoquIDString;
            customer.building_id=louyuID;
            
            
            // NSString *xinxi=[NSString stringWithFormat:@"%@%@%@%@",myString,louyuID,danyuanID,fangjianID];
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            [HttpPostExecutor postExecuteWithUrlStr:BaoCunGeRenXinXi_m24_10 Paramters:Str FinishCallbackBlock:^(NSString *result){
                // 执行post请求完成后的逻辑
                if (result.length<=0)
                {
                    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [aler show];
                }
                else
                {
                    
                    NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                    NSLog(@"%@",str_jiemi);
                    SBJsonParser *parser = [[SBJsonParser alloc] init];
                    NSError *error = nil;
                    NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                    NSString *a=[rootDic objectForKey:@"ecode"];
                    int intb = [a intValue];
                    
                    if (intb==1000)
                    {
                        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jieguo) userInfo:nil repeats:NO];
                        [self showWithCustomView:@"添加成功"];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:rowString forKey:@"xiaoqu"];
                        [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];
                        [userDefaults synchronize];
                        NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",label1.text,label3.text,label5.text,label7.text];
                        
                        [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                        
                        
                    }
                }
            }];

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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex ==0)
    {
        
        NSString *str1 =[NSString stringWithFormat:@"{\"session\":\"%@\",\"quarter_id\":\"%@\",\"isdefaultshow\":\"1\"}",Session,xiaoquIDString];
         NSLog(@"传递参数 ：%@",str1);
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        [HttpPostExecutor postExecuteWithUrlStr:BaoCunXiaoQuXinXi_m24_03 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                NSLog(@"%@",str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                NSString *a=[rootDic objectForKey:@"ecode"];
                int intb = [a intValue];
                
                if (intb==1000)
                {
                    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jieguo) userInfo:nil repeats:NO];
                    [self showWithCustomView:@"添加成功"];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:rowString forKey:@"xiaoqu"];
                    [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];
                    [userDefaults synchronize];
                    NSString *aaa=[NSString stringWithFormat:@"%@",label1.text];
                    
                    [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                    
                    
                }
            }
        }];

        
        
        
    }
    else if(buttonIndex ==1)
    {
        
        
    }
}


-(void)jieguo
{
    //[self dismissViewControllerAnimated:NO completion:nil];
    DengLuHouZhuYeViewController *zhuye=[[DengLuHouZhuYeViewController alloc]init];
    [self presentViewController:zhuye animated:NO completion:nil];
    
    
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

-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
