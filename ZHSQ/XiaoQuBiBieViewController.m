//
//  XiaoQuBiBieViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-9-18.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "XiaoQuBiBieViewController.h"
#import "denglu.h"
#import "MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "URL.h"
#import "JiaMiJieMi.h"
@interface XiaoQuBiBieViewController ()

@end

@implementation XiaoQuBiBieViewController

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
    // Do any additional setup after loading the view.
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度

    self.view.backgroundColor=[UIColor whiteColor];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"xiaoquID"];
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.text=@"便民电话";
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.textAlignment=NSTextAlignmentCenter;
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_fanhui];
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth-60)];
    mytableview.dataSource=self;
    mytableview.delegate=self;
    
    xiaoqubibei*customer =[[xiaoqubibei alloc]init];
    
    customer.quarter_id =myString;
    
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];

    [HttpPostExecutor postExecuteWithUrlStr:XiaoQuBiBei_m27_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
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
        XiaoQuBiBeiXinXi*custo=[[XiaoQuBiBeiXinXi alloc]init];
        NSArray *workItems = [[NSArray alloc]initWithArray:shuzu];
        custo.id_list=workItems;
        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:custo childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class], nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class], nil] ];
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Stwwr;
        Stwwr=[str2 stringByAppendingString:str_jiami];

        [HttpPostExecutor postExecuteWithUrlStr:XiaoQuBiBei_m27_02 Paramters:Stwwr FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            // NSLog(@"第2次: %@", result);
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
            arr_info=[[NSArray alloc]init];
            arr_info=[rootDic objectForKey:@"info"];
            [self.view addSubview:mytableview];
            }
            
        }];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MJTableViewCellIdentifier forIndexPath:indexPath];
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
    
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(20, 3, 300, 20)];
    name.text=[arr_info[indexPath.row] objectForKey:@"necessary_info_name"];
    name.font=[UIFont systemFontOfSize:14];
    [cell addSubview:name];
    
    UILabel *publish_time=[[UILabel alloc]initWithFrame:CGRectMake(40, 30, 280, 20)];
    publish_time.text=[arr_info[indexPath.row] objectForKey:@"necessary_info_phone"];
    publish_time.font=[UIFont systemFontOfSize:14];
    publish_time.textColor=[UIColor blueColor];
    [cell addSubview:publish_time];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(260, 5, 40, 40)];
    imageview.image=[UIImage imageNamed:@"phone.png"];
    [cell addSubview:imageview];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSString *number =[arr_info[indexPath.row] objectForKey:@"necessary_info_phone"];// 此处读入电话号码
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_info.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
