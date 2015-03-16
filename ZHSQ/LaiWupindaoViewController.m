//
//  LaiWupindaoViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-7-17.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "LaiWupindaoViewController.h"
#import "CalendarDateUtil.h"
#import "UIBaseClass.h"
#import "Location.h"
#import "WorkItem.h"
#import "Customer.h"
#import "SerializationComplexEntities.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "URL.h"
#import "JiaMiJieMi.h"
extern NSString *pindaoID;
@interface LaiWupindaoViewController ()

@end

@implementation LaiWupindaoViewController

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
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度

    
     self.view.backgroundColor = [UIColor whiteColor];
    _scrollDate = 0;
    _btnDate = 0;
    
    [self initBase];
    [self initDateView];
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    _timeString = [dateformat stringFromDate:[NSDate date]];
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.text=@"节目单";
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 40, 40)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    laiwu_jiemodan=[[NSArray alloc]init];
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 120, Width, Hidth-120)];
    tableview.delegate=self;
    tableview.dataSource=self;

}
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)initBase
{
    _btnArray = [[NSMutableArray alloc]init];
    _changeBtnArrayR = [[NSMutableArray alloc]init];
    _changeBtnArrayL = [[NSMutableArray alloc]init];
    
    _changeWeek = 0;
    _btnSelectDate = 0;
    _dateView = [[UIView alloc]initWithFrame:CGRectMake(0, 48, 320, 40)];
    _dateView.backgroundColor = [UIColor clearColor];
    _changeDateR = [[UIView alloc]initWithFrame:CGRectMake(320, 48, 320, 40)];
    _changeDateL = [[UIView alloc]initWithFrame:CGRectMake(-320, 48, 320, 40)];
    _workView = [[UIView alloc]initWithFrame:CGRectMake(0, 146, 320, 460)];
    _changeWorkR = [[UIView alloc]initWithFrame:CGRectMake(320, 146, 320, 460)];
    _changeWorkL = [[UIView alloc]initWithFrame:CGRectMake(-320, 146, 320, 460)];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, 320, 80)];
    //   _scrollView.backgroundColor=[UIColor orangeColor];
    _scrollView.contentSize = CGSizeMake(320, iPhone5?0:500);
    //    _scrollView.pagingEnabled = YES;
    //    _scrollView.userInteractionEnabled = YES; // 是否滑动
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
}
-(void)initDateView
{
    @try
    {

    for (int i = 0; i < 7; i++)
    {
        UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(320/7*i, 65, 320/7, 15)];//设置坐标
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0];
        lab.backgroundColor = [UIColor clearColor];
        NSString* week;
        switch (i) {
            case 0:{
                week=@"周日";
                break;
            }
            case 1:{
                week=@"周一";
                break;
            }
            case 2:{
                week=@"周二";
                break;
            }
            case 3:{
                week=@"周三";
                break;
            }
            case 4:{
                week=@"周四";
                break;
            }
            case 5:{
                week=@"周五";
                break;
            }
            case 6:{
                week=@"周六";
                break;
            }
                
                
            default:
                break;
        }
        lab.text = [NSString stringWithFormat:@"%@",week];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lab];
    }
    
    NSMutableArray* tempArr = [self switchDay];
    
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 30)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        //lab.backgroundColor = [UIColor greenColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            lab.tag = 0;
            _btnSelectDate = i;
        }
        [_btnArray addObject:lab];
        [_dateView addSubview:lab];
    }
    //设置tag
    for (int i = 0; i < _btnSelectDate; i++)
    {
        int tagInt = i - _btnSelectDate;
        UIButton* tempBtn = [_btnArray objectAtIndex:i];
        tempBtn.tag = tagInt;
    }
    for (int i = 1; i < 7 - _btnSelectDate; i++)
    {
        int tagInt = i;
        UIButton* tempBtn = [_btnArray objectAtIndex:_btnSelectDate + i];
        tempBtn.tag = tagInt;
    }
    
    
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
        }
        [_changeBtnArrayR addObject:lab];
        [_changeDateR addSubview:lab];
    }
    for (int i = 0; i < 7; i++)
    {
        UIButton* lab = [[UIButton alloc]initWithFrame:CGRectMake(320/7*i, 0, 320/7, 40)];
        lab.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [lab setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        lab.backgroundColor = [UIColor clearColor];
        [lab setTitle:[tempArr objectAtIndex:i] forState:UIControlStateNormal];
        [lab addTarget:self action:@selector(selectData:) forControlEvents:UIControlEventTouchUpInside];
        if ([lab.titleLabel.text isEqualToString:[NSString stringWithFormat:@"%d",[CalendarDateUtil getCurrentDay]]])
        {
            [lab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [lab setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
        }
        [_changeBtnArrayL addObject:lab];
        [_changeDateL addSubview:lab];
    }
    
    [_scrollView addSubview:_changeDateR];
    [_scrollView addSubview:_changeDateL];
    [_scrollView addSubview:_dateView];
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

-(NSMutableArray*)switchDay
{
       NSMutableArray* array = [[NSMutableArray alloc]init];
    
    int head = 0;
    int foot = 0;
    switch ([self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]]) {
        case 1:{
            head = 0;
            foot = 6;
            break;
        }
        case 2:{
            head = 1;
            foot = 5;
            break;
        }
        case 3:{
            head = 2;
            foot = 4;
            break;
        }
        case 4:{
            head = 3;
            foot = 3;
            break;
        }
        case 5:{
            head = 4;
            foot = 2;
            break;
        }
        case 6:{
            head = 5;
            foot = 1;
            break;
        }
        case 7:{
            head = 6;
            foot = 0;
            break;
        }
            
            
        default:
            break;
    }
   
    
    //    NSLog(@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:-1]]);
    
    for (int i = -head; i < 0; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:i]]];
        [array addObject:str];
    }
    
    [array addObject:[NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:0]]]];
    
    //sy 添加日期
    int tempNum = 1;
    for (int i = 0; i < foot; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:tempNum]]];
        [array addObject:str];
        tempNum++;
    }
       
    return array;
    
}

