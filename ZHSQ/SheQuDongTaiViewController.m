//
//  SheQuDongTaiViewController.m
//  ZHSQ
//
//  Created by lacom on 14-6-17.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "SheQuDongTaiViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "SheQuDongTaiXiangQingViewController.h"
#import "CheckNetwork.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"

#import "URL.h"
#import "JiaMiJieMi.h"
NSString *const SQDTTableViewCellIdentifier = @"Cell";
extern NSDictionary *SQdtDictionary;

@interface SheQuDongTaiViewController ()
{
    NSMutableArray *_fakeData;
}

@end

@implementation SheQuDongTaiViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    self.view.backgroundColor=[UIColor whiteColor];

    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.text=@"小区头条";
    label.font=[UIFont systemFontOfSize:18];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label];
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, Width, Hidth-55)];
    tableview.dataSource=self;
    tableview.delegate=self;
    [self.view addSubview:tableview];

    tableview.backgroundColor=[UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    
    [tableview addHeaderWithTarget:self action:@selector(dataInit)];
    [tableview addFooterWithTarget:self action:@selector(addData)];
    [tableview headerBeginRefreshing];

    _fakeData = [NSMutableArray array];
   
}
-(void)dataInit
{
    @try
    {
        
        
        if([CheckNetwork isExistenceNetwork]==1)
        {
            arr=[[NSMutableArray alloc]init];
            NSString *str1=@"{\"city_id\":\"101\",\"community_id\":\"102\"}";
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            
            [HttpPostExecutor postExecuteWithUrlStr:SheQuDongTai_m7_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
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
                    // NSLog(@"第一次: 解析%@", rootDic);
                    
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
                    // NSLog(@"第一次: arrrrrr=%@", arr);
                    
                    
                    if ([arr count]==0)
                    {
                        
                        [self.view endEditing:YES];
                        __block SheQuDongTaiViewController *bSelf=self;
                        [UIView animateWithDuration:0.25 animations:^{
                            bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                        }];
                        [self showWithCustomView:@"没有更多数据了!"];
                    }
                    if ([arr count]<10)
                    {
                        SQDT *customer =[[SQDT alloc]init];
                        customer.city_id =@"101";
                        customer.community_id =@"102";
                        NSArray *workItems = [[NSArray alloc]initWithArray:shuzu];
                        customer.id_list = workItems;
                        
                        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                        // NSLog(@"=======%@",str1);
                        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                        NSString *str2=@"para=";
                        NSString *Str;
                        Str=[str2 stringByAppendingString:str_jiami];
                        [HttpPostExecutor postExecuteWithUrlStr:SheQuDongTai_m7_02                                          Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                                 if (intString==1000)
                                 {
                                     NSMutableArray *info=[[NSMutableArray array]init];
                                     info=[rootDic objectForKey:@"news_info"];
                                     
                                     // 2.初始化假数据
                                     _fakeData = [NSMutableArray array];
                                     _fakeData=info;
                                     [tableview headerEndRefreshing];
                                     [tableview reloadData];
                                     
                                     
                                 }
                                 if (intString==4000)
                                 {
                                     [self showWithCustomView:@"服务器内部错误"];
                                 }
                             }
                         }];
                        
                    }
                    
                    if ([arr count]>=10)
                    {
                        SQDT *customer =[[SQDT alloc]init];
                        customer.city_id =@"101";
                        customer.community_id =@"102";
                        
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
                        customer.id_list = workItems;
                        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                        [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 10))]];
                        
                        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                        NSString *str2=@"para=";
                        NSString *Str;
                        Str=[str2 stringByAppendingString:str_jiami];
                        [HttpPostExecutor postExecuteWithUrlStr:SheQuDongTai_m7_02 Paramters:Str FinishCallbackBlock:^(NSString *result)
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
                                 if (intString==1000)
                                 {
                                     NSMutableArray *info=[[NSMutableArray array]init];
                                     info=[rootDic objectForKey:@"news_info"];
                                     
                                     // 2.初始化假数据
                                     _fakeData = [NSMutableArray array];
                                     _fakeData=info;
                                     [tableview headerEndRefreshing];
                                     [tableview reloadData];
                                     
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
-(void)addData
{
    @try
    {
        
        // 增加5条数据
        if ([arr count]==0)
        {
            [self.view endEditing:YES];
            __block SheQuDongTaiViewController *bSelf=self;
            [UIView animateWithDuration:0.25 animations:^{
                bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
            }];
            [tableview footerEndRefreshing];

            [self showWithCustomView:@"没有更多数据了哦，亲"];
        }
        if ([arr count]==1)
        {
            customers =[[SQDT alloc]init];
            customers.city_id =@"101";
            customers.community_id =@"102";
            
            WorkItem *workItem1 =[[WorkItem alloc]init];
            NSString *a=[arr objectAtIndex:0];
            workItem1.id =a;
            
            workItemss = [[NSArray alloc] initWithObjects:workItem1, nil];
            [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 1))]];
            customers.id_list = workItemss;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customers childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            //  NSLog(@"加载更多转换后的json串 %@", str1);
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            
            [HttpPostExecutor postExecuteWithUrlStr:SheQuDongTai_m7_02                                          Paramters:Str
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
                     info=[rootDic objectForKey:@"news_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                     [tableview reloadData];
                     [tableview footerEndRefreshing];
                 }
             }];
            
        }
        
        if ([arr count]==2)
        {
            customers =[[SQDT alloc]init];
            customers.city_id =@"101";
            customers.community_id =@"102";
            
            WorkItem *workItem1 =[[WorkItem alloc]init];
            NSString *a=[arr objectAtIndex:0];
            workItem1.id =a;
            WorkItem *workItem2 =[[WorkItem alloc]init];
            NSString *b=[arr objectAtIndex:1];
            workItem2.id =b;
            
            workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
            
            
            workItemss = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
            [arr removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, MIN(arr.count, 2))]];
            customers.id_list = workItemss;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customers childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            // NSLog(@"加载更多转换后的json串 %@", str1);
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            [HttpPostExecutor postExecuteWithUrlStr:SheQuDongTai_m7_02                                          Paramters:Str
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
                     info=[rootDic objectForKey:@"news_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                     [tableview reloadData];
                     [tableview footerEndRefreshing];

                 }
             }];
            
        }
        
        if ([arr count]==3)
        {
            customers =[[SQDT alloc]init];
            customers.city_id =@"101";
            customers.community_id =@"102";
            
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
            NSLog(@"加载更多转换后的json串 %@", str1);
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            [HttpPostExecutor postExecuteWithUrlStr:SheQuDongTai_m7_02                                          Paramters:Str
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
                     info=[rootDic objectForKey:@"news_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                     [tableview reloadData];
                     [tableview footerEndRefreshing];

                 }
             }];
            
        }
        
        if ([arr count]==4)
        {
            customers =[[SQDT alloc]init];
            customers.city_id =@"101";
            customers.community_id =@"102";
            
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
            NSLog(@"加载更多转换后的json串 %@", str1);
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            [HttpPostExecutor postExecuteWithUrlStr:SheQuDongTai_m7_02                                          Paramters:Str
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
                     info=[rootDic objectForKey:@"news_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                     }
                     [tableview reloadData];
                     [tableview footerEndRefreshing];

                 }
             }];
            
        }
        
        if ([arr count]>=5)
        {
            customers =[[SQDT alloc]init];
            customers.city_id =@"101";
            customers.community_id =@"102";
            
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
            // NSLog(@"加载更多转换后的json串 %@", str1);
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            [HttpPostExecutor postExecuteWithUrlStr:SheQuDongTai_m7_02                                          Paramters:Str
                                FinishCallbackBlock:^(NSString *result)
             {
                 // 执行post请求完成后的逻辑
                 //NSLog(@"第二次:sssssssssss %@", result);
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
                     info=[rootDic objectForKey:@"news_info"];
                     
                     for (int i=0;i<[info count];i++ )
                     {
                         NSString *stringInt;
                         stringInt=[info objectAtIndex:i];
                         [_fakeData addObject:stringInt];
                         [tableview reloadData];
                     }
                     [tableview reloadData];
                     [tableview footerEndRefreshing];

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
- (void)showWithCustomView:(NSString*)aString {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

#pragma mark - Your actions

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    NSArray *imagelist=[[NSArray alloc]init];
    imagelist=[_fakeData[indexPath.row] objectForKey:@"pic"];
    NSDictionary *imzgedic=[[NSDictionary alloc]init];
    imzgedic=[imagelist objectAtIndex:0];
    NSString *image_url=[imzgedic objectForKey:@"thumbs_url"];
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]];
    if (data.length>0)
    {
        UIImageView *imagea=[[UIImageView alloc]init];
        imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 1, 65,58)];
        imagea.tag = 1000;
        imagea.userInteractionEnabled=NO;
        
        //imagea.hidden = NO;
        [imagea setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",image_url]]
               placeholderImage:[UIImage imageNamed:@"shequdongtai1"]
                        options:SDWebImageRetryFailed
    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
    [cell.contentView addSubview:imagea];
        
        
        
        UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(75, 0, 255, 20)];
        labela.text=[_fakeData[indexPath.row] objectForKey:@"title"];
        labela.backgroundColor=[UIColor whiteColor];
        labela.font=[UIFont systemFontOfSize:12];
        labela.textColor=[UIColor blackColor];
        [cell addSubview:labela];
        UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(78, 18, 252, 20)];
        labelb.text=[_fakeData[indexPath.row] objectForKey:@"summary"];
        labelb.backgroundColor=[UIColor whiteColor];
        labelb.font=[UIFont systemFontOfSize:12];
        labelb.textColor=[UIColor grayColor];
        [cell addSubview:labelb];
        UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(250, 39, 70, 20)];
        labelc.text=[_fakeData[indexPath.row] objectForKey:@"createdate"];
        labelc.backgroundColor=[UIColor whiteColor];
        labelc.font=[UIFont systemFontOfSize:12];
        labelc.textColor=[UIColor grayColor];
        [cell addSubview:labelc];
        UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(78, 39, 70, 20)];
        labeld.text=[_fakeData[indexPath.row] objectForKey:@"source"];
        labeld.backgroundColor=[UIColor whiteColor];
        labeld.font=[UIFont systemFontOfSize:12];
        labeld.textColor=[UIColor grayColor];
        [cell addSubview:labeld];
        

    }
    else
    {
        
    UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 20)];
    labela.text=[_fakeData[indexPath.row] objectForKey:@"title"];
    labela.backgroundColor=[UIColor whiteColor];
    labela.font=[UIFont systemFontOfSize:12];
    labela.textColor=[UIColor blackColor];
    [cell addSubview:labela];
    UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(8, 18, 252, 20)];
    labelb.text=[_fakeData[indexPath.row] objectForKey:@"summary"];
    labelb.backgroundColor=[UIColor whiteColor];
    labelb.font=[UIFont systemFontOfSize:12];
    labelb.textColor=[UIColor grayColor];
    [cell addSubview:labelb];
    UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(250, 39, 70, 20)];
    labelc.text=[_fakeData[indexPath.row] objectForKey:@"createdate"];
    labelc.backgroundColor=[UIColor whiteColor];
    labelc.font=[UIFont systemFontOfSize:12];
    labelc.textColor=[UIColor grayColor];
    [cell addSubview:labelc];
    UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(8, 39, 170, 20)];
    labeld.text=[_fakeData[indexPath.row] objectForKey:@"source"];
    labeld.backgroundColor=[UIColor whiteColor];
    labeld.font=[UIFont systemFontOfSize:12];
    labeld.textColor=[UIColor grayColor];
    [cell addSubview:labeld];

    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SQdtDictionary=[[NSDictionary alloc]init];
    SQdtDictionary=_fakeData[indexPath.row];
    SheQuDongTaiXiangQingViewController *xiangqing=[[SheQuDongTaiXiangQingViewController alloc]init];
    [self presentViewController:xiangqing animated:NO completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _fakeData.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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


@end
