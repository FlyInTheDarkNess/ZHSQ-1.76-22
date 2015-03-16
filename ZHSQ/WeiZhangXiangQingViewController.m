//
//  WeiZhangXiangQingViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-9-25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "WeiZhangXiangQingViewController.h"
extern NSDictionary *WeiZhangJiLuDictionary;

@interface WeiZhangXiangQingViewController ()

@end

@implementation WeiZhangXiangQingViewController

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
     arr=[WeiZhangJiLuDictionary objectForKey:@"info"];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:87/255.0 blue:83/255.0 alpha:1];
    label_title.text=@"罚单详情";
    label_title.textAlignment=NSTextAlignmentCenter;
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn_fanhui];
    label_chepai=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 320, 60)];
    label_chepai.backgroundColor=[UIColor colorWithRed:198/255.0 green:205/255.0 blue:213/255.0 alpha:1];
    label_chepai.text=[[arr objectAtIndex:0] objectForKey:@"plate_number"];
    label_chepai.textAlignment=NSTextAlignmentCenter;
    label_chepai.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:label_chepai];
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, 320, Hidth-120)];
    mytableview.delegate=self;
    mytableview.dataSource=self;
    [self.view addSubview:mytableview];
   
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (cell != nil)
    {
        [cell removeFromSuperview];//处理重用
    }
    cell.backgroundColor=[UIColor colorWithRed:198/255.0 green:205/255.0 blue:213/255.0 alpha:1];

    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 1, 210)];
    label2.backgroundColor=[UIColor grayColor];
    [cell.contentView addSubview:label2];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 90, 65, 30)];
    label1.text=[NSString stringWithFormat:@"案%d ●",indexPath.row+1];
    label1.backgroundColor=[UIColor colorWithRed:198/255.0 green:205/255.0 blue:213/255.0 alpha:1];
    label1.textAlignment=NSTextAlignmentRight;
    [cell.contentView addSubview:label1];
    
    UIView *myview=[[UIView alloc]initWithFrame:CGRectMake(70, 5, 240, 200)];
    myview.backgroundColor=[UIColor whiteColor];
    myview.layer.masksToBounds = YES;
    myview.layer.cornerRadius = 7;
    myview.layer.borderWidth = 0.5;
    myview.layer.borderColor=[[UIColor grayColor] CGColor];
    [cell.contentView addSubview:myview];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 220, 30)];
    label3.text=@"违章详情";
    label3.font=[UIFont systemFontOfSize:20];
    [myview addSubview:label3];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 220, 1)];
    label4.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [myview addSubview:label4];
    
    UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 40, 30)];
    label5.text=@"时间:";
    label5.font=[UIFont systemFontOfSize:14];
    [myview addSubview:label5];
    UILabel *label6=[[UILabel alloc]initWithFrame:CGRectMake(50, 40, 180, 30)];
    label6.text=[arr[indexPath.row] objectForKey:@"violation_time"];
    label6.font=[UIFont systemFontOfSize:14];
    label6.textColor=[UIColor blueColor];
    [myview addSubview:label6];
    UILabel *label7=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 220, 1)];
    label7.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [myview addSubview:label7];
    
    UILabel *label8=[[UILabel alloc]initWithFrame:CGRectMake(10, 70, 40, 30)];
    label8.text=@"地点:";
    label8.font=[UIFont systemFontOfSize:14];
    [myview addSubview:label8];
    UILabel *label9=[[UILabel alloc]initWithFrame:CGRectMake(50, 70, 180, 30)];
    label9.text=[arr[indexPath.row] objectForKey:@"violation_address"];
    label9.font=[UIFont systemFontOfSize:14];
    label9.textColor=[UIColor blueColor];
    [myview addSubview:label9];
    UILabel *label10=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 220, 1)];
    label10.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [myview addSubview:label10];
    
    UILabel *label11=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 40, 30)];
    label11.text=@"原因:";
    label11.font=[UIFont systemFontOfSize:14];
    [myview addSubview:label11];
    UILabel *label12=[[UILabel alloc]initWithFrame:CGRectMake(50, 100, 180, 30)];
    label12.text=[arr[indexPath.row] objectForKey:@"violation_reason"];
    label12.font=[UIFont systemFontOfSize:14];
    label12.textColor=[UIColor redColor];
    [myview addSubview:label12];
    UILabel *label13=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 220, 1)];
    label13.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [myview addSubview:label13];
    
    UILabel *label14=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 40, 30)];
    label14.text=@"罚金:";
    label14.font=[UIFont systemFontOfSize:14];
    [myview addSubview:label14];
    UILabel *label15=[[UILabel alloc]initWithFrame:CGRectMake(50, 130, 180, 30)];
    label15.text=[arr[indexPath.row] objectForKey:@"fine"];
    label15.font=[UIFont systemFontOfSize:14];
    label15.textColor=[UIColor blueColor];
    [myview addSubview:label15];
    UILabel *label16=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 220, 1)];
    label16.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [myview addSubview:label16];
    
    UILabel *label17=[[UILabel alloc]initWithFrame:CGRectMake(10, 160, 40, 30)];
    label17.text=@"罚分:";
    label17.font=[UIFont systemFontOfSize:14];
    [myview addSubview:label17];
    UILabel *label18=[[UILabel alloc]initWithFrame:CGRectMake(50, 160, 180, 30)];
    label18.text=[arr[indexPath.row] objectForKey:@"penalties"];
    label18.font=[UIFont systemFontOfSize:14];
    label18.textColor=[UIColor blueColor];
    [myview addSubview:label18];
    UILabel *label19=[[UILabel alloc]initWithFrame:CGRectMake(10, 190, 220, 1)];
    label19.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [myview addSubview:label19];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
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
