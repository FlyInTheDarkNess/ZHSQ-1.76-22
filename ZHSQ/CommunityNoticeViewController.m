//
//  CommunityNoticeViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-6.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "CommunityNoticeViewController.h"
#import "PropertyNoticeViewController.h"
#import "BulletinNoticeHttpService.h"
#import "SheQuTongZhiXiangQingViewController.h"
#import "DengLuHouZhuYeViewController.h"
#import "Header.h"
extern NSDictionary *SQTZDictionary;
@interface CommunityNoticeViewController ()
{
    
    //主键ID
    NSArray *idList;
    //请求
    BulletinNoticeHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    //NSMutableArray *_fakeData;
    int startIndex;
    
    BOOL isUp;
}
@end

@implementation CommunityNoticeViewController
@synthesize rightSwipeGestureRecognizer,tableview;
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
    
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.text=@"公告通知";
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label];
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    wuyeBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 60, 160, 40)];
    [wuyeBtn setTitle:@"物业通知" forState:UIControlStateNormal];
    [wuyeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    wuyeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [wuyeBtn addTarget:self action:@selector(wuyetongzhi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wuyeBtn];
    shequBtn=[[UIButton alloc]initWithFrame:CGRectMake(160, 60, 160, 40)];
    [shequBtn setTitle:@"社区通知" forState:UIControlStateNormal];
    [shequBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shequBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:shequBtn];
    
    labelline=[[UILabel alloc]initWithFrame:CGRectMake(205, 90, 70, 2)];
    labelline.backgroundColor=[UIColor colorWithRed:102/255.0 green:204/255.0 blue:255/255.0 alpha:1];//RGB设置要透明效果的颜色 alpha:1设置透明度 1最大不透明 0最小完全透明 需要多少透明度自己设置
    [self.view addSubview:labelline];
    
    
    /*
     ********
     *********滑动手势****
     ********
     */
    
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    startIndex = 0;
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 92, Width, Hidth - 92) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [tableview addHeaderWithTarget:self action:@selector(dataInit)];
    [tableview addFooterWithTarget:self action:@selector(addData)];
    [tableview headerBeginRefreshing];
    
    newsArr = [NSMutableArray array];

    

}
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:@"Curl" context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        PropertyNoticeViewController *tongzhi=[[PropertyNoticeViewController alloc]init];
        [self presentViewController:tongzhi animated:NO completion:nil];
        [UIView commitAnimations];
    }
}

-(void)wuyetongzhi
{
    PropertyNoticeViewController *tongzhi=[[PropertyNoticeViewController alloc]init];
    [self presentViewController:tongzhi animated:NO completion:nil];
    
}
-(void)dataInit
{
    NSString *str1=@"{\"city_id\":\"101\",\"community_id\":\"102\"}";
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[BulletinNoticeHttpService alloc]init];
    sqHttpSer.strUrl = SheQuTongZhi_m13_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
}
-(void)addData
{
    if (startIndex == idList.count) {
        [tableview footerEndRefreshing];
        [tableview setFooterHidden:YES];
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据了!" duration:1.5];
        return;
        
    }
    NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"101\",\"community_id\":\"102\",\"id_array\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[BulletinNoticeHttpService alloc]init];
    sqHttpSer.strUrl = SheQuTongZhi_m13_02;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = NO;
}


#pragma mark - UITableView Delegate


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
    cell.backgroundColor = [UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    UILabel *label0=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 60)];
    label0.backgroundColor=[UIColor whiteColor];
    [cell addSubview:label0];
    
    UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 300, 20)];
    labela.text=[newsArr[indexPath.row] objectForKey:@"title"];
    labela.backgroundColor=[UIColor whiteColor];
    labela.font=[UIFont systemFontOfSize:14];
    labela.textColor=[UIColor blackColor];
    [cell addSubview:labela];
    UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 300, 40)];
    labelc.text=[newsArr[indexPath.row] objectForKey:@"summary"];
    labelc.backgroundColor=[UIColor whiteColor];
    labelc.font=[UIFont systemFontOfSize:12];
    labelc.numberOfLines=2;
    labelc.textColor=[UIColor grayColor];
    [cell addSubview:labelc];
    UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 315, 15)];
    labeld.text=[newsArr[indexPath.row] objectForKey:@"createdate"];
    labeld.backgroundColor=[UIColor clearColor];
    labeld.textAlignment=NSTextAlignmentRight;
    labeld.font=[UIFont systemFontOfSize:12];
    labeld.textColor=[UIColor grayColor];
    [cell addSubview:labeld];
    UIImageView *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"new_NEW.png"]];
    imageview.frame=CGRectMake(0, 5, 40, 15);
    [cell addSubview:imageview];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SQTZDictionary=[[NSDictionary alloc]init];
    SQTZDictionary=newsArr[indexPath.row];
    SheQuTongZhiXiangQingViewController *xiangqing=[[SheQuTongZhiXiangQingViewController alloc]init];
    [self presentViewController:xiangqing animated:NO completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsArr.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 3:{
            startIndex = 0;
            NSLog(@"%@",sqHttpSer.responDict);
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_array"]];
            NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"101\",\"community_id\":\"102\",\"id_array\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[BulletinNoticeHttpService alloc]init];
            sqHttpSer.strUrl = SheQuTongZhi_m13_02;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 4:{
            [tableview headerEndRefreshing];
            [tableview footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSLog(@"%@",sqHttpSer.responDict);
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info_array"]];
            [newsArr addObjectsFromArray:responArr];
            [tableview reloadData];
            
        }
            break;
        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag{
    [tableview headerEndRefreshing];
    [tableview footerEndRefreshing];
}
-(NSString *)getFromArr:(NSArray *)arr withNumber:(int)num{
    if (arr.count == 0) {
        return @"";
    }
    NSMutableString *finalStr =[[NSMutableString alloc] initWithString:@"["];
    if (arr.count < num) {
        num = arr.count;
    }
    for (int index = startIndex; index < num; index++) {
        [finalStr appendFormat:@"{\"id\":\"%@\"},",arr[index][@"id"]];
        startIndex++;
    }
    NSUInteger location = [finalStr length]-1;
    NSRange range = NSMakeRange(location, 1);
    [finalStr replaceCharactersInRange:range withString:@"]"];
    return finalStr;
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
    DengLuHouZhuYeViewController *fanhui=[[DengLuHouZhuYeViewController alloc]init];
    [self presentViewController:fanhui animated:NO completion:nil];
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
