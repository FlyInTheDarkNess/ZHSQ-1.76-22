//
//  WoDeViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-30.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "WoDeViewController.h"
#import "CheckNetwork.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "LaiWupindaoViewController.h"
#import "ShanDongweishiViewController.h"
#import "YangShiViewController.h"
#import "URL.h"
#import "JiaMiJieMi.h"
extern NSString *pindaoID;
@interface WoDeViewController ()

@end

@implementation WoDeViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView
{
    @try
    {
 
    [super loadView];
    if([CheckNetwork isExistenceNetwork]==1)
    {
               
        arr=[[NSMutableArray alloc]init];
        NSString *str1=@"{\"channel_kind\":\"6\"}";
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];

        [HttpPostExecutor postExecuteWithUrlStr:ShouShiZhiNan_m8_02 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
           // NSLog(@"第一次: %@", result);//result就是NSString类型的返回值
            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
            // NSLog(@"第一次: 解析%@", rootDic);
            
            arr=[rootDic objectForKey:@"channel"];
            [view_LaiWu addSubview:tableview_laiwu];

            arr2=[[NSMutableArray alloc]init];
            NSString *str11=@"{\"channel_kind\":\"0\"}";
            NSString *str_jiami1=[JiaMiJieMi hexStringFromString:str11];
            NSString *str21=@"para=";
            NSString *Str0;
            Str0=[str21 stringByAppendingString:str_jiami1];

            [HttpPostExecutor postExecuteWithUrlStr:ShouShiZhiNan_m8_02 Paramters:Str0 FinishCallbackBlock:^(NSString *result){
                // 执行post请求完成后的逻辑
               // NSLog(@"第2次: %@", result);//result就是NSString类型的返回值
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                // NSLog(@"***********\n第2次: %@", str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                // NSLog(@"第一次: 解析%@", rootDic);
                
                arr2=[rootDic objectForKey:@"channel"];
                [view_YangShi addSubview:tableview_yangshi];
            }];

            
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

- (void)viewDidLoad
{
    @try
    {

    [super viewDidLoad];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    
    self.view.backgroundColor=[UIColor whiteColor];
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];
// Do any additional setup after loading the view from its nib.
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.text=@"收视指南";
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:18];label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    LaiWuBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 65, 107, 30)];
    [LaiWuBtn setTitle:@"莱芜频道" forState:UIControlStateNormal];
    [LaiWuBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [LaiWuBtn addTarget:self action:@selector(laiwupindao) forControlEvents:UIControlEventTouchUpInside];
    LaiWuBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:LaiWuBtn];
    
    ShanDongBtn=[[UIButton alloc]initWithFrame:CGRectMake(107, 65, 107, 30)];
    [ShanDongBtn setTitle:@"山东卫视" forState:UIControlStateNormal];
    [ShanDongBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ShanDongBtn addTarget:self action:@selector(shandongweishi) forControlEvents:UIControlEventTouchUpInside];
    ShanDongBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:ShanDongBtn];
    
    YangShiBtn=[[UIButton alloc]initWithFrame:CGRectMake(214, 65, 107, 30)];
    [YangShiBtn setTitle:@"央视频道" forState:UIControlStateNormal];
    [YangShiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [YangShiBtn addTarget:self action:@selector(yangshipindao) forControlEvents:UIControlEventTouchUpInside];
    YangShiBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:YangShiBtn];
    view_YangShi=[[UIView alloc]initWithFrame:CGRectMake(0, 97, 320, Hidth-97)];
    view_YangShi.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_YangShi];
    tableview_yangshi=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Hidth-97)];
    tableview_yangshi.dataSource=self;
    tableview_yangshi.delegate=self;
    

    view_ShanDong=[[UIView alloc]initWithFrame:CGRectMake(0, 97, 320, Hidth-97)];
    view_ShanDong.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_ShanDong];
    tableview_shandong=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Hidth-97)];
    tableview_shandong.dataSource=self;
    tableview_shandong.delegate=self;
   

    
    view_LaiWu=[[UIView alloc]initWithFrame:CGRectMake(0, 97, 320, Hidth-97)];
    view_LaiWu.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view_LaiWu];
    tableview_laiwu=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Hidth-97)];
    tableview_laiwu.dataSource=self;
    tableview_laiwu.delegate=self;
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 96, 320, 1)];
    label.backgroundColor=[UIColor grayColor];
    [self.view addSubview:label];
    
    //[self loadView];
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

