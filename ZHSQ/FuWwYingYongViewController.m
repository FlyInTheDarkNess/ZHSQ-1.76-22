//
//  FuWwYingYongViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-22.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "FuWwYingYongViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "DengLuHouZhuYeViewController.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "CheckNetwork.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"
#import "ShopsDetailsViewController.h"
#import "ShangJiaXinXiViewController.h"
#import "FuWuYingYongXiangQingViewController.h"
#import "zhujianliebiao.h"
#import "URL.h"
#import "JiaMiJieMi.h"
NSString *const FuWuTableViewCellIdentifier = @"Cell";
extern NSDictionary *FUWUdtDictionary;
extern NSString *Session;
extern NSMutableArray *arr_shequfuwu;
extern NSMutableArray *arr_info_shequfuwu;
extern NSString *Type;
extern NSString *SheQuFuWu_Title;
@interface FuWwYingYongViewController ()
{
    NSMutableArray *_fakeData;
    NSMutableArray *shijian;
 }

@end

@implementation FuWwYingYongViewController
@synthesize locationManager;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)dataInit
{
    @try
    {
    if([CheckNetwork isExistenceNetwork]==1)
    {
        
        arr_shequfuwu=[[NSMutableArray alloc]init];
        zhujianliebiao *customer =[[zhujianliebiao alloc]init];
        customer.city_id =@"101";
        customer.servicetype_id=Type;
        customer.distance_scope=fanwei;
        customer.sort_id = paixu;
        customer.latitude=@"";
        customer.longitude=@"";
        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
       // [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 5))]];
        
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str11;
        Str11=[str2 stringByAppendingString:str_jiami];
        [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_08 Paramters:Str11 FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {

            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            NSLog(@"id主键：%@",str_jiemi);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
            
            

            NSArray *shuzu=[[NSArray alloc]init];
            shuzu=[rootDic objectForKey:@"id_list"];
            int i;
            for (i=0; i<[shuzu count]; i++)
            {
                NSDictionary *dic=[[NSDictionary alloc]init];
                dic=[shuzu objectAtIndex:i];
                NSString *stringInt =[dic objectForKey:@"id"];
                [arr_shequfuwu addObject:stringInt];
            }
            
            if ([arr_shequfuwu count]==0)
            {
                [self showWithCustomView:@"暂无此类数据"];
                [tableview_shangjia headerEndRefreshing];

            }

            //NSLog(@"第一次: arrrrrr=%@", arr_shequfuwu);
            if ([shuzu count]<6)
            {
                
                fuwu *customer =[[fuwu alloc]init];
                NSArray *workItems = [[NSArray alloc]initWithArray:shuzu];
                customer.id_list = workItems;
                
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
               // NSLog(@"=======%@",str1);
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03  Paramters:Str FinishCallbackBlock:^(NSString *result)
                {
                // 执行post请求完成后的逻辑
                    if (result.length<=0)
                    {
                        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                        [aler show];
                    }
                    else
                    {

                //创建解析器
                   [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, arr_shequfuwu.count))]];
                    NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                   // NSLog(@"第二次:sssssssssss %@", str_jiemi);
                    SBJsonParser *parser=[[SBJsonParser alloc]init];
                    NSError *error=nil;
                    NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                    NSString *daima=[rootDic objectForKey:@"ecode"];
                    int intString = [daima intValue];
                    if (intString==1000)
                    {
                        arr_info_shequfuwu=[rootDic objectForKey:@"wufu_info"];
                        _fakeData = [NSMutableArray array];
                        _fakeData=arr_info_shequfuwu;
                        [tableview_shangjia headerEndRefreshing];
                        [tableview_shangjia reloadData];
                                         
                    }
                    if (intString==4000)
                    {
                        [self showWithCustomView:@"服务器内部错误"];
                    }
                    }
                }];

            }
            if ([arr_shequfuwu count]>=6)
            {
                
                fuwu *customer =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr_shequfuwu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr_shequfuwu objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[arr_shequfuwu objectAtIndex:4];
                workItem5.id =e;
                WorkItem *workItem6 =[[WorkItem alloc]init];
                NSString *f=[arr_shequfuwu objectAtIndex:5];
                workItem6.id =f;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5,workItem6, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 5))]];
                //NSLog(@"参数:%@",str1);
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03 Paramters:Str FinishCallbackBlock:^(NSString *result)
                 {
                     // 执行post请求完成后的逻辑
                    //创建解析器
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                   // NSLog(@"第二次:sssssssssss %@", str_jiemi);
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSString *daima=[rootDic objectForKey:@"ecode"];
                     int intString = [daima intValue];
                     if (intString==1000)
                     {
                         arr_info_shequfuwu=[rootDic objectForKey:@"wufu_info"];
                         _fakeData = [NSMutableArray array];
                         _fakeData=arr_info_shequfuwu;
                         [tableview_shangjia headerEndRefreshing];
                         [tableview_shangjia reloadData];
                         
                         
                     }
                     if (intString==4000)
                     {
                         [self showWithCustomView:@"服务器内部错误"];
                     }
                     }
                     
                 }];
 
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
- (void)addData
{
    
    @try
    {
 
        if([CheckNetwork isExistenceNetwork]==1)
        {
            // 增加5条假数据
            if ([arr_shequfuwu count]==0)
            {
                [self.view endEditing:YES];
                __block FuWwYingYongViewController *bSelf=self;
                [UIView animateWithDuration:0.25 animations:^{
                    bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                }];
                
                [tableview_shangjia footerEndRefreshing];
                [self showWithCustomView:@"没有更多数据了哦，亲"];
            }
            if ([arr_shequfuwu count]==1)
            {
                fuwu_str =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                
               NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1, nil];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 1))]];
                fuwu_str.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fuwu_str childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
               // NSLog(@"加载更多转换后的json串 %@", str1);
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     // 执行post请求完成后的逻辑
                     //   NSLog(@"第二次:sssssssssss %@", result);
                     //创建解析器
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [tableview_shangjia footerEndRefreshing];
                         [tableview_shangjia reloadData];

                     }
                 }];
                
            }
            
            if ([arr_shequfuwu count]==2)
            {
                fuwu_str =[[fuwu alloc]init];

                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                
               NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 2))]];
                fuwu_str.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fuwu_str childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSLog(@"加载更多转换后的json串 %@", str1);
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     // 执行post请求完成后的逻辑
                     //  NSLog(@"第二次:sssssssssss %@", result);
                     //创建解析器
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [tableview_shangjia footerEndRefreshing];
                         [tableview_shangjia reloadData];

                     }
                 }];
                
            }
            
            if ([arr_shequfuwu count]==3)
            {
                fuwu_str =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr_shequfuwu objectAtIndex:2];
                workItem3.id =c;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3, nil];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 3))]];
                fuwu_str.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fuwu_str childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     // 执行post请求完成后的逻辑
                     //  NSLog(@"第二次:sssssssssss %@", result);
                     //创建解析器
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                     }
                 }];
                
            }
            
            if ([arr_shequfuwu count]==4)
            {
                fuwu_str =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr_shequfuwu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr_shequfuwu objectAtIndex:3];
                workItem4.id =d;
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4, nil];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 4))]];
                fuwu_str.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fuwu_str childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     // 执行post请求完成后的逻辑
                     // NSLog(@"第二次:sssssssssss %@", result);
                     //创建解析器
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [tableview_shangjia footerEndRefreshing];
                         [tableview_shangjia reloadData];

                     }
                 }];
                
            }
            
            if ([arr_shequfuwu count]==5)
            {
                fuwu_str =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr_shequfuwu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr_shequfuwu objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[arr_shequfuwu objectAtIndex:4];
                workItem5.id =e;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 5))]];
                fuwu_str.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fuwu_str childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     // 执行post请求完成后的逻辑
                     // NSLog(@"第二次:sssssssssss %@", result);
                     //创建解析器
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [tableview_shangjia footerEndRefreshing];
                         [tableview_shangjia reloadData];

                     }
                 }];
                
            }
            if ([arr_shequfuwu count]>5)
            {
                fuwu_str =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr_shequfuwu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr_shequfuwu objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[arr_shequfuwu objectAtIndex:4];
                workItem5.id =e;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 5))]];
                fuwu_str.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fuwu_str childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     // 执行post请求完成后的逻辑
                    //  NSLog(@"第二次:sssssssssss %@", result);
                     //创建解析器
                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                     [tableview_shangjia footerEndRefreshing];
                     [tableview_shangjia reloadData];

                 }];
                
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
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * currLocation = [locations lastObject];
    
    jingdu= [NSString stringWithFormat:@"%3.5f",currLocation.coordinate.latitude];
    weidu= [NSString stringWithFormat:@"%3.5f",currLocation.coordinate.longitude];
    [locationManager stopUpdatingLocation];
   // NSLog(@"location ok  %@  %@",jingdu,weidu);
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
    
    NSLog(@"error: %@",error);
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    @try
    {

    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0 green:245/255.0 blue:245/255.0  alpha:1];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];
 
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 35)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.text=SheQuFuWu_Title;
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 35, 35)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1000.0f;
        [self.locationManager startUpdatingLocation];
        
        label_fanwei=[[UILabel alloc]initWithFrame:CGRectMake(10, 65, 140, 30)];
        label_fanwei.text=@"范围筛选";
        label_fanwei.font=[UIFont systemFontOfSize:14];
        label_fanwei.backgroundColor=[UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:label_fanwei];
        fanwei=@"0";
        arr_fanwei=[[NSMutableArray alloc]initWithObjects:@"全市(默认)",@"500米",@"1000米",@"2000米",@"5000米", nil];
        tableview_fanwei=[[UITableView alloc]initWithFrame:CGRectMake(30, 110, 260, 200)];
        tableview_fanwei.dataSource=self;
        tableview_fanwei.delegate=self;
        btn_fanwei=[[UIButton alloc]initWithFrame:CGRectMake(120, 70, 20, 20)];
        [btn_fanwei setImage:[UIImage imageNamed:@"triange0705.png"] forState:UIControlStateNormal];
        [btn_fanwei addTarget:self action:@selector(fanweisaixuan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_fanwei];
        
//        label_fenlei=[[UILabel alloc]initWithFrame:CGRectMake(110, 65, 100, 30)];
//        label_fenlei.text=@"内容分类";
//        label_fenlei.font=[UIFont systemFontOfSize:14];
//        label_fenlei.backgroundColor=[UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
//        [self.view addSubview:label_fenlei];
//        arr_fenlei=[[NSMutableArray alloc]initWithObjects:@"所有分类(默认)",@"上门维修",@"预订服务",@"家政服务",@"社区医疗",@"社区服务",@"酒店预订",@"快餐外卖", nil];
//        neirong=@"0";
//        tableview_fenlei=[[UITableView alloc]initWithFrame:CGRectMake(30, 110, 260, 320)];
//        tableview_fenlei.dataSource=self;
//        tableview_fenlei.delegate=self;
//        btn_fenlei=[[UIButton alloc]initWithFrame:CGRectMake(185, 70, 20, 20)];
//        [btn_fenlei setImage:[UIImage imageNamed:@"triange0705.png"] forState:UIControlStateNormal];
//        [btn_fenlei addTarget:self action:@selector(neirongfenlei) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn_fenlei];
        
        label_paixu=[[UILabel alloc]initWithFrame:CGRectMake(170, 65, 140, 30)];
        label_paixu.text=@"排序规则";
        label_paixu.font=[UIFont systemFontOfSize:14];
        label_paixu.backgroundColor=[UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
        [self.view addSubview:label_paixu];
        paixu=@"3";
        arr_paixu=[[NSMutableArray alloc]initWithObjects:@"距离(默认)",@"好评",@"优惠", nil];
        tableview_paixu=[[UITableView alloc]initWithFrame:CGRectMake(30, 210, 260, 120)];
        tableview_paixu.dataSource=self;
        tableview_paixu.delegate=self;
        btn_paixu=[[UIButton alloc]initWithFrame:CGRectMake(290, 70, 20, 20)];
        [btn_paixu setImage:[UIImage imageNamed:@"triange0705.png"] forState:UIControlStateNormal];
        [btn_paixu addTarget:self action:@selector(paixuguize) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_paixu];
        tableview_shangjia=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, Width, Hidth-100)];
        tableview_shangjia.delegate=self;
        tableview_shangjia.dataSource=self;
        [self.view addSubview:tableview_shangjia];
        [tableview_shangjia addHeaderWithTarget:self action:@selector(dataInit)];
        [tableview_shangjia addFooterWithTarget:self action:@selector(addData)];
        [tableview_shangjia headerBeginRefreshing];



    _fakeData = [NSMutableArray array];
        
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
-(void)fanweisaixuan
{
    [self.view addSubview:tableview_fanwei];
}
-(void)paixuguize
{
    [self.view addSubview:tableview_paixu];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }
    else
    {
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([tableView isEqual:tableview_fanwei])
    {
        cell.textLabel.text=arr_fanwei[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];
        cell.imageView.highlightedImage=[UIImage imageNamed:@"payeco_plugin_radiobt_bg_checked.png"];
    }
    if ([tableView isEqual:tableview_paixu])
    {
        cell.textLabel.text=arr_paixu[indexPath.row];
    }
    if ([tableView isEqual:tableview_shangjia])
    {
        //cell.textLabel.text=[_fakeData[indexPath.row] objectForKey:@"store_name"];
        NSString *image_url=[_fakeData[indexPath.row] objectForKey:@"image_path"];
        NSData *date=[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]];
        if (date.length>0)
        {
            UIImageView *imagea=[[UIImageView alloc]init];
            imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 1, 85,78)];
            imagea.tag = 1000;
            imagea.userInteractionEnabled=NO;
            [imagea setImageWithURL:[NSURL URLWithString:image_url]
                          placeholderImage:[UIImage imageNamed:@"xiaoqufuwu1"]
                                   options:SDWebImageRetryFailed
               usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [cell.contentView addSubview:imagea];
            
            UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(95, 0, 220, 20)];
            labela.text=[_fakeData[indexPath.row] objectForKey:@"store_name"];
            labela.font=[UIFont systemFontOfSize:14];
            labela.backgroundColor=[UIColor whiteColor];
            labela.textColor=[UIColor blackColor];
            [cell addSubview:labela];
            UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(95, 18, 220, 40)];
            labelb.text=[_fakeData[indexPath.row] objectForKey:@"describtion"];
            labelb.backgroundColor=[UIColor whiteColor];
            labelb.numberOfLines=0;
            labelb.font=[UIFont systemFontOfSize:12];
            labelb.textColor=[UIColor grayColor];
            [cell addSubview:labelb];
            UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 58, 95, 20)];
            labelc.text=[_fakeData[indexPath.row] objectForKey:@"phone"];
            labelc.backgroundColor=[UIColor whiteColor];
            labelc.font=[UIFont systemFontOfSize:12];
            labelc.textColor=[UIColor grayColor];
            [cell addSubview:labelc];
            UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(95, 58, 125, 20)];
            labeld.text=[_fakeData[indexPath.row] objectForKey:@"store_master_name"];
            labeld.backgroundColor=[UIColor whiteColor];
            labeld.font=[UIFont systemFontOfSize:12];
            labeld.textColor=[UIColor grayColor];
            [cell addSubview:labeld];

        }
        if (date.length==0)
        {
            UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 20)];
            labela.text=[_fakeData[indexPath.row] objectForKey:@"store_name"];
            labela.font=[UIFont systemFontOfSize:14];
            labela.backgroundColor=[UIColor whiteColor];
            labela.textColor=[UIColor blackColor];
            [cell addSubview:labela];
            UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(5, 18, 310, 40)];
            labelb.text=[_fakeData[indexPath.row] objectForKey:@"describtion"];
            labelb.backgroundColor=[UIColor whiteColor];
            labelb.numberOfLines=0;
            labelb.font=[UIFont systemFontOfSize:12];
            labelb.textColor=[UIColor grayColor];
            [cell addSubview:labelb];
            UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 58, 95, 20)];
            labelc.text=[_fakeData[indexPath.row] objectForKey:@"phone"];
            labelc.backgroundColor=[UIColor whiteColor];
            labelc.font=[UIFont systemFontOfSize:12];
            labelc.textColor=[UIColor grayColor];
            [cell addSubview:labelc];
            UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(5, 58, 215, 20)];
            labeld.text=[_fakeData[indexPath.row] objectForKey:@"store_master_name"];
            labeld.backgroundColor=[UIColor whiteColor];
            labeld.font=[UIFont systemFontOfSize:12];
            labeld.textColor=[UIColor grayColor];
            [cell addSubview:labeld];

        }
        
    }
        
    return cell;
        
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tableview_fanwei])
    {
        return arr_fanwei.count;
    }
       else if ([tableView isEqual:tableview_paixu])
    {
        return arr_paixu.count;
    }
    else
    {
        return _fakeData.count;
    }
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
    
    if ([tableView isEqual:tableview_fanwei]||[tableView isEqual:tableview_fenlei]||[tableView isEqual:tableview_paixu])
    {
    if ([tableView isEqual:tableview_fanwei])
    {
        if (indexPath.row==0)
        {
            fanwei=@"0";
        }
        else if (indexPath.row==1)
        {
            fanwei=@"500";
        }
        else if (indexPath.row==2)
        {
            fanwei=@"1000";
        }
        else if(indexPath.row==3)
        {
            fanwei=@"2000";
        }
        else
        {
            fanwei=@"5000";
        }
        [tableview_fanwei removeFromSuperview];
        label_fanwei.text=arr_fanwei[indexPath.row];
    }
    if ([tableView isEqual:tableview_paixu])
    {
        if (indexPath.row==0)
        {
            paixu=@"3";
        }
        else if (indexPath.row==1)
        {
            paixu=@"1";
        }
        else
        {
            paixu=@"2";
        }
        [tableview_paixu removeFromSuperview];
        label_paixu.text=arr_paixu[indexPath.row];
    }
        [arr_shequfuwu removeAllObjects];
        [_fakeData removeAllObjects];
        zhujianliebiao *customer =[[zhujianliebiao alloc]init];
        customer.city_id =@"101";
        customer.servicetype_id=Type;
        customer.distance_scope=fanwei;
        customer.sort_id =paixu;
        customer.latitude=weidu;
        customer.longitude=jingdu;
        NSString *str112 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 5))]];
        
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str112];
        NSString *str2=@"para=";
        NSString *Str11;
        Str11=[str2 stringByAppendingString:str_jiami];
        
        [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_08 Paramters:Str11 FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            //  NSLog(@"第一次: %@", result);//result就是NSString类型的返回值
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
            NSArray *shuzu=[[NSArray alloc]init];
            shuzu=[rootDic objectForKey:@"id_list"];
            int i;
            for (i=0; i<[shuzu count]; i++)
            {
                NSDictionary *dic=[[NSDictionary alloc]init];
                dic=[shuzu objectAtIndex:i];
                NSString *stringInt =[dic objectForKey:@"id"];
                [arr_shequfuwu addObject:stringInt];
            }
            
            NSLog(@"第一次: arrrrrr=%@", arr_shequfuwu);
            if ([arr_shequfuwu count]==0)
            {
                
                [self.view endEditing:YES];
                __block FuWwYingYongViewController *bSelf=self;
                [UIView animateWithDuration:0.25 animations:^{
                    bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                }];
                
                
                [self showWithCustomView:@"服务器中暂未储存此类数据哦，亲"];
            }

            if (arr_shequfuwu.count==1)
            {
                fuwu *customer =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 1))]];

                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                    SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     
                     // 2.初始化假数据
                     _fakeData = [NSMutableArray array];
                     _fakeData=info;
                     [tableview_shangjia reloadData];
                     }
                }];
            }

            if (arr_shequfuwu.count==2)
            {
                fuwu *customer =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 2))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                    SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     
                     // 2.初始化假数据
                     _fakeData = [NSMutableArray array];
                     _fakeData=info;
                     [tableview_shangjia reloadData];
                     }
                }];
            }

            if (arr_shequfuwu.count==3)
            {
                fuwu *customer =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr_shequfuwu objectAtIndex:2];
                workItem3.id =c;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 3))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                    SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     
                     // 2.初始化假数据
                     _fakeData = [NSMutableArray array];
                     _fakeData=info;
                     [tableview_shangjia reloadData];
                     }
                }];
            }

            if (arr_shequfuwu.count==4)
            {
                fuwu *customer =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr_shequfuwu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr_shequfuwu objectAtIndex:3];
                workItem4.id =d;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 4))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                    SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     
                     // 2.初始化假数据
                     _fakeData = [NSMutableArray array];
                     _fakeData=info;
                     [tableview_shangjia reloadData];
                     }
                 }];
            }

            if (arr_shequfuwu.count>=5)
            {
                fuwu *customer =[[fuwu alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr_shequfuwu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr_shequfuwu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr_shequfuwu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr_shequfuwu objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[arr_shequfuwu objectAtIndex:4];
                workItem5.id =e;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr_shequfuwu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr_shequfuwu.count, 5))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03                                              Paramters:Str
                                    FinishCallbackBlock:^(NSString *result)
                 {
                     if (result.length<=0)
                     {
                         UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                         [aler show];
                     }
                     else
                     {

                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                    SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"wufu_info"];
                     
                     
                     // 2.初始化假数据
                     _fakeData = [NSMutableArray array];
                     _fakeData=info;
                     [tableview_shangjia reloadData];
                     }

                 }];
            }
            }
        }];

    }
    else
    {
    if ([tableView isEqual:tableview_shangjia])
    {
        FUWUdtDictionary=_fakeData[indexPath.row];
        NSLog(@">>>>>>>>>       %@",FUWUdtDictionary);
        ShangJiaXinXiViewController *fuwu=[[ShangJiaXinXiViewController alloc]init];
        /*
         [self presentViewController:fuwu animated:NO completion:nil];
         */
        /*
         修改人 赵忠良
         修改日期 15.3.11
         修改原因 解决返回页面重复及返回错误的bug
         */
        
        [self.navigationController pushViewController:fuwu animated:YES];

//        ShopsDetailsViewController *fuwu=[[ShopsDetailsViewController alloc]init];
//        [self presentViewController:fuwu animated:NO completion:nil];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tableview_fanwei]||[tableView isEqual:tableview_fenlei]||[tableView isEqual:tableview_paixu])
    {
        return 40;
    }
   else
   {
        return 80;
   }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fanhui
{
    /* 原代码
     DengLuHouZhuYeViewController *zhuye=[[DengLuHouZhuYeViewController alloc]init];
     [self presentViewController:zhuye animated:NO completion:nil];
     */
    
    /*
     修改人 赵中良
     修改时间 15.3.11
     修改原因：解决返回界面不是上一级，而是主页面的bug
     */
    [self dismissViewControllerAnimated:YES completion:nil];
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
