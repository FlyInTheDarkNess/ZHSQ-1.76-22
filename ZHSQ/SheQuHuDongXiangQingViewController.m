//
//  SheQuHuDongXiangQingViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-7-29.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "SheQuHuDongXiangQingViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "CheckNetwork.h"
#import "UIImageView+WebCache.h"
#import "FaTieZiViewController.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"

NSString *const SheQuHuDongXiangQingMJTableViewCellIdentifier = @"Cell";
extern NSDictionary *SheQuHuDongXiangQingDictionary;
@interface SheQuHuDongXiangQingViewController ()
{
    NSMutableArray *_fakeData;
    NSMutableArray *shijian;
    int k;
}

@end

@implementation SheQuHuDongXiangQingViewController

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
        
        arr=[[NSMutableArray alloc]init];
        SheQuHuDong_pinglunID *customer =[[SheQuHuDong_pinglunID alloc]init];
        customer.forum_id=[SheQuHuDongXiangQingDictionary objectForKey:@"id"];
        NSString *str11 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 1))]];
        
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str11];
        NSString *str2=@"para=";
        NSString *Str12;
        Str12=[str2 stringByAppendingString:str_jiami];
        [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_04 Paramters:Str12 FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
          //  NSLog(@"第一次: 解析%@", rootDic);
            
            NSArray *shuzu=[[NSArray alloc]init];
            shuzu=[rootDic objectForKey:@"id_list"];
            int i;
            for (i=0; i<[shuzu count]; i++)
            {
                NSDictionary *dic=[[NSDictionary alloc]init];
                dic=[shuzu objectAtIndex:i];
                NSString *stringInt =[dic objectForKey:@"id"];
                [arr addObject:stringInt];
            }
          
            if ([arr count]==0)
            {
                
                [self.view endEditing:YES];
                __block SheQuHuDongXiangQingViewController *bSelf=self;
                [UIView animateWithDuration:0.25 animations:^{
                    bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                }];
                
                [DataTable headerEndRefreshing];
                [self showWithCustomView:@"服务器中暂未储存数据了哦，亲"];
            }
            
            if ([arr count]==1)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id=a;
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 1))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     
                    _fakeData=info;
                    }
                     [DataTable headerEndRefreshing];
                     [DataTable reloadData];
                 }];
                
                
                
            }
            if ([arr count]==2)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id=a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id=b;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 2))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     
                        _fakeData=info;
                    }
                     [DataTable headerEndRefreshing];
                     [DataTable reloadData];

                 }];
                
                
            }
            if ([arr count]==3)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id=a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id=b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr objectAtIndex:2];
                workItem3.id =c;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 3))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                         
                         _fakeData=info;
                     }
                     [DataTable headerEndRefreshing];
                     [DataTable reloadData];
                 }];
                
                
            }
            if ([arr count]==4)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id=a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id=b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr objectAtIndex:3];
                workItem4.id =d;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 4))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     
                         
                         _fakeData=info;
                     }
                     [DataTable headerEndRefreshing];
                     [DataTable reloadData];
                 }];
                
            }
            if ([arr count]>=5)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id=a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id=b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[arr objectAtIndex:4];
                workItem5.id =e;
                
                NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                customer.id_list = workItems;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 5))]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     
                         
                         _fakeData=info;
                     }
                     [DataTable headerEndRefreshing];
                     [DataTable reloadData];
                     
                }];
                
                
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
            if ([arr count]==0)
            {
                [self.view endEditing:YES];
                __block SheQuHuDongXiangQingViewController *bSelf=self;
                [UIView animateWithDuration:0.25 animations:^{
                    bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                }];
                
                [DataTable footerEndRefreshing];

                [self showWithCustomView:@"没有更多数据了哦，亲"];
            }
            if ([arr count]==1)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                
                NSArray *workItemss= [[NSArray alloc] initWithObjects:workItem1, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 1))]];
                customer.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05                                              Paramters:Str
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
                    // NSLog(@"%@+++++++++",str_jiemi);
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     
                     NSMutableArray *info=[[NSMutableArray array]init];
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [DataTable footerEndRefreshing];
                         [DataTable reloadData];
                     }
                     
                 }];
                
            }
            
            if ([arr count]==2)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id =b;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 2))]];
                customer.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
               // NSLog(@"加载更多转换后的json串 %@", str1);
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05 Paramters:Str
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [DataTable footerEndRefreshing];
                         [DataTable reloadData];

                     }
                 }];
                
            }
            
            if ([arr count]==3)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr objectAtIndex:2];
                workItem3.id =c;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 3))]];
                customer.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05                                              Paramters:Str
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [DataTable footerEndRefreshing];
                         [DataTable reloadData];

                     }
                 }];
                
            }
            
            if ([arr count]==4)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr objectAtIndex:3];
                workItem4.id =d;
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 4))]];
                customer.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05                                              Paramters:Str
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [DataTable footerEndRefreshing];
                         [DataTable reloadData];

                     }
                 }];
                
            }
            
            if ([arr count]==5)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[arr objectAtIndex:4];
                workItem5.id =e;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 5))]];
                customer.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05                                              Paramters:Str
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [DataTable footerEndRefreshing];
                         [DataTable reloadData];

                     }
                 }];
                
            }
            if ([arr count]>5)
            {
                SheQuHuDong_pinglunxinxi *customer =[[SheQuHuDong_pinglunxinxi alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[arr objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[arr objectAtIndex:4];
                workItem5.id =e;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 5))]];
                customer.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_05                                              Paramters:Str
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
                     info=[rootDic objectForKey:@"feedback_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                         [DataTable footerEndRefreshing];
                         [DataTable reloadData];

                     }
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

