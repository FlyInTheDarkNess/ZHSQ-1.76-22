//
//  XuanZeChengShiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-8-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "XuanZeChengShiViewController.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "URL.h"
#import "JiaMiJieMi.h"
@interface XuanZeChengShiViewController ()

@end

@implementation XuanZeChengShiViewController

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
    
    @try
    {

    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat height=size.height;
    CGFloat width=size.width;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:87/255.0 blue:83/255.0 alpha:1];
    [self.view addSubview:label];
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, width, 35)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.text=@"城市选择";
    label_title.textAlignment=NSTextAlignmentCenter;
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 35, 35)];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];

    
    tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 55, width, height-55)];
    tab.dataSource=self;
    tab.delegate=self;
    arr=[[NSMutableArray alloc]init];
    
    NSString *str1=@"{\"session\":\"\"}";
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];

    [HttpPostExecutor postExecuteWithUrlStr:ChengShiXuanZe_m24_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        //NSLog(@"第2次: %@", result);//result就是NSString类型的返回值
        NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
        arr=[rootDic objectForKey:@"city_list"];
        [self.view addSubview:tab];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [tab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *a=[[UILabel alloc]initWithFrame:CGRectMake(0, 39, 320, 1)];
    a.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [cell addSubview:a];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.text = [arr[indexPath.row] objectForKey:@"name"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头  
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)fan
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



@end
