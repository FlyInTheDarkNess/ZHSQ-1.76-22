//
//  FuWuYingYongXiangQingViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-7-22.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "FuWuYingYongXiangQingViewController.h"
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
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"

#import "shouyeViewController.h"
#import "ShangJiaPingJiaViewController.h"
#import "ShangJiaDiTuDingWeiViewController.h"
#import "URL.h"
#import "JiaMiJieMi.h"
NSString *const FWTableViewCellIdentifier = @"Cell";
extern NSDictionary *FUWUdtDictionary;
extern NSString *UserName;
extern NSString *Session;

@interface FuWuYingYongXiangQingViewController ()
{
    NSMutableArray *_fakeData;
    NSMutableArray *shuzu;
}

@end

@implementation FuWuYingYongXiangQingViewController

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
        
        NSMutableArray *arry=[[NSMutableArray alloc]initWithArray:[FUWUdtDictionary objectForKey:@"fb_id_list"]];
        NSArray *arr=[[NSArray alloc]initWithArray:[FUWUdtDictionary objectForKey:@"fb_id_list"]];
        shuzu=[[NSMutableArray alloc]init];

        for (int i=0; i<[arry count]; i++)
        {
            NSDictionary *dic=[[NSDictionary alloc]init];
            dic=[arry objectAtIndex:i];
            NSString *stringInt =[dic objectForKey:@"id"];
            [shuzu addObject:stringInt];

        }
        NSLog(@">>>>   %d   %d",arry.count,shuzu.count);
        if ([shuzu count]==0)
        {
            
            [self.view endEditing:YES];
            __block FuWuYingYongXiangQingViewController *bSelf=self;
            [UIView animateWithDuration:0.25 animations:^{
                bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
            }];
            
            [mytableview headerEndRefreshing];
            [self showWithCustomView:@"服务器中暂未储存数据了哦，亲"];
        }
        
        if ([shuzu count]==1)
        {
            fuwushangjiaxiangxi *customer =[[fuwushangjiaxiangxi alloc]init];
            customer.session =Session;
            
            WorkItem *workItem1 =[[WorkItem alloc]init];
            NSString *a=[shuzu objectAtIndex:0];
            workItem1.id=a;
            NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1, nil];
            customer.id_list = workItems;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 1))]];
            
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            
            [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05
                                          Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                  NSLog(@"第二次:sssssssssss %@", str_jiemi);
                 SBJsonParser *parser=[[SBJsonParser alloc]init];
                 NSError *error=nil;
                 NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                 
                 NSMutableArray *info=[[NSMutableArray array]init];
                 info=[rootDic objectForKey:@"feedback_info"];
                 
                 
                _fakeData=info;
                [mytableview headerEndRefreshing];
                [mytableview reloadData];
                 }
             }];
            

            
        }
        if ([shuzu count]==2)
        {
            fuwushangjiaxiangxi *customer =[[fuwushangjiaxiangxi alloc]init];
            customer.session =Session;
            
            WorkItem *workItem1 =[[WorkItem alloc]init];
            NSString *a=[shuzu objectAtIndex:0];
            workItem1.id=a;
            WorkItem *workItem2 =[[WorkItem alloc]init];
            NSString *b=[shuzu objectAtIndex:1];
            workItem2.id=b;
            
            NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
            customer.id_list = workItems;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 2))]];
            
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];

            
            [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                     [mytableview headerEndRefreshing];
                     [mytableview reloadData];
                 
                 }
             }];

            
        }
        if ([shuzu count]==3)
        {
            fuwushangjiaxiangxi *customer =[[fuwushangjiaxiangxi alloc]init];
            customer.session =Session;
            
            WorkItem *workItem1 =[[WorkItem alloc]init];
            NSString *a=[shuzu objectAtIndex:0];
            workItem1.id=a;
            WorkItem *workItem2 =[[WorkItem alloc]init];
            NSString *b=[shuzu objectAtIndex:1];
            workItem2.id=b;
            WorkItem *workItem3 =[[WorkItem alloc]init];
            NSString *c=[shuzu objectAtIndex:2];
            workItem3.id =c;
            
            NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3, nil];
            customer.id_list = workItems;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 3))]];
            
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            
            [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                     [mytableview headerEndRefreshing];
                     [mytableview reloadData];
                 }
                 
             }];
            
            
        }
        if ([shuzu count]==4)
        {
            fuwushangjiaxiangxi *customer =[[fuwushangjiaxiangxi alloc]init];
            customer.session =Session;
            
            WorkItem *workItem1 =[[WorkItem alloc]init];
            NSString *a=[shuzu objectAtIndex:0];
            workItem1.id=a;
            WorkItem *workItem2 =[[WorkItem alloc]init];
            NSString *b=[shuzu objectAtIndex:1];
            workItem2.id=b;
            WorkItem *workItem3 =[[WorkItem alloc]init];
            NSString *c=[shuzu objectAtIndex:2];
            workItem3.id =c;
            WorkItem *workItem4 =[[WorkItem alloc]init];
            NSString *d=[shuzu objectAtIndex:3];
            workItem4.id =d;
            
            NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4, nil];
            customer.id_list = workItems;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 4))]];
            
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            
            [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                     [mytableview headerEndRefreshing];
                     [mytableview reloadData];
                 }
                 
             }];
            
            
        }
        if ([shuzu count]>=5)
        {
            fuwushangjiaxiangxi *customer =[[fuwushangjiaxiangxi alloc]init];
            customer.session =Session;
            
            WorkItem *workItem1 =[[WorkItem alloc]init];
            NSString *a=[shuzu objectAtIndex:0];
            workItem1.id=a;
            WorkItem *workItem2 =[[WorkItem alloc]init];
            NSString *b=[shuzu objectAtIndex:1];
            workItem2.id=b;
            WorkItem *workItem3 =[[WorkItem alloc]init];
            NSString *c=[shuzu objectAtIndex:2];
            workItem3.id =c;
            WorkItem *workItem4 =[[WorkItem alloc]init];
            NSString *d=[shuzu objectAtIndex:3];
            workItem4.id =d;
            WorkItem *workItem5 =[[WorkItem alloc]init];
            NSString *e=[shuzu objectAtIndex:4];
            workItem5.id =e;
            
            NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
            customer.id_list = workItems;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 5))]];
            
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            
            [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                 NSLog(@"第二次:sssssssssss %@", str_jiemi);
                 SBJsonParser *parser=[[SBJsonParser alloc]init];
                 NSError *error=nil;
                 NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                 
                 NSMutableArray *info=[[NSMutableArray array]init];
                 info=[rootDic objectForKey:@"feedback_info"];
                 
                _fakeData=info;
                [mytableview headerEndRefreshing];
                [mytableview reloadData];

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
- (void)addData
{
    @try
    {

        if([CheckNetwork isExistenceNetwork]==1)
        {
            
            // 增加5条假数据
            if ([shuzu count]==0)
            {
                [self.view endEditing:YES];
                __block FuWuYingYongXiangQingViewController *bSelf=self;
                [UIView animateWithDuration:0.25 animations:^{
                    bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                }];
                
                
                [self showWithCustomView:@"没有更多数据了哦，亲"];
            }
            if ([shuzu count]==1)
            {
                fwxq =[[fuwushangjiaxiangxi alloc]init];
                fwxq.session =Session;

                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[shuzu objectAtIndex:0];
                workItem1.id =a;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1, nil];
                [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 1))]];
                fwxq.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fwxq childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSLog(@"加载更多转换后的json串 %@", str1);
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05
                                              Paramters:Str
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
                         NSLog(@"第二次:sssssssssss %@", str_jiemi);
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
                         [mytableview reloadData];
                     }
                 }];
                
            }
            
            if ([shuzu count]==2)
            {
                fwxq =[[fuwushangjiaxiangxi alloc]init];
                fwxq.session =Session;
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[shuzu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[shuzu objectAtIndex:1];
                workItem2.id =b;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
                [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 2))]];
                fwxq.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fwxq childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSLog(@"加载更多转换后的json串 %@", str1);
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05                                              Paramters:Str
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
                         NSLog(@"第二次:sssssssssss %@", str_jiemi);
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
                         [mytableview reloadData];
                     }
                 }];
                
            }
            
            if ([shuzu count]==3)
            {
                fwxq =[[fuwushangjiaxiangxi alloc]init];
                fwxq.session =Session;
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[shuzu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[shuzu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[shuzu objectAtIndex:2];
                workItem3.id =c;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3, nil];
                [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 3))]];
                fwxq.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fwxq childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05                                              Paramters:Str
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
                         NSLog(@"第二次:sssssssssss %@", str_jiemi);
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
                         [mytableview reloadData];
                     }
                 }];
                
            }
            
            if ([shuzu count]==4)
            {
                fwxq =[[fuwushangjiaxiangxi alloc]init];
                fwxq.session =Session;
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[shuzu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[shuzu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[shuzu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[shuzu objectAtIndex:3];
                workItem4.id =d;
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4, nil];
                [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 4))]];
                fwxq.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fwxq childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05                                              Paramters:Str
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
                         NSLog(@"第二次:sssssssssss %@", str_jiemi);
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
                         [mytableview reloadData];
                     }
                     
                 }];
                
            }
            
            if ([shuzu count]==5)
            {
                fwxq =[[fuwushangjiaxiangxi alloc]init];
                fwxq.session =Session;
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[shuzu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[shuzu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[shuzu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[shuzu objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[shuzu objectAtIndex:4];
                workItem5.id =e;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 5))]];
                fwxq.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fwxq childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05                                              Paramters:Str
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
                         NSLog(@"第二次:sssssssssss %@", str_jiemi);
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
                         [mytableview reloadData];
                     }
                 }];
                
            }
            if ([shuzu count]>5)
            {
                fwxq =[[fuwushangjiaxiangxi alloc]init];
                fwxq.session =Session;
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[shuzu objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[shuzu objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[shuzu objectAtIndex:2];
                workItem3.id =c;
                WorkItem *workItem4 =[[WorkItem alloc]init];
                NSString *d=[shuzu objectAtIndex:3];
                workItem4.id =d;
                WorkItem *workItem5 =[[WorkItem alloc]init];
                NSString *e=[shuzu objectAtIndex:4];
                workItem5.id =e;
                
                NSArray *workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                [shuzu removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(shuzu.count, 5))]];
                fwxq.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:fwxq childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_05                                              Paramters:Str
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
                     NSLog(@"第二次:sssssssssss %@", str_jiemi);
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
                         [mytableview reloadData];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @try
    {

    self.view.backgroundColor =[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
        NSLog(@"  >>>>>  %@",FUWUdtDictionary);
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.text=@"商家信息";
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    myscrollview=[[UIScrollView alloc]init];
    myscrollview.delegate=self;
    myscrollview.frame=CGRectMake(0, 60, Width, Hidth-85);
    myscrollview.directionalLockEnabled =NO; //只能一个方向滑动
    myscrollview.pagingEnabled = NO; //是否翻页
    myscrollview.backgroundColor = [UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];

    
    label_biaoti=[[UILabel alloc]initWithFrame:CGRectMake(10,10, 230, 40)];
    label_biaoti.text=[FUWUdtDictionary objectForKey:@"store_name"];
    label_biaoti.font=[UIFont systemFontOfSize:18];
    [myscrollview addSubview:label_biaoti];
    dingwei=[[UIButton alloc]initWithFrame:CGRectMake(280, 15, 25, 40)];
    [dingwei setImage:[UIImage imageNamed:@"icon_marka.png"] forState:UIControlStateNormal];
    [dingwei addTarget:self action:@selector(jingweidudingwei) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:dingwei];
    label_jibie=[[UILabel alloc]initWithFrame:CGRectMake(10,50, 80, 20)];
    label_jibie.text=@"推荐级别：";
    label_jibie.font=[UIFont systemFontOfSize:14];
    [myscrollview addSubview:label_jibie];
    NSString *str_a=[FUWUdtDictionary objectForKey:@"star_level"];
    float floatString = [str_a floatValue];
    int a=round(floatString);
    if (a==0)
    {
        for (int k=0; k<5; k++)
        {
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }
    }
    if (a==1)
    {
        UIImageView *imagevie=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
        imagevie.frame=CGRectMake(80, 52, 15, 15);
        [myscrollview addSubview:imagevie];
        for (int k=1; k<5; k++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }
    }

    if (a==2)
    {
        for (int j=0; j<2; j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }
        for (int k=2; k<5; k++)
        {
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }
    }
    if (a==3)
    {
        for (int j=0; j<3; j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }
        for (int k=3; k<5; k++)
        {
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }
    }
    if (a==4)
    {
        for (int j=0; j<4; j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }
        for (int k=4; k<5; k++)
        {
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }
    }

    if (a==5)
    {
        for (int j=0; j<5; j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
            [myscrollview addSubview:imageview];
        }

    }

    label_dizhi=[[UILabel alloc]initWithFrame:CGRectMake(10,80, 260, 20)];
    NSString *str1=[FUWUdtDictionary objectForKey:@"store_address"];
    label_dizhi.text=[NSString stringWithFormat:@"地址：%@", str1];
    label_dizhi.font=[UIFont systemFontOfSize:14];
    [myscrollview addSubview:label_dizhi];
    label_dianhua1=[[UILabel alloc]initWithFrame:CGRectMake(10, 110, 40, 20)];
    label_dianhua1.text=@"电话:";
    label_dianhua1.font=[UIFont systemFontOfSize:14];
    [myscrollview addSubview:label_dianhua1];
    label_dianhua2=[[UILabel alloc]initWithFrame:CGRectMake(50, 110, 180, 20)];
    label_dianhua2.text=[FUWUdtDictionary objectForKey:@"phone"];
    label_dianhua2.textColor=[UIColor greenColor];
    label_dianhua2.font=[UIFont systemFontOfSize:14];
    [myscrollview addSubview:label_dianhua2];
    label_dianjiaxiangxi=[[UILabel alloc]initWithFrame:CGRectMake(10, 140, 150, 20)];
    label_dianjiaxiangxi.text=@"店家详细:";
    [myscrollview addSubview:label_dianjiaxiangxi];
    UILabel * testlable = [[UILabel alloc]initWithFrame:CGRectMake(10,20,200,20)];
    NSString * tstring =[FUWUdtDictionary objectForKey:@"describtion"];
    testlable.numberOfLines =0;
    UIFont * tfont = [UIFont systemFontOfSize:14];
    testlable.font = tfont;
    testlable.lineBreakMode =NSLineBreakByTruncatingTail ;
    testlable.text = tstring ;
    CGSize ze =CGSizeMake(300,600);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize =[tstring boundingRectWithSize:ze options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    testlable.frame =CGRectMake(10,170, actualsize.width, actualsize.height);
    [myscrollview addSubview:testlable];
    label_zhuyingxiangmu=[[UILabel alloc]initWithFrame:CGRectMake(10,actualsize.height+180, 160, 20)];
    label_zhuyingxiangmu.text=@"主要经营项目：";
    [myscrollview addSubview:label_zhuyingxiangmu];
    NSArray *arr_goods=[[NSArray alloc]initWithArray:[FUWUdtDictionary objectForKey:@"goods"]];
    for (int i=0;i<[arr_goods count]; i++)
    {
       NSString *string=[[arr_goods objectAtIndex:i] objectForKey:@"image_url"];
       UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
       UIImageView *imageview2=[[UIImageView alloc]initWithImage:img];
       imageview2.frame=CGRectMake(5, actualsize.height+210+41*i, 40, 40);
       imageview2.backgroundColor=[UIColor whiteColor];
       [myscrollview addSubview:imageview2];
        UILabel *label_chanpin=[[UILabel alloc]initWithFrame:CGRectMake(45, actualsize.height+210+41*i, 265, 40)];
        NSString *str=[[arr_goods objectAtIndex:i] objectForKey:@"goods_name"];
        label_chanpin.text=[NSString stringWithFormat:@"  %@", str];
        label_chanpin.backgroundColor=[UIColor whiteColor];
        label_chanpin.font=[UIFont systemFontOfSize:14];
        [myscrollview addSubview:label_chanpin];
        
    }
    arr_pinglun=[[NSArray alloc]initWithArray:[FUWUdtDictionary objectForKey:@"fb_id_list"]];
    int strb=[arr_pinglun count];
    label_pinglun=[[UILabel alloc]initWithFrame:CGRectMake(10, actualsize.height+210+41*[arr_goods count], 300, 20)];
    label_pinglun.text=[NSString stringWithFormat:@"反馈评论：%d条", strb];
    label_pinglun.font=[UIFont systemFontOfSize:14];
    [myscrollview addSubview:label_pinglun];
    if (strb==0)
    {
        h=0;
        mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, actualsize.height+230+41*[arr_goods count], 320, h)];
    }
    else if (0<strb&&strb<=5)
    {
        h=60*strb;
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, actualsize.height+230+41*[arr_goods count], 320, h)];
    }
    else
    {
        h=300;
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, actualsize.height+230+41*[arr_goods count], 320, h)];
    }
    _fakeData = [NSMutableArray array];
    mytableview.dataSource=self;
    mytableview.delegate=self;
    [self.view addSubview:mytableview];
    [mytableview addHeaderWithTarget:self action:@selector(dataInit)];
    [mytableview addFooterWithTarget:self action:@selector(addData)];
    [mytableview headerBeginRefreshing];

    
    
    CGSize newSize = CGSizeMake(self.view.frame.size.width,actualsize.height+240+41*[arr_goods count]+h);
    [myscrollview setContentSize:newSize];
    myscrollview.showsVerticalScrollIndicator =YES;
    //添加scrollview
    [self.view addSubview:myscrollview];

    label=[[UILabel alloc]initWithFrame:CGRectMake(0, Hidth-36, Width, 36)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label];
    fabiao=[[UIButton alloc]initWithFrame:CGRectMake(5, Hidth-33, 310, 30)];
    fabiao.backgroundColor=[UIColor whiteColor];
    [fabiao setTitle:@"我也说一句..." forState:UIControlStateNormal];
    [fabiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fabiao.layer.masksToBounds = YES;
    fabiao.layer.cornerRadius = 5;
    [fabiao addTarget:self action:@selector(fabiaoshuoshuo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fabiao];
    
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
//指定有多少个分区(Section)，默认为1

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;//返回标题数组中元素的个数来确定分区的个数
    
}
//指定每个分区中有多少行，默认为1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       if ([arr_pinglun count]==0)
    {
        return 0;
    }
     if (0<[arr_pinglun count]&&[arr_pinglun count]<=5)
    {
        return [arr_pinglun count];
    }
     if ([arr_pinglun count]>=5)
    {
        return 5;
    }
   else
    {
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

//绘制Cell

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
    
    
    UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, 260, 20)];
    labela.text=[NSString stringWithFormat:@"%@",[_fakeData[indexPath.row] objectForKey:@"feedback_time"]];
    labela.font=[UIFont systemFontOfSize:14];
    [cell addSubview:labela];
    UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(50, 20, 260, 20)];
    labelb.text=[NSString stringWithFormat:@"%@ ",[_fakeData[indexPath.row] objectForKey:@"feedback_content"]];
    labelb.font=[UIFont systemFontOfSize:14];
    [cell addSubview:labelb];
    NSString *str_a=[_fakeData[indexPath.row] objectForKey:@"feedback_star"];
    float floatString = [str_a floatValue];
    int a=round(floatString);
    if (a==0)
    {
        for (int k=0; k<5; k++)
        {
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(240+15*k, 3, 15, 15);
            [cell addSubview:imageview];
        }
    }
    if (a==1)
    {
        UIImageView *imagevie=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
        imagevie.frame=CGRectMake(240, 3, 15, 15);
        [cell addSubview:imagevie];
        for (int k=1; k<5; k++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(240+15*k, 3, 15, 15);
            [cell addSubview:imageview];
        }
    }
    
    if (a==2)
    {
        for (int j=0; j<2; j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imageview.frame=CGRectMake(240+15*j, 3, 15, 15);
            [cell addSubview:imageview];
        }
        for (int k=2; k<5; k++)
        {
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(240+15*k, 3, 15, 15);
            [cell addSubview:imageview];
        }
    }
    if (a==3)
    {
        for (int j=0; j<3; j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imageview.frame=CGRectMake(240+15*j, 3, 15, 15);
            [cell addSubview:imageview];
        }
        for (int k=3; k<5; k++)
        {
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(240+15*k, 3, 15, 15);
            [cell addSubview:imageview];
        }
    }
    if (a==4)
    {
        for (int j=0; j<4; j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imageview.frame=CGRectMake(240+15*j, 3, 15, 15);
            [cell addSubview:imageview];
        }
        for (int k=4; k<5; k++)
        {
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
            imageview.frame=CGRectMake(240+15*k, 3, 15, 15);
            [cell addSubview:imageview];
        }
    }
    
    if (a==5)
    {
        for (int j=0; j<5; j++)
        {
            
            UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imageview.frame=CGRectMake(240+15*j, 3, 15, 15);
            [cell addSubview:imageview];
        }
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
        
        
        
}


-(void)fabiaoshuoshuo
{
    if (UserName==nil)
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }
    else
    {
        ShangJiaPingJiaViewController *pingjia=[[ShangJiaPingJiaViewController alloc]init];
        [self presentViewController:pingjia animated:NO completion:nil];
    }
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
- (void)showWithCustomView:(NSString*)aString {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}
-(void)jingweidudingwei
{
    ShangJiaDiTuDingWeiViewController *ding=[[ShangJiaDiTuDingWeiViewController alloc]init];
    [self presentViewController:ding animated:NO completion:nil];
    
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
