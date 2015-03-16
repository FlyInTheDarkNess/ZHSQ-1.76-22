//
//  SheQuHuDongViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-7-28.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "SheQuHuDongViewController.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+MJRefresh.h"
#import "FaBiaoTieZiViewController.h"

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
#import "SheQuHuDongXiangQingViewController.h"
#import "URL.h"
#import "JiaMiJieMi.h"

#import "RegexKitLite.h"
#import "SCGIFImageView.h"
#import "CustomLongPressGestureRecognizer.h"
#import <QuartzCore/QuartzCore.h>
#import "APService.h"
#import "MobClick.h"

NSString *const SheQuHuDongMJTableViewCellIdentifier = @"Cell";
extern NSString *UserName;
extern NSDictionary *SheQuHuDongXiangQingDictionary;
extern NSString *xiaoquIDString;
@interface SheQuHuDongViewController ()
{
    NSMutableArray *_fakeData;
    NSMutableArray *shijian;
}

@end

@implementation SheQuHuDongViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"PageOne"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"PageOne"];
}
- (void)dataInit
{
    @try
    {
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"xiaoquID"];
   // NSLog(@"小区ID：%@",myString);
    if([CheckNetwork isExistenceNetwork]==1)
    {
        
        arr=[[NSMutableArray alloc]init];
        SheQuHuDongZhuJian *custo =[[SheQuHuDongZhuJian alloc]init];
        custo.city_id =@"101";
        custo.community_id=@"102";
        custo.quarter_id=xiaoquIDString;
        custo.module_id=@"";
        NSString *st = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:custo childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:st];
        NSString *str2=@"para=";
        NSString *Stro;
        Stro=[str2 stringByAppendingString:str_jiami];
        [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_02 Paramters:Stro FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {

            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            NSLog(@"第一次: %@", str_jiemi);//result就是NSString类型的返回值

            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
            
            NSString *daima=[rootDic objectForKey:@"ecode"];
            int intString = [daima intValue];
            if (intString==1000)
            {
                
                NSArray *shuzu=[[NSArray alloc]init];
                shuzu=[rootDic objectForKey:@"id_list"];
            //    NSLog(@"数组 \n %@",shuzu);
                int i;
                for (i=0; i<[shuzu count]; i++)
                {
                    NSDictionary *dic=[[NSDictionary alloc]init];
                    dic=[shuzu objectAtIndex:i];
                    NSString *stringInt =[dic objectForKey:@"id"];
                    [arr addObject:stringInt];
                }

             //   NSLog(@"反编后的数组 \n %@",arr);
                
                if ([arr count]==0)
                {
                    
                    [self.view endEditing:YES];
                    __block SheQuHuDongViewController *bSelf=self;
                    [UIView animateWithDuration:0.25 animations:^{
                        bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                    }];
                    
                    [tableview headerEndRefreshing];

                    [self showWithCustomView:@"服务器中暂未储存数据了哦，亲"];
                }
                
                if ([arr count]==1)
                {
                    SheQuHuDong *customer =[[SheQuHuDong alloc]init];
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
                    
                    [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                         info=[rootDic objectForKey:@"info"];
                             for (int i=[info count]-1; i>=0; i--)
                             {
                                 NSString *str=[info objectAtIndex:i];
                                 [_fakeData addObject:str];
                             }
                             [tableview headerEndRefreshing];
                             [tableview reloadData];
                         }
                         
                     }];
                }
                if ([arr count]==2)
                {
                    SheQuHuDong *customer =[[SheQuHuDong alloc]init];
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
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03 Paramters:Str FinishCallbackBlock:^(NSString *result)
                     {
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
                         info=[rootDic objectForKey:@"info"];
                         for (int i=[info count]-1; i>=0; i--)
                             {
                                 NSString *str=[info objectAtIndex:i];
                                 [_fakeData addObject:str];
                                 [tableview reloadData];
                             }
                             [tableview headerEndRefreshing];
                             [tableview reloadData];

                         }
                         
                     }];
                    
                    
                }
                if ([arr count]==3)
                {
                    SheQuHuDong *customer =[[SheQuHuDong alloc]init];
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
                    
                    [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                         info=[rootDic objectForKey:@"info"];
                        for (int i=[info count]-1; i>=0; i--)
                             {
                                 NSString *str=[info objectAtIndex:i];
                                 [_fakeData addObject:str];
                                 [tableview reloadData];

                             }
                             [tableview headerEndRefreshing];
                             [tableview reloadData];

                         }
                     }];
                    
                    
                }
                if ([arr count]==4)
                {
                    SheQuHuDong *customer =[[SheQuHuDong alloc]init];
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
                    
                    [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                         info=[rootDic objectForKey:@"info"];
                        for (int i=[info count]-1; i>=0; i--)
                             {
                                 NSString *str=[info objectAtIndex:i];
                                 [_fakeData addObject:str];
                                 [tableview reloadData];

                             }
                             [tableview headerEndRefreshing];
                             [tableview reloadData];

                         }
                     }];
                    
                    
                }
                if ([arr count]>=5)
                {
                    SheQuHuDong *customer =[[SheQuHuDong alloc]init];
                    
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
                    NSLog(@"chanshu  %@",str1);
                    [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 5))]];
                    
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    
                    [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                        // NSLog(@"第一次: %@", str_jiemi);//result就是NSString类型的返回值
                         
                         SBJsonParser *parser=[[SBJsonParser alloc]init];
                         NSError *error=nil;
                         NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                         
                         NSMutableArray *info=[[NSMutableArray array]init];
                         info=[rootDic objectForKey:@"info"];
                        for (int i=[info count]-1; i>=0; i--)
                             {
                                 NSString *str=[info objectAtIndex:i];
                                 [_fakeData addObject:str];
                                 [tableview reloadData];
                             }
                             [tableview headerEndRefreshing];
                             [tableview reloadData];

                         }
                         
                     }];
                    
                    
                }
                [self.view addSubview:tableview];
            }
            if (intString==4000)
            {
                [self showWithCustomView:@"服务器内部错误"];
                
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
            if ([arr count]==0)
            {
                [self.view endEditing:YES];
                __block SheQuHuDongViewController *bSelf=self;
                [UIView animateWithDuration:0.25 animations:^{
                    bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                }];
                
                [tableview footerEndRefreshing];
                [self showWithCustomView:@"没有更多数据了哦，亲"];
            }
            if ([arr count]==1)
            {
                customers =[[SheQuHuDong alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                
                workItemss = [[NSArray alloc] initWithObjects:workItem1, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 1))]];
                customers.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customers childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03 Paramters:Str
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
                     info=[rootDic objectForKey:@"info"];
                     
                        for (int i=[info count]-1; i>=0; i--)
                         {
                             NSString *str=[info objectAtIndex:i];
                             [_fakeData addObject:str];
                        }
                         [tableview footerEndRefreshing];
                         [tableview reloadData];

                     }
                 }];
                
            }
            
            if ([arr count]==2)
            {
                customers =[[SheQuHuDong alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id =b;
                
                workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 2))]];
                customers.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customers childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                //NSLog(@"加载更多转换后的json串 %@", str1);
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03 Paramters:Str
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
                     info=[rootDic objectForKey:@"info"];
                     
                         for (int i=[info count]-1; i>=0; i--)
                         {
                             NSString *str=[info objectAtIndex:i];
                             [_fakeData addObject:str];
                           
                         }
                         [tableview footerEndRefreshing];
                         [tableview reloadData];

                     }
                 }];
                
            }
            
            if ([arr count]==3)
            {
                customers =[[SheQuHuDong alloc]init];
                WorkItem *workItem1 =[[WorkItem alloc]init];
                NSString *a=[arr objectAtIndex:0];
                workItem1.id =a;
                WorkItem *workItem2 =[[WorkItem alloc]init];
                NSString *b=[arr objectAtIndex:1];
                workItem2.id =b;
                WorkItem *workItem3 =[[WorkItem alloc]init];
                NSString *c=[arr objectAtIndex:2];
                workItem3.id =c;
                
                workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 3))]];
                customers.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customers childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03 Paramters:Str
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
                     info=[rootDic objectForKey:@"info"];
                     
                         for (int i=[info count]-1; i>=0; i--)
                         {
                             NSString *str=[info objectAtIndex:i];
                             [_fakeData addObject:str];
                    
                         }
                         [tableview footerEndRefreshing];
                         [tableview reloadData];

                     }
                 }];
                
            }
            
            if ([arr count]==4)
            {
                customers =[[SheQuHuDong alloc]init];
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
                workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 4))]];
                customers.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customers childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03                                     Paramters:Str
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
                     info=[rootDic objectForKey:@"info"];
                     
                         for (int i=[info count]-1; i>=0; i--)
                         {
                             NSString *str=[info objectAtIndex:i];
                             [_fakeData addObject:str];
                        }
                         [tableview footerEndRefreshing];
                         [tableview reloadData];

                     }
                 }];
                
            }
            
            if ([arr count]==5)
            {
                customers =[[SheQuHuDong alloc]init];
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
                
                workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 5))]];
                customers.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customers childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];
                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03                                              Paramters:Str
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
                     info=[rootDic objectForKey:@"info"];
                     
                         for (int i=[info count]-1; i>=0; i--)
                         {
                             NSString *str=[info objectAtIndex:i];
                             [_fakeData addObject:str];
                        }
                         [tableview footerEndRefreshing];
                         [tableview reloadData];

                     }
                     
                 }];
                
            }
            if ([arr count]>5)
            {
                customers =[[SheQuHuDong alloc]init];
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
                
                workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5, nil];
                [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 5))]];
                customers.id_list = workItemss;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customers childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                NSString *str2=@"para=";
                NSString *Str;
                Str=[str2 stringByAppendingString:str_jiami];

                [HttpPostExecutor postExecuteWithUrlStr:SheQuHuDong_m10_03                                               Paramters:Str
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
                     info=[rootDic objectForKey:@"info"];
                     
                         for (int i=[info count]-1; i>=0; i--)
                         {
                             NSString *str=[info objectAtIndex:i];
                             [_fakeData addObject:str];
                        }
                         [tableview footerEndRefreshing];
                         [tableview reloadData];

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
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.text=@"社区论坛";
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    fatie=[[UIButton alloc]initWithFrame:CGRectMake(280, 25, 30, 30)];
    [fatie setImage:[UIImage imageNamed:@"fatie0508.png"] forState:UIControlStateNormal];
    [fatie addTarget:self action:@selector(zhudongfatie) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fatie];
    self.view.backgroundColor=[UIColor whiteColor];
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth-60)];
    tableview.dataSource=self;
    tableview.delegate=self;
    [self.view addSubview:tableview];
    
    [tableview addHeaderWithTarget:self action:@selector(dataInit)];
    [tableview addFooterWithTarget:self action:@selector(addData)];
    [tableview headerBeginRefreshing];

    SheQuHuDongXiangQingDictionary=[[NSDictionary alloc]init];
    _fakeData = [NSMutableArray array];
    NSArray *wk_paceImageNumArray = [[NSArray alloc]initWithObjects:@"emoji_1.png",@"emoji_2.png",@"emoji_3.png",@"emoji_4.png",@"emoji_5.png",@"emoji_6.png",@"emoji_7.png",@"emoji_8.png",@"emoji_9.png",@"emoji_10.png",@"emoji_11.png",@"emoji_12.png",@"emoji_13.png",@"emoji_14.png",@"emoji_15.png",@"emoji_16.png",@"emoji_17.png",@"emoji_18.png",@"emoji_19.png",@"emoji_20.png",@"emoji_21.png",@"emoji_22.png",@"emoji_23.png",@"emoji_24.png",@"emoji_25.png",@"emoji_26.png",@"emoji_27.png",@"emoji_28.png",@"emoji_29.png",@"emoji_30.png",@"emoji_31.png",@"emoji_32.png",@"emoji_33.png",@"emoji_34.png",@"emoji_35.png",@"emoji_36.png",@"emoji_37.png",@"emoji_38.png",@"emoji_39.png",@"emoji_40.png",@"emoji_41.png",@"emoji_42.png",@"emoji_43.png",@"emoji_44.png",@"emoji_45.png",@"emoji_45.png",@"emoji_47.png",@"emoji_48.png",@"emoji_49.png",@"emoji_50.png",@"emoji_51.png",@"emoji_52.png",@"emoji_53.png",@"emoji_54.png",@"emoji_55.png",@"emoji_56.png",@"emoji_57.png",@"emoji_58.png",@"emoji_59.png",@"emoji_60.png",@"emoji_16.png",@"emoji_62.png",@"emoji_63.png",@"emoji_64.png",@"emoji_65.png",@"emoji_66.png",@"emoji_67.png",@"emoji_68.png",@"emoji_69.png",@"emoji_70.png",@"emoji_71.png",@"emoji_179.png",@"emoji_180.png",@"emoji_181.png",@"emoji_182.png",@"emoji_183.png",@"emoji_184.png",@"emoji_185.png",@"emoji_186.png",@"emoji_187.png",@"emoji_188.png",@"emoji_189.png",@"emoji_190.png",@"emoji_191.png",@"emoji_192.png",@"emoji_193.png",@"emoji_194.png",@"emoji_195.png",@"emoji_196.png",@"emoji_197.png",@"emoji_198.png",@"emoji_199.png",@"emoji_200.png",@"emoji_201.png",@"emoji_202.png",@"emoji_203.png",@"emoji_204.png",@"emoji_205.png",@"emoji_206.png",@"emoji_207.png",@"emoji_208.png",@"emoji_209.png",@"emoji_210.png",@"emoji_211.png",@"emoji_212.png",@"emoji_213.png",@"emoji_214.png",@"emoji_215.png",@"emoji_216.png",@"emoji_217.png",@"emoji_218.png",@"emoji_219.png",@"emoji_220.png",@"emoji_221.png",@"emoji_222.png",@"emoji_223.png",@"emoji_224.png", nil];
    NSArray *wk_paceImageNameArray = [[NSArray alloc]initWithObjects:@"[可爱]",@"[笑脸]",@"[囧]",@"[生气]",@"[鬼脸]",@"[花心]",@"[害怕]",@"[我汗]",@"[尴尬]",@"[哼哼]",@"[忧郁]",@"[呲牙]",@"[媚眼]",@"[累]",@"[苦逼]",@"[瞌睡]",@"[哎呀]",@"[刺瞎]",@"[哭]",@"[激动]",@"[难过]",@"[害羞]",@"[高兴]",@"[愤怒]",@"[亲]",@"[飞吻]",@"[得意]",@"[惊恐]",@"[口罩]",@"[惊讶]",@"[委屈]",@"[生病]",@"[红心]",@"[心碎]",@"[玫瑰]",@"[花]",@"[外星人]",@"[金牛座]",@"[双子座]",@"[巨蟹座]",@"[狮子座]",@"[处女座]",@"[天平座]",@"[天蝎座]",@"[射手座]",@"[摩羯座]",@"[水瓶座]",@"[白羊座]",@"[双鱼座]",@"[星座]",@"[男孩]",@"[女孩]",@"[嘴唇]",@"[爸爸]",@"[妈妈]",@"[衣服]",@"[皮鞋]",@"[照相]",@"[电话]",@"[石头]",@"[胜利]",@"[禁止]",@"[滑雪]",@"[高尔夫]",@"[网球]",@"[棒球]",@"[冲浪]",@"[足球]",@"[小鱼]",@"[问号]",@"[叹号]",@"[顶]",@"[写字]",@"[衬衫]",@"[小花]",@"[郁金香]",@"[向日葵]",@"[鲜花]",@"[椰树]",@"[仙人掌]",@"[气球]",@"[炸弹]",@"[喝彩]",@"[剪子]",@"[蝴蝶结]",@"[机密]",@"[铃声]",@"[女帽]",@"[裙子]",@"[理发店]",@"[和服]",@"[比基尼]",@"[拎包]",@"[拍摄]",@"[铃铛]",@"[音乐]",@"[心星]",@"[粉心]",@"[丘比特]",@"[吹气]",@"[口水]",@"[对]",@"[错]",@"[绿茶]",@"[面包]",@"[面条]",@"[咖喱饭]",@"[饭团]",@"[麻辣烫]",@"[寿司]",@"[苹果]",@"[橙子]",@"[草莓]",@"[西瓜]",@"[柿子]",@"[眼睛]",@"[好的]", nil];
    m_emojiDic = [[NSDictionary alloc] initWithObjects:wk_paceImageNumArray forKeys:wk_paceImageNameArray];
    
    

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
    labelRect.size.width = [label sizeThatFits:CGSizeMake(260, CGFLOAT_MAX)].width;
    labelRect.size.height = [label sizeThatFits:CGSizeMake(260, 65)].height;
    label.frame = labelRect;
    label.underlineLinks = YES;//链接是否带下划线
    [label.layer display];
}