-(NSInteger)weekDate:(NSDate*)date
{
    
    // 获取当前年月日和周几
    //    NSDate *_date=[NSDate date];
    NSCalendar *_calendar=[NSCalendar currentCalendar];
    NSInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
    NSDateComponents *com=[_calendar components:unitFlags fromDate:date];
    NSString *_dayNum=@"";
    NSInteger dayInt = 0;
    switch ([com weekday]) {
        case 1:{
            _dayNum=@"日";
            dayInt = 1;
            break;
        }
        case 2:{
            _dayNum=@"一";
            dayInt = 2;
            break;
        }
        case 3:{
            _dayNum=@"二";
            dayInt = 3;
            break;
        }
        case 4:{
            _dayNum=@"三";
            dayInt = 4;
            break;
        }
        case 5:{
            _dayNum=@"四";
            dayInt = 5;
            break;
        }
        case 6:{
            _dayNum=@"五";
            dayInt = 6;
            break;
        }
        case 7:{
            _dayNum=@"六";
            dayInt = 7;
            break;
        }
            
            
        default:
            break;
    }
    
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd"];
    NSString* dateStr = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_scrollDate + _btnDate]];
    
    //    _nowDateString = [[NSString alloc]initWithFormat:@"%@ 星期%@", dateStr, _dayNum];
    _nowDateString = [[NSString alloc]initWithFormat:@"%@", dateStr];
    dateLable.text = _nowDateString;
    SHOUshizhinan *customer =[[SHOUshizhinan alloc]init];
    customer.channel_id =pindaoID;
    customer.channel_date=_nowDateString;
    customer.channel_kind=@"6";
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSLog(@"参数: %@", str1);
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    [HttpPostExecutor postExecuteWithUrlStr:ShouShiZhiNan_m8_01 Paramters:str_jiami FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
         //NSLog(@"第2次: %@", result);//result就是NSString类型的返回值
        NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        NSLog(@"+++++++++++++\n第2次: %@", result);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
        // NSLog(@"第一次: 解析%@", rootDic);
        
        NSString *a=[rootDic objectForKey:@"ecode"];
        int intb = [a intValue];
        
        if (intb==1000)
        {
            laiwu_jiemodan=[rootDic objectForKey:@"content_info"];
            [self.view addSubview:tableview];
            [tableview reloadData];
        }
        if (intb==4000)
        {
            [self showWithCustomView:@"服务器内部错误"];
        }

        
        
    }];

    return dayInt;
       
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
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
    UILabel *shijian=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 30)];
    shijian.text=[laiwu_jiemodan[indexPath.row] objectForKey:@"tv_time"];
    shijian.font=[UIFont systemFontOfSize:12];
    [cell addSubview:shijian];
    
    UILabel *jiemu=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 200, 30)];
    jiemu.text=[laiwu_jiemodan[indexPath.row] objectForKey:@"tv_content"];
    jiemu.font=[UIFont systemFontOfSize:12];
    [cell addSubview:jiemu];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return laiwu_jiemodan.count;
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(void)selectData:(id)sender
{
    @try
    {

    UIButton* sendBtn = sender;
    NSLog(@"btn = %@", sendBtn.titleLabel.text);
    NSLog(@"btn.tag = %d", sendBtn.tag);
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        UIButton* tmpBtn = [_btnArray objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if ([tmpBtn.titleLabel.text isEqualToString:sendBtn.titleLabel.text])
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
    if ([sendBtn.titleLabel.text isEqualToString:@"29"])
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    else
    {
        _bsLable.text = @"0";
        _bpLable.text = @"0";
    }
    
    
    _btnDate = sendBtn.tag;
    
    //按日期确定星期
    
    [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate]];
    
    NSLog(@"%@",_nowDateString);
    
    
    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    _timeString = [dateformat stringFromDate:[CalendarDateUtil dateSinceNowWithInterval:_btnDate + _scrollDate]]; // _scrollDate
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

#pragma mark -
#pragma mark setButtonTitle
-(void)setBtnTitle  // 修改Btn的日期
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    
    for (int i = 0; i < [_btnArray count]; i++)
    {
        [[_btnArray objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
    }
}
-(void)setBtnTitleR
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]] - 1;
    for (int i = 0; i < [_changeBtnArrayR count]; i++)
    {
        [[_changeBtnArrayR objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        
        UIButton* tmpBtn = [_changeBtnArrayR objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}
-(void)setBtnTitleL
{
    int chooseInt = [self weekDate:[CalendarDateUtil dateSinceNowWithInterval:0]]-1;
    for (int i = 0; i < [_changeBtnArrayL count]; i++)
    {
        [[_changeBtnArrayL objectAtIndex:i] setTitle:[NSString stringWithFormat:@"%d",[CalendarDateUtil getDayWithDate:[CalendarDateUtil dateSinceNowWithInterval:_changeWeek + i - chooseInt]]] forState:UIControlStateNormal];
        
        UIButton* tmpBtn = [_changeBtnArrayL objectAtIndex:i];
        [tmpBtn setTitleColor:[UIColor colorWithRed:56.0/255 green:92.0/255 blue:99.0/255 alpha:1.0] forState:UIControlStateNormal];
        [tmpBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        if (_btnSelectDate == i)
        {
            [tmpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tmpBtn setBackgroundImage:[UIImage imageNamed:@"greenRound-80-80"] forState:UIControlStateNormal];
            _btnSelectDate = i;
        }
    }
}

#pragma mark -
#pragma mark UISwipeGestureRecognizer
//#pragma mark -
//#pragma mark TimeHidenButton
//
-(void)timeHidenButton:(NSString*)timeStr
{
    @try
    {

    NSDateFormatter *dateformat=[[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMdd"];
    NSString* nowTimeStr = [dateformat stringFromDate:[NSDate date]];
    int nowTime = [nowTimeStr integerValue];
    int selectTime = [timeStr integerValue];
    
    if (selectTime > nowTime)
    {
        _cBSView.hidden = YES;
        _cBPView.hidden = YES;
        _cBMIView.hidden = YES;
        _lBSView.hidden = YES;
        _lBPView.hidden = YES;
        _lBMIView.hidden = YES;
        _rBSView.hidden = YES;
        _rBPView.hidden = YES;
        _rBMIView.hidden = YES;
        [_workView setFrame:CGRectMake(0, 146 - 61*3, 320, 460)];
        [_changeWorkR setFrame:CGRectMake(320, 146 - 61*3, 320, 460)];
        [_changeWorkL setFrame:CGRectMake(-320, 146 - 61*3, 320, 460)];
    }
    else
    {
        _cBSView.hidden = NO;
        _cBPView.hidden = NO;
        _cBMIView.hidden = NO;
        _lBSView.hidden = NO;
        _lBPView.hidden = NO;
        _lBMIView.hidden = NO;
        _rBSView.hidden = NO;
        _rBPView.hidden = NO;
        _rBMIView.hidden = NO;
        [_workView setFrame:CGRectMake(0, 146, 320, 460)];
        [_changeWorkR setFrame:CGRectMake(320, 146, 320, 460)];
        [_changeWorkL setFrame:CGRectMake(-320, 146, 320, 460)];
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