-(void)laiwupindao
{
    [LaiWuBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [ShanDongBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [YangShiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view_LaiWu removeFromSuperview];
    [self.view addSubview:view_LaiWu];
   
}
-(void)shandongweishi
{
    [LaiWuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ShanDongBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [YangShiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view_ShanDong removeFromSuperview];
    [self.view addSubview:view_ShanDong];
     [view_ShanDong addSubview:tableview_shandong];

}
-(void)yangshipindao
{
    [LaiWuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ShanDongBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [YangShiBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [view_YangShi removeFromSuperview];
    [self.view addSubview:view_YangShi];
    

}
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    [tableview_laiwu setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview_shandong setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview_yangshi setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
    labela.backgroundColor=[UIColor grayColor];
    [cell addSubview:labela];
    UILabel *labelb=[[UILabel alloc]init];
    if ([tableView isEqual:tableview_laiwu])
    {
        labelb.frame=CGRectMake(80, 5, 280, 30);
        labelb.text= [arr[indexPath.row] objectForKey:@"channel_name"];
        UIImageView *imagea=[[UIImageView alloc]init];
        imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 60,20)];
        imagea.tag = 1000;
        imagea.userInteractionEnabled=NO;
        
        imagea.hidden = NO;
        [imagea setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arr[indexPath.row] objectForKey:@"channel_icon"]]] placeholderImage:[UIImage imageNamed:@"tx2"] options:SDWebImageProgressiveDownload];
        [cell.contentView addSubview:imagea];

    }
    else if ([tableView isEqual:tableview_yangshi])
    {
       
        labelb.frame=CGRectMake(60, 5, 280, 30);
        labelb.text= [arr2[indexPath.row] objectForKey:@"channel_name"];
        UIImageView *imagea=[[UIImageView alloc]init];
        imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 40,20)];
        imagea.tag = 1000;
        imagea.userInteractionEnabled=NO;
        
        imagea.hidden = NO;
        [imagea setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[arr2[indexPath.row] objectForKey:@"channel_icon"]]] placeholderImage:[UIImage imageNamed:@"tx2"] options:SDWebImageProgressiveDownload];
        [cell.contentView addSubview:imagea];

    }
    else
    {
        
        labelb.frame=CGRectMake(45, 5, 280, 30);
        labelb.text=@"山东卫视";
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://p1.img.cctvpic.com/tv/images/logo/shandong.gif"]]];
        UIImageView *imageview2=[[UIImageView alloc]initWithImage:img];
        imageview2.frame=CGRectMake(5, 10, 30, 20);
        imageview2.backgroundColor=[UIColor whiteColor];
        [cell.contentView addSubview:imageview2];
        
    
    }
    
   
    
    
    [cell addSubview:labelb];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tableview_laiwu])
    {
        
        return arr.count;
    }
    else if ([tableView isEqual:tableview_yangshi])
    {
        return arr2.count;
    }
    else
    {
        return 1;
    }
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tableview_laiwu])
    {
        pindaoID=[arr[indexPath.row] objectForKey:@"channel_id"];
        NSLog(@"pindaoID:%@",pindaoID);
        LaiWupindaoViewController *lai=[[LaiWupindaoViewController alloc]init];
        [self presentViewController:lai animated:NO completion:nil];
    }
    else if ([tableView isEqual:tableview_yangshi])
    {
        pindaoID=[arr2[indexPath.row] objectForKey:@"channel_id"];

        YangShiViewController *lai=[[YangShiViewController alloc]init];
        [self presentViewController:lai animated:NO completion:nil];
    }
    else
    {
        pindaoID=@"shandong";

        ShanDongweishiViewController *lai=[[ShanDongweishiViewController alloc]init];
        [self presentViewController:lai animated:NO completion:nil];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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

@end