- (void)showWithCustomView:(NSString*)aString {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    self.view.backgroundColor=[UIColor whiteColor];

    
    NSArray *wk_paceImageNumArray = [[NSArray alloc]initWithObjects:@"emoji_1.png",@"emoji_2.png",@"emoji_3.png",@"emoji_4.png",@"emoji_5.png",@"emoji_6.png",@"emoji_7.png",@"emoji_8.png",@"emoji_9.png",@"emoji_10.png",@"emoji_11.png",@"emoji_12.png",@"emoji_13.png",@"emoji_14.png",@"emoji_15.png",@"emoji_16.png",@"emoji_17.png",@"emoji_18.png",@"emoji_19.png",@"emoji_20.png",@"emoji_21.png",@"emoji_22.png",@"emoji_23.png",@"emoji_24.png",@"emoji_25.png",@"emoji_26.png",@"emoji_27.png",@"emoji_28.png",@"emoji_29.png",@"emoji_30.png",@"emoji_31.png",@"emoji_32.png",@"emoji_33.png",@"emoji_34.png",@"emoji_35.png",@"emoji_36.png",@"emoji_37.png",@"emoji_38.png",@"emoji_39.png",@"emoji_40.png",@"emoji_41.png",@"emoji_42.png",@"emoji_43.png",@"emoji_44.png",@"emoji_45.png",@"emoji_45.png",@"emoji_47.png",@"emoji_48.png",@"emoji_49.png",@"emoji_50.png",@"emoji_51.png",@"emoji_52.png",@"emoji_53.png",@"emoji_54.png",@"emoji_55.png",@"emoji_56.png",@"emoji_57.png",@"emoji_58.png",@"emoji_59.png",@"emoji_60.png",@"emoji_16.png",@"emoji_62.png",@"emoji_63.png",@"emoji_64.png",@"emoji_65.png",@"emoji_66.png",@"emoji_67.png",@"emoji_68.png",@"emoji_69.png",@"emoji_70.png",@"emoji_71.png",@"emoji_179.png",@"emoji_180.png",@"emoji_181.png",@"emoji_182.png",@"emoji_183.png",@"emoji_184.png",@"emoji_185.png",@"emoji_186.png",@"emoji_187.png",@"emoji_188.png",@"emoji_189.png",@"emoji_190.png",@"emoji_191.png",@"emoji_192.png",@"emoji_193.png",@"emoji_194.png",@"emoji_195.png",@"emoji_196.png",@"emoji_197.png",@"emoji_198.png",@"emoji_199.png",@"emoji_200.png",@"emoji_201.png",@"emoji_202.png",@"emoji_203.png",@"emoji_204.png",@"emoji_205.png",@"emoji_206.png",@"emoji_207.png",@"emoji_208.png",@"emoji_209.png",@"emoji_210.png",@"emoji_211.png",@"emoji_212.png",@"emoji_213.png",@"emoji_214.png",@"emoji_215.png",@"emoji_216.png",@"emoji_217.png",@"emoji_218.png",@"emoji_219.png",@"emoji_220.png",@"emoji_221.png",@"emoji_222.png",@"emoji_223.png",@"emoji_224.png", nil];
    NSArray *wk_paceImageNameArray = [[NSArray alloc]initWithObjects:@"[可爱]",@"[笑脸]",@"[囧]",@"[生气]",@"[鬼脸]",@"[花心]",@"[害怕]",@"[我汗]",@"[尴尬]",@"[哼哼]",@"[忧郁]",@"[呲牙]",@"[媚眼]",@"[累]",@"[苦逼]",@"[瞌睡]",@"[哎呀]",@"[刺瞎]",@"[哭]",@"[激动]",@"[难过]",@"[害羞]",@"[高兴]",@"[愤怒]",@"[亲]",@"[飞吻]",@"[得意]",@"[惊恐]",@"[口罩]",@"[惊讶]",@"[委屈]",@"[生病]",@"[红心]",@"[心碎]",@"[玫瑰]",@"[花]",@"[外星人]",@"[金牛座]",@"[双子座]",@"[巨蟹座]",@"[狮子座]",@"[处女座]",@"[天平座]",@"[天蝎座]",@"[射手座]",@"[摩羯座]",@"[水瓶座]",@"[白羊座]",@"[双鱼座]",@"[星座]",@"[男孩]",@"[女孩]",@"[嘴唇]",@"[爸爸]",@"[妈妈]",@"[衣服]",@"[皮鞋]",@"[照相]",@"[电话]",@"[石头]",@"[胜利]",@"[禁止]",@"[滑雪]",@"[高尔夫]",@"[网球]",@"[棒球]",@"[冲浪]",@"[足球]",@"[小鱼]",@"[问号]",@"[叹号]",@"[顶]",@"[写字]",@"[衬衫]",@"[小花]",@"[郁金香]",@"[向日葵]",@"[鲜花]",@"[椰树]",@"[仙人掌]",@"[气球]",@"[炸弹]",@"[喝彩]",@"[剪子]",@"[蝴蝶结]",@"[机密]",@"[铃声]",@"[女帽]",@"[裙子]",@"[理发店]",@"[和服]",@"[比基尼]",@"[拎包]",@"[拍摄]",@"[铃铛]",@"[音乐]",@"[心星]",@"[粉心]",@"[丘比特]",@"[吹气]",@"[口水]",@"[对]",@"[错]",@"[绿茶]",@"[面包]",@"[面条]",@"[咖喱饭]",@"[饭团]",@"[麻辣烫]",@"[寿司]",@"[苹果]",@"[橙子]",@"[草莓]",@"[西瓜]",@"[柿子]",@"[眼睛]",@"[好的]", nil];
    m_emojiDic = [[NSDictionary alloc] initWithObjects:wk_paceImageNumArray forKeys:wk_paceImageNameArray];
    

    
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    NSString *text = [CustomMethod escapedString:[SheQuHuDongXiangQingDictionary objectForKey:@"title"]];
    [self creatAttributedLabel:text Label:label];
    [CustomMethod drawImage:label];
    OHAttributedLabel *label2 = label;

    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(160-label2.frame.size.width/2, 30,2*(160-label2.frame.size.width/2), 40);
    [view addSubview:label2];
    [self.view addSubview:view];

    
    fanhui_btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui_btn setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui_btn addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui_btn];
    
    label_beijing=[[UILabel alloc]initWithFrame:CGRectMake(0, Hidth-36, Width, 36)];
    label_beijing.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijing];
    fatie=[[UIButton alloc]initWithFrame:CGRectMake(5, Hidth-33, 310, 30)];
    fatie.backgroundColor=[UIColor whiteColor];
    [fatie setTitle:@"我也说一句..." forState:UIControlStateNormal];
    [fatie setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fatie.layer.masksToBounds = YES;
    fatie.layer.cornerRadius = 5;
    [fatie addTarget:self action:@selector(fabiaoshuoshuo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fatie];

    
    DataTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, Width, Hidth-95)];
    DataTable.delegate=self;
    DataTable.dataSource=self;
    [self.view addSubview:DataTable];
    [DataTable addHeaderWithTarget:self action:@selector(dataInit)];
    [DataTable addFooterWithTarget:self action:@selector(addData)];
    [DataTable headerBeginRefreshing];

      // 2.初始化数据
    _fakeData = [NSMutableArray array];
}

