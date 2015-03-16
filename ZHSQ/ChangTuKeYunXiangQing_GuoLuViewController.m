//
//  ChangTuKeYunXiangQing_GuoLuViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-11-21.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ChangTuKeYunXiangQing_GuoLuViewController.h"
extern NSMutableArray *arr_ChangTuKeYun;
@interface ChangTuKeYunXiangQing_GuoLuViewController ()

@end

@implementation ChangTuKeYunXiangQing_GuoLuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [mytableview reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat height=size.height;
    CGFloat width=size.width;
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, width, 40)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.text=@"路线信息";
    label_title.textAlignment=NSTextAlignmentCenter;
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, width, height-60)];
    mytableview.delegate=self;
    mytableview.dataSource=self;
    [self.view addSubview:mytableview];


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_ChangTuKeYun.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel *zhan=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    zhan.text=[NSString stringWithFormat:@"第%d站 ●",indexPath.row+1];
    zhan.backgroundColor=[UIColor whiteColor];
    zhan.textColor=[UIColor colorWithRed:154/255.0 green:205/255.0 blue:50/255.0 alpha:1];
    [cell addSubview:zhan];
    
    
    UILabel *label_beijing=[[UILabel alloc]initWithFrame:CGRectMake(90, 5, 220, 30)];
    label_beijing.layer.masksToBounds = YES;
    label_beijing.layer.cornerRadius = 5;
    label_beijing.layer.borderWidth = 0.5;
    label_beijing.layer.borderColor=[[UIColor grayColor] CGColor];
    label_beijing.backgroundColor=[UIColor whiteColor];
    label_beijing.text=[NSString stringWithFormat:@" 站点:%@",[arr_ChangTuKeYun[indexPath.row] objectAtIndex:0]];
    label_beijing.font=[UIFont systemFontOfSize:14];
    [cell addSubview:label_beijing];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
