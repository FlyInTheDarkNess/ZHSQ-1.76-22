//
//  LuXianXinXiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-9-23.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "LuXianXinXiViewController.h"
extern NSString *LuXianXinXi;
@interface LuXianXinXiViewController ()

@end

@implementation LuXianXinXiViewController

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
    array= [LuXianXinXi componentsSeparatedByString:@"-"];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat height=size.height;
    CGFloat width=size.width;
    
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.text=@"路线信息";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self.view addSubview:label];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn_fanhui];
    
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 70, width, height-70)];
    mytableview.delegate=self;
    mytableview.dataSource=self;
    [self.view addSubview:mytableview];

    

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(90, 39, 320, 1)];
    label.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [cell addSubview:label];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel *zhan=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    zhan.text=[NSString stringWithFormat:@"第%d站 ●",indexPath.row+1];
    zhan.backgroundColor=[UIColor whiteColor];
    zhan.textColor=[UIColor colorWithRed:154/255.0 green:205/255.0 blue:50/255.0 alpha:1];
    [cell addSubview:zhan];
    UILabel *zhanming=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 200, 30)];
    zhanming.text=[NSString stringWithFormat:@" 站点:%@",array[indexPath.row]];
    zhanming.layer.masksToBounds = YES;
    zhanming.layer.cornerRadius = 5;
    zhanming.layer.borderWidth = 0.5;
    zhanming.layer.borderColor=[[UIColor grayColor] CGColor];
    zhanming.backgroundColor=[UIColor whiteColor];

    //zhanming.textColor=[UIColor colorWithRed:154/255.0 green:205/255.0 blue:50/255.0 alpha:1];
    [cell addSubview:zhanming];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void)fanhui
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
