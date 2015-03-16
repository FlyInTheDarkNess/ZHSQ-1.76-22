//
//  ZHMyMessageViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-12-24.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ZHMyMessageViewController.h"
#import "ZHMyMessageCell.h"
#import "ZHMyMessageDetailsViewController.h"
extern NSString *Session;
extern NSDictionary *MyMessageDictionary;
@interface ZHMyMessageViewController ()

@end

@implementation ZHMyMessageViewController
@synthesize MyMessageTableView;
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
    self.view.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.33];
    imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, 60)];
    imageview.image=[UIImage imageNamed:@"nav.png"];
    [self.view addSubview:imageview];
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, kViewwidth, 40)];
    label_title.text=@"我的消息";
    label_title.textColor=[UIColor whiteColor];
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label_title];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:btn_fanhui];
    
    MyMessageTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kViewwidth, kViewHeight-40) style:UITableViewStylePlain];
    MyMessageTableView.delegate = self;
    MyMessageTableView.dataSource = self;
    [self.view addSubview:MyMessageTableView];
    
    [MyMessageTableView addHeaderWithTarget:self action:@selector(ltDataInit)];
    [MyMessageTableView addFooterWithTarget:self action:@selector(ltAddData)];
    [MyMessageTableView headerBeginRefreshing];
    
    postArr = [NSMutableArray array];

}
-(void)ltDataInit
{
    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"count_per_page\":\"10000\",\"pagenum\":\"1\"}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtHttpSer = [[ZHMyMessageService alloc]init];
    sqLtHttpSer.strUrl = MyMessage_21_02;
    sqLtHttpSer.delegate = self;
    sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtHttpSer beginQuery];
    isUp = YES;
}
-(void)ltAddData{
    if (startIndex == idList.count) {
        [MyMessageTableView footerEndRefreshing];
        [MyMessageTableView setFooterHidden:YES];
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtHttpSer = [[ZHMyMessageService alloc]init];
    sqLtHttpSer.strUrl = MyMessage_21_03;
    sqLtHttpSer.delegate = self;
    sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtHttpSer beginQuery];
    isUp = NO;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier=@"ZHMyMessageCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    if (cell==nil)
    {
        NSArray *nibsArr = [[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
        cell  = nibsArr[0];
    }
    cell.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.73];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];
    
    UILabel *titleLab = (UILabel *)[cell.contentView viewWithTag:2];
    titleLab.text = [dic objectForKey:@"m_title"];
    
    UILabel *detailLab = (UILabel *)[cell.contentView viewWithTag:3];
    detailLab.text = [dic objectForKey:@"m_content"];
    
    UILabel *dateLab = (UILabel *)[cell.contentView viewWithTag:4];
    dateLab.text = [dic objectForKey:@"createdate"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMessageDictionary = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];

    ZHMyMessageDetailsViewController *deta=[[ZHMyMessageDetailsViewController alloc]init];
    [self presentViewController:deta animated:NO completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return postArr.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSDictionary *flowTraceDict = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];
//    return [AXHSQForumCell handCellHeight:flowTraceDict].frame.size.height;
    return 111;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            startIndex = 0;
            
            NSString *a=sqLtHttpSer.responDict[@"ecode"];
            NSLog(@"我的消息 :%@",sqLtHttpSer.responDict);
            int intb = [a intValue];
            if (intb==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
                [MyMessageTableView headerEndRefreshing];

                return;
                
            }

            idList = [NSArray arrayWithArray:sqLtHttpSer.responDict[@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqLtHttpSer = [[ZHMyMessageService alloc]init];
            sqLtHttpSer.strUrl = MyMessage_21_03;
            sqLtHttpSer.delegate = self;
            sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqLtHttpSer beginQuery];
            
        }
            break;
        case 2:{
            [MyMessageTableView headerEndRefreshing];
            [MyMessageTableView footerEndRefreshing];
            
            if (isUp) {
                [postArr removeAllObjects];
            }
            NSLog(@"我的消息 2:%@",sqLtHttpSer.responDict);
             NSString *a=sqLtHttpSer.responDict[@"ecode"];
            int intb = [a intValue];
            if (intb==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
                [MyMessageTableView headerEndRefreshing];
                
                return;
                
            }

            NSArray *responArr = [NSArray arrayWithArray:sqLtHttpSer.responDict[@"info"]];
            [postArr addObjectsFromArray:responArr];
            [MyMessageTableView reloadData];
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    [MyMessageTableView headerEndRefreshing];
    [MyMessageTableView footerEndRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
