//
//  WoDeShuiFeiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "WoDeShuiFeiViewController.h"
#import "WoDeShuiFei_WeiJiaoViewController.h"
#import "WoDeShuiFei_YiJiaoViewController.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "WuYeFei.h"
#import "URL.h"
#import "JiaoFeiCanShu.h"
#import "JiaMiJieMi.h"
NSDictionary *WYF_WeiJiaoDictionary;
NSDictionary *WYF_YiJiaoDictionary;
extern NSDictionary *WYF_Dictionary;
extern NSString *Session;
extern NSString *Address_id;
@interface WoDeShuiFeiViewController ()

@end

@implementation WoDeShuiFeiViewController

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
        self.view.backgroundColor=[UIColor whiteColor];
        CGRect rect=[[UIScreen mainScreen]bounds];
        CGSize size=rect.size;
        CGFloat Width=size.width;
        CGFloat Hidth=size.height;//Hidth 屏幕高度
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

        label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
        label_title.text=@"我的账单";
        [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        label_title.textAlignment=NSTextAlignmentCenter;
        label_title.textColor=[UIColor whiteColor];
        label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_title];
        fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
        [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
        [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:fanhui];
        btn_weijiaofeizhangdan=[[UIButton alloc]initWithFrame:CGRectMake(0, 60, 160, 30)];
        [btn_weijiaofeizhangdan setTitle:@"未缴账单" forState:UIControlStateNormal];
        btn_weijiaofeizhangdan.titleLabel.font=[UIFont systemFontOfSize:14];
        btn_weijiaofeizhangdan.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [btn_weijiaofeizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn_weijiaofeizhangdan addTarget:self action:@selector(weijiao) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_weijiaofeizhangdan];
        btn_lishizhangdan=[[UIButton alloc]initWithFrame:CGRectMake(160, 60, 160, 30)];
        [btn_lishizhangdan setTitle:@"历史账单" forState:UIControlStateNormal];
        btn_lishizhangdan.titleLabel.font=[UIFont systemFontOfSize:14];
        btn_lishizhangdan.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [btn_lishizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn_lishizhangdan addTarget:self action:@selector(lishi) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_lishizhangdan];
        tableview_weijiaofei=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, 320, Hidth-90)];
        tableview_weijiaofei.delegate=self;
        tableview_weijiaofei.dataSource=self;
        
        tableview_lishizhangdan=[[UITableView alloc]initWithFrame:CGRectMake(0, 90, 320, Hidth-90)];
        tableview_lishizhangdan.delegate=self;
        tableview_lishizhangdan.dataSource=self;
        JiaoFeiCanShu *jiaofei =[[JiaoFeiCanShu alloc]init];
        jiaofei.session=Session;
        jiaofei.address_id=Address_id;
        jiaofei.type=@"1";
        jiaofei.flag=@"2";
        jiaofei.date_start=@"";
        jiaofei.date_end=@"";
        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:jiaofei childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        [HttpPostExecutor postExecuteWithUrlStr:KuaiJieJiaoFeiZhuJian_m30_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"更新数据失败" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            NSLog(@"第2次: %@", str_jiemi);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error=nil;
            NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
            NSString *str_tishi=[rootDic objectForKey:@"ecode"];
            intb =[str_tishi intValue];
            if (intb==3007)
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
                label.text=@"未查找到数据";
                label.textAlignment=NSTextAlignmentCenter;
                label.font=[UIFont systemFontOfSize:14];
                [self.view addSubview:label];
            }
            
            if (intb==1000)
            {
                NSString *str=[rootDic objectForKey:@"id_list"];
                WuYeFei *zhangdanid=[[WuYeFei alloc]init];
                zhangdanid.id_list=str;
                
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:zhangdanid childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:ShuiFei_m30_03 Paramters:Str FinishCallbackBlock:^(NSString *result)
                 {
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"更新数据失败" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     NSLog(@"水费%@", str_jiemi);
                     
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     WYF_WeiJiaoDictionary=[parser objectWithString:str_jiemi error:&error];
                     
                     arr_weijiao=[[NSMutableArray array]init];
                     arr_weijiao=[WYF_WeiJiaoDictionary objectForKey:@"info"];
                     [self.view addSubview:tableview_weijiaofei];
                     }
                 }];
            }
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
-(void)lishi
{
    @try
    {
        
        [btn_lishizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn_weijiaofeizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tableview_weijiaofei removeFromSuperview];
        JiaoFeiCanShu *jiaofei =[[JiaoFeiCanShu alloc]init];
        jiaofei.session=Session;
        jiaofei.address_id=Address_id;
        jiaofei.type=@"1";
        jiaofei.flag=@"1";
        jiaofei.date_start=@"";
        jiaofei.date_end=@"";
        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:jiaofei childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        
        [HttpPostExecutor postExecuteWithUrlStr:KuaiJieJiaoFeiZhuJian_m30_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"更新数据失败" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error=nil;
            NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
            NSString *str_tishi=[rootDic objectForKey:@"ecode"];
            intb = [str_tishi intValue];
            if (intb==3007)
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
                label.text=@"未查找到数据";
                label.textAlignment=NSTextAlignmentCenter;
                label.font=[UIFont systemFontOfSize:14];
                [self.view addSubview:label];
            }
            if (intb==1000)
            {
                NSString *str=[rootDic objectForKey:@"id_list"];
                WuYeFei *zhangdanid=[[WuYeFei alloc]init];
                zhangdanid.id_list=str;
                
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:zhangdanid childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                
                [HttpPostExecutor postExecuteWithUrlStr:WuYeFei_m30_02 Paramters:Str FinishCallbackBlock:^(NSString *result)
                 {
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"更新数据失败" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {
                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     WYF_YiJiaoDictionary=[parser objectWithString:str_jiemi error:&error];
                     
                     arr_yijiao=[[NSMutableArray array]init];
                     arr_yijiao=[WYF_YiJiaoDictionary objectForKey:@"info"];
                     
                     [self.view addSubview:tableview_lishizhangdan];
                     
                     }
                 }];
            }
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
-(void)weijiao
{
    @try
    {
        
        [btn_lishizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn_weijiaofeizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [tableview_lishizhangdan removeFromSuperview];
        JiaoFeiCanShu *jiaofei =[[JiaoFeiCanShu alloc]init];
        jiaofei.session=Session;
        jiaofei.address_id=Address_id;
        jiaofei.type=@"1";
        jiaofei.flag=@"2";
        jiaofei.date_start=@"";
        jiaofei.date_end=@"";
        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:jiaofei childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        

        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        
        [HttpPostExecutor postExecuteWithUrlStr:KuaiJieJiaoFeiZhuJian_m30_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"更新数据失败" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error=nil;
            NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
            NSString *str_tishi=[rootDic objectForKey:@"ecode"];
            intb = [str_tishi intValue];
            if (intb==3007)
            {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
                label.text=@"未查找到数据";
                label.textAlignment=NSTextAlignmentCenter;
                label.font=[UIFont systemFontOfSize:14];
                [self.view addSubview:label];
            }
            if (intb==1000)
            {
                NSString *str=[rootDic objectForKey:@"id_list"];
                WuYeFei *zhangdanid=[[WuYeFei alloc]init];
                zhangdanid.id_list=str;
                
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:zhangdanid childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                
                [HttpPostExecutor postExecuteWithUrlStr:ShuiFei_m30_03 Paramters:Str FinishCallbackBlock:^(NSString *result)
                 {
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"更新数据失败" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     NSLog(@" 水费 %@",str_jiemi);
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     WYF_YiJiaoDictionary=[parser objectWithString:str_jiemi error:&error];
                     
                     arr_yijiao=[[NSMutableArray array]init];
                     arr_yijiao=[WYF_YiJiaoDictionary objectForKey:@"info"];
                     
                     
                     [self.view addSubview:tableview_weijiaofei];
                     }
                 }];
            }
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([tableView isEqual:tableview_weijiaofei])
    {
        return arr_weijiao.count;
    }
    else
    {
        return arr_yijiao.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [tableview_weijiaofei setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview_lishizhangdan setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (intb==3007)
    {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, 320, 30)];
        label.text=@"未查找到数据";
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:14];
        [self.view addSubview:label];
    }
    else
    {
        if ([tableView isEqual:tableview_lishizhangdan])
        {
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 320, 20)];
            label.text=[NSString stringWithFormat:@"编号:  %@", [arr_yijiao[indexPath.row] objectForKey:@"pay_id"]];
            label.font=[UIFont systemFontOfSize:12];
            label.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label];
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(30, 30, 40, 20)];
            label2.text=@"姓名:";
            label2.font=[UIFont systemFontOfSize:12];
            label2.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label2];
            UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(70, 30, 320, 20)];
            label3.text=[arr_yijiao[indexPath.row] objectForKey:@"username"];
            label3.textColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];
            label3.font=[UIFont systemFontOfSize:12];
            label3.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label3];
            UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(30, 50, 40, 20)];
            label4.text=@"地址:";
            label4.font=[UIFont systemFontOfSize:12];
            label4.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label4];
            UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(70, 50, 320, 20)];
            label5.text=[NSString stringWithFormat:@"%@%@%@%@%@",[arr_yijiao[indexPath.row] objectForKey:@"community_name"],[arr_yijiao[indexPath.row] objectForKey:@"quarter_name"],[arr_yijiao[indexPath.row] objectForKey:@"building_name"],[arr_yijiao[indexPath.row] objectForKey:@"unit_name"],[arr_yijiao[indexPath.row] objectForKey:@"room_name"]];
            label5.font=[UIFont systemFontOfSize:12];
            label5.textColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];
            label5.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label5];
            UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(30, 70, 40, 20)];
            label6.text=@"期间:";
            label6.font=[UIFont systemFontOfSize:12];
            label6.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label6];
            UILabel *label7=[[UILabel alloc]initWithFrame:CGRectMake(70, 70, 320, 20)];
            label7.text=[NSString stringWithFormat:@"%@-%@", [arr_yijiao[indexPath.row] objectForKey:@"period_start"],[arr_yijiao[indexPath.row] objectForKey:@"peroid_end"]];
            label7.font=[UIFont systemFontOfSize:12];
            label7.textColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];            label7.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label7];
            UILabel *label8=[[UILabel alloc]initWithFrame:CGRectMake(30, 90, 40, 20)];
            label8.text=@"金额:";
            label8.font=[UIFont systemFontOfSize:12];
            label8.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label8];
            UILabel *label9=[[UILabel alloc]initWithFrame:CGRectMake(70, 90, 320, 20)];
            label9.text=[arr_yijiao[indexPath.row] objectForKey:@"money_sum"];
            label9.font=[UIFont systemFontOfSize:12];
            label9.textColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];
            label9.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label9];
            UILabel *label10=[[UILabel alloc]initWithFrame:CGRectMake(0, 119, 320, 1)];
            label10.backgroundColor=[UIColor grayColor];
            [cell addSubview:label10];
            
        }
        if ([tableView isEqual:tableview_weijiaofei])
        {
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30, 10, 320, 20)];
            label.text=[NSString stringWithFormat:@"编号:  %@", [arr_weijiao[indexPath.row] objectForKey:@"pay_id"]];
            label.font=[UIFont systemFontOfSize:12];
            label.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label];
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(30, 30, 40, 20)];
            label2.text=@"姓名:";
            label2.font=[UIFont systemFontOfSize:12];
            label2.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label2];
            UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(70, 30, 320, 20)];
            label3.text=[arr_weijiao[indexPath.row] objectForKey:@"username"];
            label3.textColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];
            label3.font=[UIFont systemFontOfSize:12];
            label3.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label3];
            UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(30, 50, 40, 20)];
            label4.text=@"地址:";
            label4.font=[UIFont systemFontOfSize:12];
            label4.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label4];
            UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(70, 50, 320, 20)];
            label5.text=[NSString stringWithFormat:@"%@%@%@%@%@",[arr_weijiao[indexPath.row] objectForKey:@"community_name"],[arr_weijiao[indexPath.row] objectForKey:@"quarter_name"],[arr_weijiao[indexPath.row] objectForKey:@"building_name"],[arr_weijiao[indexPath.row] objectForKey:@"unit_name"],[arr_weijiao[indexPath.row] objectForKey:@"room_name"]];
            label5.font=[UIFont systemFontOfSize:12];
            label5.textColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];
            label5.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label5];
            UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(30, 70, 40, 20)];
            label6.text=@"期间:";
            label6.font=[UIFont systemFontOfSize:12];
            label6.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label6];
            UILabel *label7=[[UILabel alloc]initWithFrame:CGRectMake(70, 70, 320, 20)];
            label7.text=[NSString stringWithFormat:@"%@-%@", [arr_weijiao[indexPath.row] objectForKey:@"period_start"],[arr_weijiao[indexPath.row] objectForKey:@"peroid_end"]];
            label7.font=[UIFont systemFontOfSize:12];
            label7.textColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];            label7.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label7];
            UILabel *label8=[[UILabel alloc]initWithFrame:CGRectMake(30, 90, 40, 20)];
            label8.text=@"金额:";
            label8.font=[UIFont systemFontOfSize:12];
            label8.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label8];
            UILabel *label9=[[UILabel alloc]initWithFrame:CGRectMake(70, 90, 320, 20)];
            label9.text=[arr_weijiao[indexPath.row] objectForKey:@"money_sum"];
            label9.font=[UIFont systemFontOfSize:12];
            label9.textColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];
            label9.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
            [cell addSubview:label9];
            UILabel *label10=[[UILabel alloc]initWithFrame:CGRectMake(0, 119, 320, 1)];
            label10.backgroundColor=[UIColor grayColor];
            [cell addSubview:label10];
            
        }
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tableview_lishizhangdan])
    {
        WYF_Dictionary=arr_yijiao[indexPath.row];
        WoDeShuiFei_YiJiaoViewController *xiangqing=[[WoDeShuiFei_YiJiaoViewController alloc]init];
        [self presentViewController:xiangqing animated:NO completion:nil];
        
    }
    else
    {
        WYF_Dictionary=arr_weijiao[indexPath.row];
        WoDeShuiFei_WeiJiaoViewController *xiangqing=[[WoDeShuiFei_WeiJiaoViewController alloc]init];
        [self presentViewController:xiangqing animated:NO completion:nil];
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)fanhui
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