- (void)creatAttributedLabel:(NSString *)o_text Label:(OHAttributedLabel *)label
{
    //3
    [label setNeedsDisplay];
    NSMutableArray *httpArr = [CustomMethod addHttpArr:o_text];
    NSMutableArray *phoneNumArr = [CustomMethod addPhoneNumArr:o_text];
    NSMutableArray *emailArr = [CustomMethod addEmailArr:o_text];
    
    NSString *text = [CustomMethod transformString:o_text emojiDic:m_emojiDic];
    text = [NSString stringWithFormat:@"<font color='black' strokeColor='gray' face='Palatino-Roman'>%@",text];
    
    MarkupParser *wk_markupParser = [[MarkupParser alloc] init];
    NSMutableAttributedString* attString = [wk_markupParser attrStringFromMarkup: text];
    [attString setFont:[UIFont systemFontOfSize:18]];//控制显示字体的大小
    [label setBackgroundColor:[UIColor clearColor]];
    [label setAttString:attString withImages:wk_markupParser.images];
    
    NSString *string = attString.string;
    
    if ([emailArr count]) {
        for (NSString *emailStr in emailArr) {
            [label addCustomLink:[NSURL URLWithString:emailStr] inRange:[string rangeOfString:emailStr]];
        }
    }
    
    if ([phoneNumArr count]) {
        for (NSString *phoneNum in phoneNumArr) {
            [label addCustomLink:[NSURL URLWithString:phoneNum] inRange:[string rangeOfString:phoneNum]];
        }
    }
    
    if ([httpArr count]) {
        for (NSString *httpStr in httpArr) {
            [label addCustomLink:[NSURL URLWithString:httpStr] inRange:[string rangeOfString:httpStr]];
        }
    }
    
    label.delegate = self;
    CGRect labelRect = label.frame;
    labelRect.size.width = [label sizeThatFits:CGSizeMake(300, CGFLOAT_MAX)].width;
    labelRect.size.height = [label sizeThatFits:CGSizeMake(300, CGFLOAT_MAX)].height;
    label.frame = labelRect;
    label.underlineLinks = YES;//链接是否带下划线
    [label.layer display];
}