- (BOOL)attributedLabel:(OHAttributedLabel *)attributedLabel shouldFollowLink:(NSTextCheckingResult *)linkInfo
{
    //4
    NSString *requestString = [linkInfo.URL absoluteString];
    if ([[UIApplication sharedApplication]canOpenURL:linkInfo.URL]) {
        [[UIApplication sharedApplication]openURL:linkInfo.URL];
    }
    
    return NO;
}



-(void)zhudongfatie
{
    FaBiaoTieZiViewController *fatie=[[FaBiaoTieZiViewController alloc]init];
    [self presentViewController:fatie animated:NO completion:nil];
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *creator_url=[_fakeData[indexPath.row] objectForKey:@"creator_icon"];
    if (creator_url.length>0)
    {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){ 5, 10, 40, 40 }];
        imageView.tag=100;
        //圆角设置
        imageView.layer.cornerRadius = 20;
        imageView.layer.masksToBounds = YES;
        [imageView.layer setBorderColor:[[UIColor redColor] CGColor]];  //设置边框为蓝色
        [imageView setImageWithURL:[NSURL URLWithString:creator_url]
                      placeholderImage:[UIImage imageNamed:@"shequhudong1"]
                               options:SDWebImageRetryFailed
           usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

//        imageb= [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 40,40)];
//        imageb.tag = 1000;
//        imageb.userInteractionEnabled=NO;
//        [imageb setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",creator_url]]
//               placeholderImage:[UIImage imageNamed:@"tx10"] options:SDWebImageProgressiveDownload];
        [cell.contentView addSubview:imageView];
    }
    else
    {
        UIImageView *imagec=[[UIImageView alloc]init];
        imagec.image=[UIImage imageNamed:@"m_personcenter.png"];
        //圆角设置
        imagec.frame=CGRectMake(5, 10, 40,40);
        imagec.layer.cornerRadius = 20;
        imagec.layer.masksToBounds = YES;
        imagec.layer.borderColor=[UIColor redColor].CGColor;
        [cell.contentView addSubview:imagec];

    }
    UILabel *label_creator=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, 255, 20)];

    if ([[_fakeData[indexPath.row] objectForKey:@"nickname"] isEqualToString:@""])
    {
        NSString *st=[_fakeData[indexPath.row] objectForKey:@"mobile_phone"];
        NSString *a=[st substringWithRange:NSMakeRange(0,3)];
        NSString *b=[st substringWithRange:NSMakeRange(7,4)];
        NSString *str_nickname=[NSString stringWithFormat:@"%@****%@",a,b];
        label_creator.text=str_nickname;
        
    }
    else
    {
        label_creator.text=[_fakeData[indexPath.row] objectForKey:@"nickname"];
    }
    label_creator.backgroundColor=[UIColor whiteColor];
    label_creator.font=[UIFont systemFontOfSize:12];
    label_creator.textColor=[UIColor blackColor];
    [cell addSubview:label_creator];
    
    UILabel *label_create_time=[[UILabel alloc]initWithFrame:CGRectMake(60, 30, 255, 20)];
    label_create_time.text=[_fakeData[indexPath.row] objectForKey:@"create_time"];
    label_create_time.backgroundColor=[UIColor whiteColor];
    label_create_time.font=[UIFont systemFontOfSize:12];
    label_create_time.textColor=[UIColor blackColor];
    [cell addSubview:label_create_time];
   
    OHAttributedLabel *label = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    NSString *text = [CustomMethod escapedString:[_fakeData[indexPath.row] objectForKey:@"title"]];
    
    [self creatAttributedLabel:text Label:label];
    [CustomMethod drawImage:label];
    
    UIView *view = [[UIView alloc] init];
    
    
    OHAttributedLabel *label2 = label;
    view.frame = CGRectMake(60, 50, 250, label2.frame.size.height);
    //NSLog(@"%f",label2.frame.size.width);
    label2.textColor=[UIColor blueColor];
    
    [view addSubview:label2];
    [cell addSubview:view];
    
    
    OHAttributedLabel *labelll = [[OHAttributedLabel alloc] initWithFrame:CGRectZero];
    NSString *texttt = [CustomMethod escapedString:[_fakeData[indexPath.row] objectForKey:@"content"]];
    [self creatAttributedLabel:texttt Label:labelll];
    [CustomMethod drawImage:labelll];
    
    UIView *viewww = [[UIView alloc] init];
    viewww.backgroundColor=[UIColor colorWithRed:234/255.0 green:87/255.0 blue:83/255.0 alpha:0.2];
    OHAttributedLabel *label2ll = labelll;
    viewww.frame = CGRectMake(60, 50+label2.frame.size.height, 260, label2ll.frame.size.height);

    //NSLog(@"zuobiao   %f",label2ll.frame.size.height);
    [viewww addSubview:label2ll];
    [cell addSubview:viewww];

    NSArray *imagelist=[[NSArray alloc]init];
    imagelist=[_fakeData[indexPath.row] objectForKey:@"images"];
    NSDictionary *imzgedic=[[NSDictionary alloc]init];
    imzgedic=[imagelist objectAtIndex:0];
    NSString *image_url=[imzgedic objectForKey:@"thumbs_url"];
     NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]];
    if ((image_url.length>0&&![image_url isEqualToString:@""])&&(image_url!=nil)&&(data.length>0))
    {
        UIImageView *imagea=[[UIImageView alloc]init];
        imagea= [[UIImageView alloc]initWithFrame:CGRectMake(60, label2.frame.size.height+label2ll.frame.size.height+60, 80,60)];
        imagea.tag = 1000;
        imagea.userInteractionEnabled=NO;
        [imagea setImageWithURL:[NSURL URLWithString:image_url]
                      placeholderImage:[UIImage imageNamed:@"shequhudong2"]
                               options:SDWebImageRetryFailed
           usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [cell.contentView addSubview:imagea];
        
        
//        DBImageView *imageView = [[DBImageView alloc] initWithFrame:(CGRect){ 60, label2.frame.size.height+label2ll.frame.size.height+60, 80,60 }];
//        //圆角设置
//        //自动适应,保持图片宽高比
//        imageView.contentMode= UIViewContentModeScaleAspectFit;
//        
//        [imageView setPlaceHolder:[UIImage imageNamed:@"Placeholder"]];
//        [imageView setTag:102];
//        [imageView setImageWithPath:creator_url];
//        [cell.contentView addSubview:imageView];

        gaodu=label2ll.frame.size.height+120+label2.frame.size.height;
    }
    else
    {
        gaodu=label2ll.frame.size.height+60+label2.frame.size.height;

    }
    UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(5, gaodu, 315, 20)];
    labelc.text=[NSString stringWithFormat:@"评论  %@ ",[_fakeData[indexPath.row] objectForKey:@"feedback_num"]];
    labelc.backgroundColor=[UIColor whiteColor];
    labelc.font=[UIFont systemFontOfSize:12];
    labelc.textAlignment=NSTextAlignmentRight;
    labelc.textColor=[UIColor blackColor];
    [cell addSubview:labelc];
    labelline=[[UILabel alloc]initWithFrame:CGRectMake(0, gaodu+19, 320, 1)];
    [cell addSubview:labelline];
    labelline.backgroundColor=[UIColor grayColor];
    CGRect cellFrame = [cell frame];
    cellFrame.size.height =gaodu+20;
    [cell setFrame:cellFrame];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SheQuHuDongXiangQingDictionary=_fakeData[indexPath.row];
   // NSLog(@"%@",SheQuHuDongXiangQingDictionary);
    SheQuHuDongXiangQingViewController *xiangqing=[[SheQuHuDongXiangQingViewController alloc]init];
    [self presentViewController:xiangqing animated:NO completion:nil];

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fakeData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
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
