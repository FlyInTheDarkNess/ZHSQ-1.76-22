//
//  ShiPinYaoPinViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ShiPinYaoPinViewController.h"
#import "UIScrollView+MJRefresh.h"

#import "ShiPinYaoPinXiangQingViewController.h"
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
#import "APService.h"
#import "MobClick.h"

#import "URL.h"
#import "JiaMiJieMi.h"
#import "fuwu.h"
NSString *const ShiPinYaoPinMJTableViewCellIdentifier = @"Cell";
extern NSDictionary *ShiPinYaoPin_Dictionary;

@interface ShiPinYaoPinViewController ()
{
    NSMutableArray *_fakeData;
    NSMutableArray *shijian;
}
@end

@implementation ShiPinYaoPinViewController

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
            
            NSString *str1=@"{\"city_id\":\"101\",\"article_type_id\":\"56\"}";
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            
            arr=[[NSMutableArray alloc]init];
            
            [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
                // 执行post请求完成后的逻辑
                if (result.length<=0)
                {
                    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [aler show];
                }
                else
                {

                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                NSLog(@">>>>>>>>>>>%@",str_jiemi);
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
                    [arr addObject:stringInt];
                }
                if ([arr count]==0)
                {
                    
                    [self.view endEditing:YES];
                    __block ShiPinYaoPinViewController *bSelf=self;
                    [UIView animateWithDuration:0.25 animations:^{
                        bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                    }];
                    
                    [tableview headerEndRefreshing];
                    [self showWithCustomView:@"服务器中暂未储存数据了哦，亲"];
                }
                if ([arr count]<10)
                {
                    fuwu *gonggao =[[fuwu alloc]init];
                    NSArray *workItems = [[NSArray alloc]initWithArray:shuzu];
                    gonggao.id_list = workItems;
                    
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    // NSLog(@"=======%@",str1);
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02                                          Paramters:Str FinishCallbackBlock:^(NSString *result)
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

                         [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, shuzu.count))]];
                         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                         // NSLog(@"第二次:sssssssssss %@", str_jiemi);
                         SBJsonParser *parser=[[SBJsonParser alloc]init];
                         NSError *error=nil;
                         NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                         NSString *daima=[rootDic objectForKey:@"ecode"];
                         int intString = [daima intValue];
                         if (intString==4000)
                         {
                             [self showWithCustomView:@"服务器内部错误"];
                         }
                         if (intString==1000)
                         {
                             NSMutableArray *info=[[NSMutableArray array]init];
                             info=[rootDic objectForKey:@"news_info"];
                            _fakeData=info;
                             [tableview headerEndRefreshing];
                             [tableview reloadData];
                             
                         }
                         }
                     }];
                    
                }
                
                if ([arr count]>=10)
                {
                    fuwu *gonggao =[[fuwu alloc]init];
                    
                    WorkItem *workItem1 =[[WorkItem alloc]init];
                    NSString *a=[arr objectAtIndex:0];
                    workItem1.id=a;
                    WorkItem *workItem2 =[[WorkItem alloc]init];
                    NSString *b=[arr objectAtIndex:1];
                    workItem2.id=b;
                    WorkItem *workItem3 =[[WorkItem alloc]init];
                    NSString *c=[arr objectAtIndex:2];
                    workItem3.id=c;
                    WorkItem *workItem4 =[[WorkItem alloc]init];
                    NSString *d=[arr objectAtIndex:3];
                    workItem4.id=d;
                    WorkItem *workItem5 =[[WorkItem alloc]init];
                    NSString *e=[arr objectAtIndex:4];
                    workItem5.id=e;
                    WorkItem *workItem6 =[[WorkItem alloc]init];
                    NSString *f=[arr objectAtIndex:5];
                    workItem6.id=f;
                    WorkItem *workItem7 =[[WorkItem alloc]init];
                    NSString *g=[arr objectAtIndex:6];
                    workItem7.id=g;
                    WorkItem *workItem8 =[[WorkItem alloc]init];
                    NSString *h=[arr objectAtIndex:7];
                    workItem8.id=h;
                    WorkItem *workItem9 =[[WorkItem alloc]init];
                    NSString *j=[arr objectAtIndex:8];
                    workItem9.id=j;
                    WorkItem *workItem10 =[[WorkItem alloc]init];
                    NSString *k=[arr objectAtIndex:9];
                    workItem10.id=k;
                    
                    NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2,workItem3,workItem4,workItem5,workItem6,workItem7,workItem8,workItem9,workItem10, nil];
                    gonggao.id_list = workItems;
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 10))]];
                    
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                         NSString *daima=[rootDic objectForKey:@"ecode"];
                         int intString = [daima intValue];
                         if (intString==4000)
                         {
                             [self showWithCustomView:@"服务器内部错误"];
                         }
                         if (intString==1000)
                         {
                             NSMutableArray *info=[[NSMutableArray array]init];
                             info=[rootDic objectForKey:@"info"];
                             _fakeData=info;
                             [tableview headerEndRefreshing];
                             [tableview reloadData];
                             
                         }
                         }
                     }];
                }
                [self.view addSubview:tableview];
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
                    __block ShiPinYaoPinViewController *bSelf=self;
                    [UIView animateWithDuration:0.25 animations:^{
                        bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                    }];
                    
                    [tableview footerEndRefreshing];
                    [self showWithCustomView:@"没有更多数据了哦，亲"];
                }
                if ([arr count]==1)
                {
                    fuwu *gonggao =[[fuwu alloc]init];
                    
                    WorkItem *workItem1 =[[WorkItem alloc]init];
                    NSString *a=[arr objectAtIndex:0];
                    workItem1.id =a;
                    
                    workItemss = [[NSArray alloc] initWithObjects:workItem1, nil];
                    [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 1))]];
                    gonggao.id_list = workItemss;
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    NSLog(@"加载更多转换后的json串 %@", str1);
                    
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02                                              Paramters:Str
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
                         
                         for (int i=0;i<[info count];i++ )
                         {
                             NSString *stringInt;
                             stringInt=[info objectAtIndex:i];
                             [_fakeData addObject:stringInt];
                             [tableview reloadData];
                         }
                         }
                     }];
                    
                }
                
                if ([arr count]==2)
                {
                    fuwu *gonggao =[[fuwu alloc]init];
                    
                    WorkItem *workItem1 =[[WorkItem alloc]init];
                    NSString *a=[arr objectAtIndex:0];
                    workItem1.id =a;
                    WorkItem *workItem2 =[[WorkItem alloc]init];
                    NSString *b=[arr objectAtIndex:1];
                    workItem2.id =b;
                    
                    workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
                    [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 2))]];
                    gonggao.id_list = workItemss;
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    NSLog(@"加载更多转换后的json串 %@", str1);
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02                                              Paramters:Str
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
                         
                         for (int i=0;i<[info count];i++ )
                         {
                             NSString *stringInt;
                             stringInt=[info objectAtIndex:i];
                             [_fakeData addObject:stringInt];
                        }
                             [tableview footerEndRefreshing];
                             [tableview reloadData];

                         }
                     }];
                    
                }
                
                if ([arr count]==3)
                {
                    fuwu *gonggao =[[fuwu alloc]init];
                    
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
                    gonggao.id_list = workItemss;
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02                                              Paramters:Str
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
                         
                         for (int i=0;i<[info count];i++ )
                         {
                             NSString *stringInt;
                             stringInt=[info objectAtIndex:i];
                             [_fakeData addObject:stringInt];
                         }
                             [tableview footerEndRefreshing];
                             [tableview reloadData];
                         }
                     }];
                    
                }
                
                if ([arr count]==4)
                {
                    fuwu *gonggao =[[fuwu alloc]init];
                    
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
                    gonggao.id_list = workItemss;
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02                                              Paramters:Str
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
                         
                         for (int i=0;i<[info count];i++ )
                         {
                             NSString *stringInt;
                             stringInt=[info objectAtIndex:i];
                             [_fakeData addObject:stringInt];
                         }
                             [tableview footerEndRefreshing];
                             [tableview reloadData];
                         }
                         
                     }];
                    
                }
                
                if ([arr count]>=5)
                {
                    fuwu *gonggao =[[fuwu alloc]init];
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
                    gonggao.id_list = workItemss;
                    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02                                              Paramters:Str
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
                         
                         for (int i=0;i<[info count];i++ )
                         {
                             NSString *stringInt;
                             stringInt=[info objectAtIndex:i];
                             [_fakeData addObject:stringInt];
                         }
                             [tableview footerEndRefreshing];
                             [tableview reloadData];
                         }
                     }];
                    
                }
            }
            
    }
    @catch (NSException * e)
    {
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
- (void)showWithCustomView:(NSString*)aString
{
    
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
    @try
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

        label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
        label.text=@"食品药品";
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [self.view addSubview:label];
        button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
        [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth-60)];
        tableview.dataSource=self;
        tableview.delegate=self;
        [self.view addSubview:tableview];
        [tableview addHeaderWithTarget:self action:@selector(dataInit)];
        [tableview addFooterWithTarget:self action:@selector(addData)];
        [tableview headerBeginRefreshing];

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

-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MJTableViewCellIdentifier forIndexPath:indexPath];
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
    
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(10, 3, 300, 20)];
    name.text=[_fakeData[indexPath.row] objectForKey:@"title"];
    name.font=[UIFont systemFontOfSize:14];
    [cell addSubview:name];
    
    UILabel *publish_time=[[UILabel alloc]initWithFrame:CGRectMake(200, 30, 120, 20)];
    publish_time.text=[_fakeData[indexPath.row] objectForKey:@"article_date"];
    publish_time.font=[UIFont systemFontOfSize:12];
    publish_time.textColor=[UIColor grayColor];
    [cell addSubview:publish_time];
    
    
    UILabel *publish_department=[[UILabel alloc]initWithFrame:CGRectMake(15, 30, 185, 20)];
    publish_department.text=[_fakeData[indexPath.row] objectForKey:@"article_source"];
    publish_department.font=[UIFont systemFontOfSize:12];
    publish_department.textColor=[UIColor grayColor];
    [cell addSubview:publish_department];
    labelline=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
    labelline.backgroundColor=[UIColor grayColor];
    [cell addSubview:labelline];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShiPinYaoPin_Dictionary=_fakeData[indexPath.row];
    ShiPinYaoPinXiangQingViewController *xiangqing=[[ShiPinYaoPinXiangQingViewController alloc]init];
    [self presentViewController:xiangqing animated:NO completion:nil];
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fakeData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
