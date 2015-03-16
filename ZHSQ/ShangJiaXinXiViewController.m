
//
//  ShangJiaXinXiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ShangJiaXinXiViewController.h"
#import "FuWwYingYongViewController.h"
#import "UIScrollView+MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "fuwu.h"
#import "CheckNetwork.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UIImageView+WebCache.h"

#import "shouyeViewController.h"
#import "ShangJiaPingJiaViewController.h"
#import "ShangJiaDiTuDingWeiViewController.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "AXHButton.h"
//extern NSDictionary *SJXXdtDictionary;
extern NSDictionary *FUWUdtDictionary;
extern NSString *UserName;
extern NSString *Session;

@interface ShangJiaXinXiViewController ()
{
    NSMutableArray *_fakeData;
    NSMutableArray *shuzu;
}

@end

@implementation ShangJiaXinXiViewController

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
    
    _fakeData = [NSMutableArray array];
    
    
    
    
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
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth-96)];
    mytableview.dataSource=self;
    mytableview.delegate=self;
    
    [mytableview addHeaderWithTarget:self action:@selector(dataInit)];
    [mytableview addFooterWithTarget:self action:@selector(addData)];
    [mytableview headerBeginRefreshing];
    [self.view addSubview:mytableview];
    
    
}
-(void)dataInit
{
    @try
    {
        
        if([CheckNetwork isExistenceNetwork]==1)
        {
            
            fuwu *customer =[[fuwu alloc]init];
            WorkItem *workItem6 =[[WorkItem alloc]init];
            NSString *f=[FUWUdtDictionary objectForKey:@"store_id"];
            workItem6.id =f;
            
            NSArray *workItems = [[NSArray alloc] initWithObjects:workItem6, nil];
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
                     NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                     // NSLog(@"第二次:sssssssssss %@", str_jiemi);
                     SBJsonParser *parser=[[SBJsonParser alloc]init];
                     NSError *error=nil;
                     NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                     NSString *daima=[rootDic objectForKey:@"ecode"];
                     int intString = [daima intValue];
                     if (intString==1000)
                     {
                         NSDictionary *dic=[rootDic objectForKey:@"wufu_info"][0];

                         
                         
                         NSMutableArray *arry=[[NSMutableArray alloc]initWithArray:[dic objectForKey:@"fb_id_list"]];
                         shuzu=[[NSMutableArray alloc]init];
                         
                         for (int i=[arry count]-1; i>-1; i--)
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
                             __block ShangJiaXinXiViewController *bSelf=self;
                             [UIView animateWithDuration:0.25 animations:^{
                                 bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                             }];
                             
                             [mytableview headerEndRefreshing];
                             
                             //修改人 赵忠良 修改评论没有的错误提示
                             /*
                             [self showWithCustomView:@"服务器中暂未储存数据了哦，亲"];
                              */
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
        
        if([CheckNetwork isExistenceNetwork]==1)
        {
            
            // 增加5条假数据
            if ([shuzu count]==0)
            {
                [self.view endEditing:YES];
                __block ShangJiaXinXiViewController *bSelf=self;
                [UIView animateWithDuration:0.25 animations:^{
                    bSelf.view.center = CGPointMake(160, self.view.frame.size.height/2.0);
                }];
                
                [mytableview footerEndRefreshing];
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
                         [mytableview footerEndRefreshing];
                         
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
                         [mytableview footerEndRefreshing];
                         
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
                         [mytableview footerEndRefreshing];
                         
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
                         [mytableview footerEndRefreshing];
                         
                         [mytableview reloadData];
                     }
                     
                 }];
                
            }
            
            if ([shuzu count]>=5)
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
                         [mytableview footerEndRefreshing];
                         
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

//指定有多少个分区(Section)，默认为1

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_fakeData.count>0)
    {
        return 2;
    }
    else
    {
        return 1;
    }//返回标题数组中元素的个数来确定分区的个数
    
}
//指定每个分区中有多少行，默认为1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
            
            return  1;
            break;
            
        case 1:
            
            return  _fakeData.count;
            
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_fakeData.count<=0)
    {
        NSLog(@"kong");
        
        label_biaoti=[[UILabel alloc]initWithFrame:CGRectMake(10,10, 230, 40)];
        label_biaoti.text=[FUWUdtDictionary objectForKey:@"store_name"];
        label_biaoti.font=[UIFont systemFontOfSize:18];
        [cell.contentView addSubview:label_biaoti];
        dingwei=[[UIButton alloc]initWithFrame:CGRectMake(280, 15, 25, 40)];
        [dingwei setImage:[UIImage imageNamed:@"icon_marka.png"] forState:UIControlStateNormal];
        [dingwei addTarget:self action:@selector(jingweidudingwei) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:dingwei];
        label_jibie=[[UILabel alloc]initWithFrame:CGRectMake(10,50, 80, 20)];
        label_jibie.text=@"推荐级别：";
        label_jibie.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label_jibie];
        NSString *str_a=[FUWUdtDictionary objectForKey:@"star_level"];
        float floatString = [str_a floatValue];
        int a=round(floatString);
        if (a==0)
        {
            for (int k=0; k<5; k++)
            {
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
        }
        if (a==1)
        {
            UIImageView *imagevie=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
            imagevie.frame=CGRectMake(80, 52, 15, 15);
            [cell.contentView addSubview:imagevie];
            for (int k=1; k<5; k++)
            {
                
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
        }
        
        if (a==2)
        {
            for (int j=0; j<2; j++)
            {
                
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
            for (int k=2; k<5; k++)
            {
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
        }
        if (a==3)
        {
            for (int j=0; j<3; j++)
            {
                
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
            for (int k=3; k<5; k++)
            {
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
        }
        if (a==4)
        {
            for (int j=0; j<4; j++)
            {
                
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
            for (int k=4; k<5; k++)
            {
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
        }
        
        if (a==5)
        {
            for (int j=0; j<5; j++)
            {
                
                UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
                [cell.contentView addSubview:imageview];
            }
            
        }
        
        label_dizhi=[[UILabel alloc]initWithFrame:CGRectMake(10,80, 260, 20)];
        NSString *str1=[FUWUdtDictionary objectForKey:@"store_address"];
        label_dizhi.text=[NSString stringWithFormat:@"地址：%@", str1];
        label_dizhi.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label_dizhi];
        label_dianhua1=[[UILabel alloc]initWithFrame:CGRectMake(10, 110, 40, 20)];
        label_dianhua1.text=@"电话:";
        label_dianhua1.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label_dianhua1];
        
        label_dianhua2=[[UILabel alloc]initWithFrame:CGRectMake(50, 110, 180, 20)];
        label_dianhua2.text=[FUWUdtDictionary objectForKey:@"phone"];
        label_dianhua2.textColor=[UIColor greenColor];
        label_dianhua2.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label_dianhua2];
        
        UIButton *tel_btn=[[UIButton alloc]initWithFrame:CGRectMake(50, 110, 180, 20)];
        tel_btn.backgroundColor=[UIColor clearColor];
        [tel_btn addTarget:self action:@selector(Callup:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:tel_btn];
       
        
        label_dianjiaxiangxi=[[UILabel alloc]initWithFrame:CGRectMake(10, 140, 150, 20)];
        label_dianjiaxiangxi.text=@"店家详细:";
        [cell.contentView addSubview:label_dianjiaxiangxi];
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
        [cell.contentView addSubview:testlable];
        label_zhuyingxiangmu=[[UILabel alloc]initWithFrame:CGRectMake(10,actualsize.height+180, 160, 20)];
        label_zhuyingxiangmu.text=@"主要经营项目：";
        [cell.contentView addSubview:label_zhuyingxiangmu];
        NSArray *arr_goods=[[NSArray alloc]initWithArray:[FUWUdtDictionary objectForKey:@"goods"]];
        for (int i=0;i<[arr_goods count]; i++)
        {
            NSString *string=[[arr_goods objectAtIndex:i] objectForKey:@"image_url"];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
            UIImageView *imageview2=[[UIImageView alloc]initWithImage:img];
            imageview2.frame=CGRectMake(5, actualsize.height+210+41*i, 40, 40);
            imageview2.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:imageview2];
            UILabel *label_chanpin=[[UILabel alloc]initWithFrame:CGRectMake(45, actualsize.height+210+41*i, 265, 40)];
            NSString *str=[[arr_goods objectAtIndex:i] objectForKey:@"goods_name"];
            label_chanpin.text=[NSString stringWithFormat:@"  %@", str];
            label_chanpin.backgroundColor=[UIColor whiteColor];
            label_chanpin.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label_chanpin];
            
        }
        arr_pinglun=[[NSArray alloc]initWithArray:[FUWUdtDictionary objectForKey:@"fb_id_list"]];
        int strb=[arr_pinglun count];
        label_pinglun=[[UILabel alloc]initWithFrame:CGRectMake(10, actualsize.height+210+41*[arr_goods count], 300, 20)];
        label_pinglun.text=[NSString stringWithFormat:@"反馈评论：%d条", strb];
        label_pinglun.font=[UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label_pinglun];
        CGRect cellFrame = [cell frame];
        cellFrame.size.height =actualsize.height+210+41*[arr_goods count];
        [cell setFrame:cellFrame];
    }
    else
    {
        if (indexPath.section==0)
        {
            
            label_biaoti=[[UILabel alloc]initWithFrame:CGRectMake(10,10, 230, 40)];
            label_biaoti.text=[FUWUdtDictionary objectForKey:@"store_name"];
            label_biaoti.font=[UIFont systemFontOfSize:18];
            [cell.contentView addSubview:label_biaoti];
            dingwei=[[UIButton alloc]initWithFrame:CGRectMake(280, 15, 25, 40)];
            [dingwei setImage:[UIImage imageNamed:@"icon_marka.png"] forState:UIControlStateNormal];
            [dingwei addTarget:self action:@selector(jingweidudingwei) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:dingwei];
            label_jibie=[[UILabel alloc]initWithFrame:CGRectMake(10,50, 80, 20)];
            label_jibie.text=@"推荐级别：";
            label_jibie.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label_jibie];
            NSString *str_a=[FUWUdtDictionary objectForKey:@"star_level"];
            float floatString = [str_a floatValue];
            int a=round(floatString);
            if (a==0)
            {
                for (int k=0; k<5; k++)
                {
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
            }
            if (a==1)
            {
                UIImageView *imagevie=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                imagevie.frame=CGRectMake(80, 52, 15, 15);
                [cell.contentView addSubview:imagevie];
                for (int k=1; k<5; k++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
            }
            
            if (a==2)
            {
                for (int j=0; j<2; j++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                    imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
                for (int k=2; k<5; k++)
                {
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
            }
            if (a==3)
            {
                for (int j=0; j<3; j++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                    imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
                for (int k=3; k<5; k++)
                {
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
            }
            if (a==4)
            {
                for (int j=0; j<4; j++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                    imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
                for (int k=4; k<5; k++)
                {
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(80+15*k, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
            }
            
            if (a==5)
            {
                for (int j=0; j<5; j++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                    imageview.frame=CGRectMake(80+15*j, 52, 15, 15);
                    [cell.contentView addSubview:imageview];
                }
                
            }
            
            label_dizhi=[[UILabel alloc]initWithFrame:CGRectMake(10,80, 260, 20)];
            NSString *str1=[FUWUdtDictionary objectForKey:@"store_address"];
            label_dizhi.text=[NSString stringWithFormat:@"地址：%@", str1];
            label_dizhi.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label_dizhi];
            label_dianhua1=[[UILabel alloc]initWithFrame:CGRectMake(10, 110, 40, 20)];
            label_dianhua1.text=@"电话:";
            label_dianhua1.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label_dianhua1];
            label_dianhua2=[[UILabel alloc]initWithFrame:CGRectMake(50, 110, 180, 20)];
            label_dianhua2.text=[FUWUdtDictionary objectForKey:@"phone"];
            label_dianhua2.textColor=[UIColor blueColor];
            label_dianhua2.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label_dianhua2];
            
            AXHButton *tel_btn=[[AXHButton alloc]initWithFrame:CGRectMake(50, 110, 180, 20)];
            tel_btn.backgroundColor=[UIColor clearColor];
            [tel_btn addTarget:self action:@selector(Callup:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:tel_btn];

            label_dianjiaxiangxi=[[UILabel alloc]initWithFrame:CGRectMake(10, 140, 150, 20)];
            label_dianjiaxiangxi.text=@"店家详细:";
            [cell.contentView addSubview:label_dianjiaxiangxi];
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
            [cell.contentView addSubview:testlable];
            label_zhuyingxiangmu=[[UILabel alloc]initWithFrame:CGRectMake(10,actualsize.height+180, 160, 20)];
            label_zhuyingxiangmu.text=@"主要经营项目：";
            [cell.contentView addSubview:label_zhuyingxiangmu];
            NSArray *arr_goods=[[NSArray alloc]initWithArray:[FUWUdtDictionary objectForKey:@"goods"]];
            for (int i=0;i<[arr_goods count]; i++)
            {
                NSString *string=[[arr_goods objectAtIndex:i] objectForKey:@"image_url"];
                UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:string]]];
                UIImageView *imageview2=[[UIImageView alloc]initWithImage:img];
                imageview2.frame=CGRectMake(5, actualsize.height+210+41*i, 40, 40);
                imageview2.backgroundColor=[UIColor whiteColor];
                [cell.contentView addSubview:imageview2];
                UILabel *label_chanpin=[[UILabel alloc]initWithFrame:CGRectMake(45, actualsize.height+210+41*i, 265, 40)];
                NSString *str=[[arr_goods objectAtIndex:i] objectForKey:@"goods_name"];
                label_chanpin.text=[NSString stringWithFormat:@"  %@", str];
                label_chanpin.backgroundColor=[UIColor whiteColor];
                label_chanpin.font=[UIFont systemFontOfSize:14];
                [cell.contentView addSubview:label_chanpin];
                
            }
            arr_pinglun=[[NSArray alloc]initWithArray:[FUWUdtDictionary objectForKey:@"fb_id_list"]];
            int strb=[arr_pinglun count];
            label_pinglun=[[UILabel alloc]initWithFrame:CGRectMake(10, actualsize.height+210+41*[arr_goods count], 300, 20)];
            label_pinglun.text=[NSString stringWithFormat:@"反馈评论：%d条", strb];
            label_pinglun.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label_pinglun];
            CGRect cellFrame = [cell frame];
            cellFrame.size.height =actualsize.height+210+41*[arr_goods count];
            [cell setFrame:cellFrame];
            
            
        }
        if (indexPath.section==1)
        {
            NSString *image_url=[[_fakeData[indexPath.row] objectForKey:@"person_info"][0] objectForKey:@"icon_path"];
            UIImageView *imagea=[[UIImageView alloc]init];
            imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 40,40)];
            imagea.tag = 1000;
            imagea.layer.cornerRadius = 20;
            imagea.layer.masksToBounds = YES;
            imagea.layer.borderColor = [UIColor redColor].CGColor;
            imagea.layer.borderWidth = 1;
            imagea.userInteractionEnabled = YES;

            imagea.userInteractionEnabled=NO;
            if (image_url.length>0)
            {
                [imagea setImageWithURL:[NSURL URLWithString:image_url]
                       placeholderImage:[UIImage imageNamed:@"xiaoqufuwu1"]
                                options:SDWebImageRetryFailed
            usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            }
            else
            {
                imagea.image=[UIImage imageNamed:@"m_personcenter.png"];
            }
            
            [cell.contentView addSubview:imagea];
            UILabel *nicheng_label=[[UILabel alloc]initWithFrame:CGRectMake(50, 1, 260, 20)];
            nicheng_label.text=[NSString stringWithFormat:@"%@",[[_fakeData[indexPath.row] objectForKey:@"person_info"][0] objectForKey:@"nickname"]];
            nicheng_label.font=[UIFont systemFontOfSize:14];
            nicheng_label.textColor=[UIColor redColor];
            [cell addSubview:nicheng_label];

        
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 1, 320, 1)];
            label.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.7];
            [cell addSubview:label];
            UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(50, 20, 260, 20)];
            labela.text=[NSString stringWithFormat:@"%@",[_fakeData[indexPath.row] objectForKey:@"feedback_time"]];
            labela.font=[UIFont systemFontOfSize:12];
            [cell addSubview:labela];
            UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(50, 40, 260, 20)];
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
                    imageview.frame=CGRectMake(240+15*k, 23, 15, 15);
                    [cell addSubview:imageview];
                }
            }
            if (a==1)
            {
                UIImageView *imagevie=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                imagevie.frame=CGRectMake(240, 23, 15, 15);
                [cell addSubview:imagevie];
                for (int k=1; k<5; k++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(240+15*k, 23, 15, 15);
                    [cell addSubview:imageview];
                }
            }
            
            if (a==2)
            {
                for (int j=0; j<2; j++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                    imageview.frame=CGRectMake(240+15*j, 23, 15, 15);
                    [cell addSubview:imageview];
                }
                for (int k=2; k<5; k++)
                {
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(240+15*k, 23, 15, 15);
                    [cell addSubview:imageview];
                }
            }
            if (a==3)
            {
                for (int j=0; j<3; j++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                    imageview.frame=CGRectMake(240+15*j, 23, 15, 15);
                    [cell addSubview:imageview];
                }
                for (int k=3; k<5; k++)
                {
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(240+15*k, 23, 15, 15);
                    [cell addSubview:imageview];
                }
            }
            if (a==4)
            {
                for (int j=0; j<4; j++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                    imageview.frame=CGRectMake(240+15*j, 23, 15, 15);
                    [cell addSubview:imageview];
                }
                for (int k=4; k<5; k++)
                {
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing01.png"]];
                    imageview.frame=CGRectMake(240+15*k, 23, 15, 15);
                    [cell addSubview:imageview];
                }
            }
            
            if (a==5)
            {
                for (int j=0; j<5; j++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xingxing02.png"]];
                    imageview.frame=CGRectMake(240+15*j, 23, 15, 15);
                    [cell addSubview:imageview];
                }
                
            }
            
            CGRect cellFrame = [cell frame];
            cellFrame.size.height =68+g;
            [cell setFrame:cellFrame];
            
        }

    }
    
    
    return cell;
}
-(void)Callup:(AXHButton *)btn
{
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",[FUWUdtDictionary objectForKey:@"phone"]];       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号

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
-(void)jingweidudingwei
{
    ShangJiaDiTuDingWeiViewController *ding=[[ShangJiaDiTuDingWeiViewController alloc]init];
    [self presentViewController:ding animated:NO completion:nil];

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
    //修改人 赵忠良
    [self.navigationController popViewControllerAnimated:YES];
    //[self dismissViewControllerAnimated:NO completion:nil];
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