- (BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    //4
    NSString *requestString = [linkInfo.URL absoluteString];
    NSLog(@"%@",requestString);
    if ([[UIApplication sharedApplication]canOpenURL:linkInfo.URL]) {
        [[UIApplication sharedApplication]openURL:linkInfo.URL];
    }
    
    return NO;
}


-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)fabiaoshuoshuo
{
    FaTieZiViewController *fatiezi=[[FaTieZiViewController alloc]init];
    [self presentViewController:fatiezi animated:NO completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
//指定有多少个分区(Section)，默认为1

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;//返回标题数组中元素的个数来确定分区的个数
    
}
//指定每个分区中有多少行，默认为1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  1;
            break;
            
        case 1:

            return  [_fakeData count];
            
            break;
            
        default:
            
            return 0;
            
            break;
            
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height+44;
    }
    else if (indexPath.section==1)
    {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }
    else
    {
        
        return 0;
    }
}

//绘制Cell

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    [DataTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section==0) {
        
        
        
        OHAttributedLabel *labelll = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
        NSString *texttt = [CustomMethod escapedString:[SheQuHuDongXiangQingDictionary objectForKey:@"content"]];
        [self creatAttributedLabel:texttt Label:labelll];
        [CustomMethod drawImage:labelll];
        
        UIView *viewww = [[UIView alloc] init];
        OHAttributedLabel *label2ll = labelll;
        viewww.frame = CGRectMake(10, 0, 310, label2ll.frame.size.height);
        NSLog(@">>>>>>>>>>  %f",label2ll.frame.size.height);
        [viewww addSubview:label2ll];
        [cell addSubview:viewww];

        
        if (![[[[SheQuHuDongXiangQingDictionary objectForKey:@"images"] objectAtIndex:0] objectForKey:@"pic_url"] isEqualToString:@""])
        {
            
        
        for (int i=0; i<[[SheQuHuDongXiangQingDictionary objectForKey:@"images"] count]; i++)
        {
            NSArray *arrr=[SheQuHuDongXiangQingDictionary objectForKey:@"images"];
            NSDictionary *dica=[[NSDictionary alloc]init];
            dica=[arrr objectAtIndex:i];
            UIImageView *imagea=[[UIImageView alloc]init];
            imagea= [[UIImageView alloc]initWithFrame:CGRectMake(0, label2ll.frame.size.height+10+210*i, 320, 200)];
            imagea.contentMode=UIViewContentModeScaleAspectFit;
            imagea.tag = 1000;
            imagea.userInteractionEnabled=NO;
            NSString *str=[dica objectForKey:@"pic_url"];
            [imagea setImageWithURL:[NSURL URLWithString:str]
                      placeholderImage:[UIImage imageNamed:@"shequhudong3"]
                               options:SDWebImageRetryFailed
           usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

            [cell.contentView addSubview:imagea];
        }
            gaodu=[[SheQuHuDongXiangQingDictionary objectForKey:@"images"] count]*210;
        }
        else
        {
            gaodu=0;
        }
        UILabel *pinglun=[[UILabel alloc]initWithFrame:CGRectMake(5, label2ll.frame.size.height+gaodu+20, 310, 20)];
        pinglun.text=[NSString stringWithFormat:@" 反馈评论: %@",[SheQuHuDongXiangQingDictionary objectForKey:@"feedback_num"]];
        pinglun.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:pinglun];

        
        CGRect cellFrame = [cell frame];
        cellFrame.size.height =label2ll.frame.size.height+gaodu+20 ;
        [cell setFrame:cellFrame];
    }
    if (indexPath.section==1)
    {
        UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
        line.backgroundColor=[UIColor grayColor];
        [cell addSubview:line];
        NSString *creator_url=[_fakeData[indexPath.row] objectForKey:@"creator_icon"];
        if (creator_url.length>0)
        {
            UIImageView *imageb=[[UIImageView alloc]init];
            //圆角设置
            imageb.layer.cornerRadius= 12;//(值越大，角就越圆)
            imageb.layer.masksToBounds= YES;//边框宽度及颜色设置
            [imageb.layer setBorderWidth:2];
            [imageb.layer setBorderColor:(__bridge CGColorRef)([UIColor redColor])];  //设置边框为蓝色
            //自动适应,保持图片宽高比
            imageb.contentMode= UIViewContentModeScaleAspectFit;
            imageb= [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 30,30)];
            imageb.tag = 1000;
            imageb.userInteractionEnabled=NO;
           // [imageb setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",creator_url]] placeholderImage:[UIImage imageNamed:@"tx10"] options:SDWebImageProgressiveDownload];
            [imageb setImageWithURL:[NSURL URLWithString:creator_url]
                   placeholderImage:[UIImage imageNamed:@"shequhudong4"]
                            options:SDWebImageRetryFailed
        usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

            
            [cell.contentView addSubview:imageb];
        }
        else
        {
            UIImageView *imagec=[[UIImageView alloc]init];
            imagec.image=[UIImage imageNamed:@"m_personcenter.png"];
            //圆角设置
            imagec.frame=CGRectMake(5, 0, 30,30);
            [cell.contentView addSubview:imagec];
            
        }

        UILabel *biaoti=[[UILabel alloc]initWithFrame:CGRectMake(50, 1, 100, 20)];
        biaoti.text=[_fakeData[indexPath.row] objectForKey:@"nickname"];
        biaoti.textColor=[UIColor blueColor];
        biaoti.font=[UIFont systemFontOfSize:14];
        [cell addSubview:biaoti];
        UILabel *shijiana=[[UILabel alloc]initWithFrame:CGRectMake(160, 1, 150, 20)];
        shijiana.text=[_fakeData[indexPath.row] objectForKey:@"createtime"];
        shijiana.textAlignment=NSTextAlignmentRight;
        shijiana.font=[UIFont systemFontOfSize:14];
        [cell addSubview:shijiana];
        
        
        OHAttributedLabel *labelll = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
        NSString *texttt = [CustomMethod escapedString:[_fakeData[indexPath.row] objectForKey:@"content"]];
        [self creatAttributedLabel:texttt Label:labelll];
        [CustomMethod drawImage:labelll];
        
        UIView *viewww = [[UIView alloc] init];
        OHAttributedLabel *label2ll = labelll;
        viewww.frame = CGRectMake(5, 41, 310, label2ll.frame.size.height);
        
        [viewww addSubview:label2ll];
        [cell addSubview:viewww];


        if (![[[[_fakeData[indexPath.row] objectForKey:@"images"] objectAtIndex:0] objectForKey:@"thumbs_url"] isEqualToString:@""])
        {
            for (int j=0; j<[[_fakeData[indexPath.row] objectForKey:@"images"] count]; j++)
            {
                
                NSArray *arrr=[_fakeData[indexPath.row] objectForKey:@"images"];
                NSDictionary *dica=[[NSDictionary alloc]init];
                dica=[arrr objectAtIndex:j];
                UIImageView *imagea=[[UIImageView alloc]init];
                imagea= [[UIImageView alloc]initWithFrame:CGRectMake(0,label2ll.frame.size.height+46+210*j, 320, 200)];
                imagea.contentMode=UIViewContentModeScaleAspectFit;
                imagea.tag = 1000;
                imagea.userInteractionEnabled=NO;
                
                [imagea setImageWithURL:[NSURL URLWithString:[dica objectForKey:@"thumbs_url"]]
                       placeholderImage:[UIImage imageNamed:@"shequhudong4"]
                                options:SDWebImageRetryFailed
            usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

                [cell.contentView addSubview:imagea];
            }
            g=210*[[_fakeData[indexPath.row] objectForKey:@"images"] count];
        }
        else
        {
           g=0;
        }
        
        CGRect cellFrame = [cell frame];
        cellFrame.size.height =label2ll.frame.size.height+48+g;
        [cell setFrame:cellFrame];
    }
    
    return cell;
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
