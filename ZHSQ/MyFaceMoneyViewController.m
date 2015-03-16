//
//  MyFaceMoneyViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-26.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "MyFaceMoneyViewController.h"
#import "PersonCenterHttpService.h"
#import "Pay ViewController.h"
extern NSString *Session;
extern NSString *Payment_url;
extern NSString *SheQuFuWu_Title;

@interface MyFaceMoneyViewController ()
{
    
    //主键ID
    NSArray *idList;
    //请求
    PersonCenterHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    //NSMutableArray *_fakeData;
    int startIndex;
    
    BOOL isUp;
}

@end

@implementation MyFaceMoneyViewController
@synthesize huoqu_btn,xiaofei_btn,zongshu_label,NoResult_label,dianjishuaxin_btn;
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
    // Do any additional setup after loading the view from its nib.
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度

    startIndex = 0;
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, Width, Hidth - 200) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [tableview addHeaderWithTarget:self action:@selector(dataInit)];
    [tableview addFooterWithTarget:self action:@selector(addData)];
    [tableview headerBeginRefreshing];
    
    newsArr = [NSMutableArray array];

}
-(void)keyong
{
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\"}",Session];
    
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = WoDeXiaoLianBi_m19_03;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    
}
-(void)dataInit
{
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"date_start\":\"\",\"date_end\":\"\"}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = WoDeXiaoLianBi_m19_01;
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
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":%@}",Session,[self getFromArr:idList withNumber: startIndex + 10]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = WoDeXiaoLianBi_m19_02;
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
    UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 30)];
    labela.font=[UIFont systemFontOfSize:12];
    NSString *a=[newsArr[indexPath.row] objectForKey:@"credit"];
    labela.text=[NSString stringWithFormat:@"+%@",a];
    [cell.contentView addSubview:labela];
    UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, 160, 30)];
    labelb.font=[UIFont systemFontOfSize:12];
    NSString *b=[newsArr[indexPath.row] objectForKey:@"content"];
    labelb.text=[NSString stringWithFormat:@"%@",b];
    [cell addSubview:labelb];
    UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 10, 80, 30)];
    labelc.font=[UIFont systemFontOfSize:12];
    NSString *stringTime =[newsArr[indexPath.row] objectForKey:@"createdate"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *dateTime = [formatter dateFromString:stringTime];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSString *locationString=[formatter stringFromDate:dateTime];
    labelc.text=locationString;
    [cell addSubview:labelc];

        return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 40)];
    view.backgroundColor=[UIColor whiteColor];
    UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    labela.font=[UIFont systemFontOfSize:12];
    labela.text=@"分数";
    [view addSubview:labela];
    UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 40, 30)];
    labelb.font=[UIFont systemFontOfSize:12];
    labelb.text=@"原因";
    [view addSubview:labelb];
    UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 0, 40, 30)];
    labelc.font=[UIFont systemFontOfSize:12];
    labelc.text=@"时间";
    [view addSubview:labelc];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
    return 40;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 13:{
            startIndex = 0;
            //NSLog(@"%@",sqHttpSer.responDict);
            int inta = [[sqHttpSer.responDict objectForKey:@"ecode"] intValue];
            
            if (inta==3007)
            {
               [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                tableview.hidden=YES;
                return;
            }
            if (inta==1000)
            {
                tableview.hidden=NO;
                NoResult_label.hidden=YES;
                dianjishuaxin_btn.hidden=YES;
            }
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_array"]];
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":%@}",Session,[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[PersonCenterHttpService alloc]init];
            sqHttpSer.strUrl = WoDeXiaoLianBi_m19_02;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 14:{
            [tableview headerEndRefreshing];
            [tableview footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
           // NSLog(@"笑脸币 ：%@",sqHttpSer.responDict);
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info_array"]];
            [newsArr addObjectsFromArray:responArr];

            [tableview reloadData];
            [self keyong];
            
        }
        case 15:{
            NSLog(@"ccccc  %@",sqHttpSer.responDict);

            int inta = [[sqHttpSer.responDict objectForKey:@"ecode"] intValue];
            
            if (inta==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                tableview.hidden=YES;
                return;
            }
            if (inta==1000)
            {
                zongshu_label.text=[sqHttpSer.responDict  objectForKey:@"credit_usable"];
            }

           
        }

            break;
        case 16:{
            startIndex = 0;
            NSLog(@"%@",sqHttpSer.responDict);
            int inta = [[sqHttpSer.responDict objectForKey:@"ecode"] intValue];
            
            if (inta==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                tableview.hidden=YES;
                return;
            }
            if (inta==1000)
            {
                NoResult_label.hidden=YES;
                dianjishuaxin_btn.hidden=YES;
            }
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_array"]];
            NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"id_array\":%@}",Session,[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[PersonCenterHttpService alloc]init];
            sqHttpSer.strUrl = WoDeXiaoLianBi_m19_05;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 17:{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fanhui:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)huoqu:(id)sender
{
    
    [huoqu_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [xiaofei_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"date_start\":\"\",\"date_end\":\"\"}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = WoDeXiaoLianBi_m19_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;

}

- (IBAction)xiaofei:(id)sender
{
    [huoqu_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [xiaofei_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\",\"date_start\":\"\",\"date_end\":\"\"}",Session];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = WoDeXiaoLianBi_m19_04;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;

}

- (IBAction)dianjishuaxin:(id)sender {
    [self dataInit];
}

- (IBAction)xiaolianbigonglue:(id)sender
{
    SheQuFuWu_Title=@"笑脸币攻略";
    Payment_url=@"http://www.xiaolianshequ.cn/description/creditrule.html";
    Pay_ViewController *subViewVCtr=[[Pay_ViewController alloc]init];
    [self presentViewController:subViewVCtr animated:NO completion:nil];

}
@end
