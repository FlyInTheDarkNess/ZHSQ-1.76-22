//
//  YouHuiZiXunViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "YouHuiZiXunViewController.h"
#import "ShangJiaXinXiViewController.h"
#import "YouHuiShangJiaXiangXiXinXiViewController.h"
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

#import "URL.h"
#import "JiaMiJieMi.h"
#import "fuwu.h"
#import "UIScrollView+MJRefresh.h"
extern NSDictionary *YouHuiZiXunDic;
@interface YouHuiZiXunViewController ()

@end

@implementation YouHuiZiXunViewController

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

    image_beijing=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    image_beijing.backgroundColor=[UIColor colorWithRed:234/255.0 green:87/255.0 blue:83/255.0 alpha:1];
    [self.view addSubview:image_beijing];
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.text=@"优惠资讯";
    label_title.textColor=[UIColor whiteColor];
    label_title.textAlignment=NSTextAlignmentCenter;
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.backgroundColor=[UIColor clearColor];
    [self.view addSubview:label_title];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_fanhui];
     Array=[[NSMutableArray alloc]init];
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 70, Width, Hidth-70)];
    tableview.delegate=self;
    tableview.dataSource=self;
    [self.view addSubview:tableview];
    
    [tableview addHeaderWithTarget:self action:@selector(dataInit)];
    [tableview addFooterWithTarget:self action:@selector(addData)];
    [tableview headerBeginRefreshing];
   
    
    
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
- (void)dataInit
{
    @try
    {
        
        if([CheckNetwork isExistenceNetwork]==1)
        {
            
            NSString *str1=@"{\"session\":\"\",\"city_id\":\"101\",\"area_id\":\"\",\"agency_id\":\"\",\"community_id\":\"\",\"quarter_id\":\"\",\"article_type_id\":\"60\"}";
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
                    NSLog(@"第一次: %@", str_jiemi);
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
                    // NSLog(@"&&&&&&&&&&%@",arr);
                    if ([arr count]==0)
                    {
                        
                        [self.view endEditing:YES];
                        __block YouHuiZiXunViewController *bSelf=self;
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
                                     Array=info;
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
                                 NSLog(@"第二22次:sssssssssss %@", str_jiemi);
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
                                     
                                     Array=info;
                                     [tableview headerEndRefreshing];
                                     [tableview reloadData];
                                     
                                     
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
            
            if ([arr count]==0)
            {
                [self.view endEditing:YES];
                __block YouHuiZiXunViewController *bSelf=self;
                [UIView animateWithDuration:0.25 animations:^{
                    bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                }];
                
                
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
                             
                             // 2.初始化假数据
                             [Array addObjectsFromArray:info];
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
                             
                             // 2.初始化假数据
                             [Array addObjectsFromArray:info];
                             
                         }
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
                             
                             // 2.初始化假数据
                             [Array addObjectsFromArray:info];
                             
                         }
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
                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
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
                         
                         // 2.初始化假数据
                         [Array addObjectsFromArray:info];
                         
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
                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
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
                         
                         // 2.初始化假数据
                         [Array addObjectsFromArray:info];
                         
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
    
    NSArray *Array_image=[NSArray arrayWithArray:[Array[indexPath.row] objectForKey:@"pic"]];
    UIImageView *imagevie=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 65, 55)];

    if (Array_image.count>0)
    {
        [imagevie setImageWithURL:[NSURL URLWithString:[Array_image[0] objectForKey:@"pic_url"]]
                 placeholderImage:[UIImage imageNamed:@"shangjia1"]
                          options:SDWebImageRetryFailed
      usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.contentView addSubview:imagevie];

    }
    
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 245, 20)];
    title.text=[Array[indexPath.row] objectForKey:@"title"];
    title.textColor=[UIColor blackColor];
    title.font=[UIFont systemFontOfSize:15];
    [cell.contentView addSubview:title];
    UILabel *content=[[UILabel alloc]initWithFrame:CGRectMake(75, 25, 245, 20)];
    content.text=[Array[indexPath.row] objectForKey:@"content"];
    content.textColor=[UIColor grayColor];
    content.font=[UIFont systemFontOfSize:15];
    [cell.contentView addSubview:content];
    
    UILabel *ming=[[UILabel alloc]initWithFrame:CGRectMake(75, 45, 145, 20)];
    ming.text=[Array[indexPath.row] objectForKey:@"store_name"];
    ming.textColor=[UIColor grayColor];
    ming.font=[UIFont systemFontOfSize:13];
    [cell.contentView addSubview:ming];
    
    NSString *b=[[Array[indexPath.row] objectForKey:@"createdate"] substringWithRange:NSMakeRange(0,10)];
    UILabel *time=[[UILabel alloc]initWithFrame:CGRectMake(240, 45, 80, 20)];
    time.text=b;
    time.textColor=[UIColor grayColor];
    time.font=[UIFont systemFontOfSize:13];
    [cell.contentView addSubview:time];

    
    
    UILabel *xian=[[UILabel alloc]initWithFrame:CGRectMake(0, 64, 320, 1)];
    xian.backgroundColor=[UIColor blackColor];
    [cell.contentView addSubview:xian];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YouHuiZiXunDic=Array[indexPath.row];
    //NSLog(@"%@",YouHuiZiXunDic);
    YouHuiShangJiaXiangXiXinXiViewController *shangjia=[[YouHuiShangJiaXiangXiXinXiViewController alloc]init];
    [self presentViewController:shangjia animated:YES completion:nil];
    
//     NSString *str=[Array[indexPath.row] objectForKey:@"store_id"];
//    fuwu *customer =[[fuwu alloc]init];
//    
//    WorkItem *workItem2 =[[WorkItem alloc]init];
//    NSString *b=str;
//    workItem2.id=b;
//    NSArray *workItems = [[NSArray alloc] initWithObjects:workItem2, nil];
//    customer.id_list = workItems;
//    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
//    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str_jiami];
//    [HttpPostExecutor postExecuteWithUrlStr:SheQuFuWu_m3_03  Paramters:Str FinishCallbackBlock:^(NSString *result)
//     {
//         // 执行post请求完成后的逻辑
//         if (result.length<=0)
//         {
//             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//             [aler show];
//         }
//         else
//         {
//             NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
//             NSLog(@"第二次:sssssssssss %@", str_jiemi);
//             SBJsonParser *parser=[[SBJsonParser alloc]init];
//             NSError *error=nil;
//             YouHuiZiXunDic=[parser objectWithString:str_jiemi error:&error];
//             NSString *daima=[YouHuiZiXunDic objectForKey:@"ecode"];
//             int intString = [daima intValue];
//             if (intString==1000)
//             {
////                 YouHuiShangJiaXiangXiXinXiViewController *xiangqing=[[YouHuiShangJiaXiangXiXinXiViewController alloc]init];
////                 [self presentViewController:xiangqing animated:NO completion:nil];
//                 
//                 
//                 ShangJiaXinXiViewController *xiangqing=[[ShangJiaXinXiViewController alloc]init];
//                 [self presentViewController:xiangqing animated:NO completion:nil];
//                
//             }
//             if (intString==3007)
//             {
//             [self showWithCustomView:@"没有查找到数据"];
//             }
//             if (intString==4000)
//             {
//                 [self showWithCustomView:@"服务器内部错误"];
//             }
//         }
//     }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Array.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
    return 65;
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
