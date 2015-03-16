//
//  AXHSQForumViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHSQForumViewController.h"
#import "AXHSQForumCell.h"
#import "AXHSQForumDetailViewController.h"
#import "SheQuHuDongXiangQingViewController.h"
#import "AXHNewPostViewController.h"
extern NSDictionary *SheQuHuDongXiangQingDictionary;
@interface AXHSQForumViewController (){
    
    //评论ID
    NSArray *idList;
    //请求
    SQForumHttpService  *sqLtHttpSer;
    //当前列表数据
    NSMutableArray *postArr;
    
    int startIndex;
    
    BOOL isUp;
}

@end
@implementation AXHSQForumViewController
@synthesize ltTableView;
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
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customRightNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = @"社区论坛";
    ltTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kViewwidth, kViewHeight - 44) style:UITableViewStylePlain];
    ltTableView.backgroundColor = [UIColor whiteColor];
    ltTableView.delegate = self;
    
    ltTableView.dataSource = self;
    [self.view addSubview:ltTableView];
    
    [ltTableView addHeaderWithTarget:self action:@selector(ltDataInit)];
    [ltTableView addFooterWithTarget:self action:@selector(ltAddData)];
    [ltTableView headerBeginRefreshing];
    
    postArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postSendSuccess) name:@"postSendSuccess" object:nil];
}
-(void)postSendSuccess{
    [ltTableView headerBeginRefreshing];
}
-(void)backUpper{
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}
-(void)nextControl{
    AXHNewPostViewController *postVCtr = [[AXHNewPostViewController alloc]initWithNibName:@"AXHNewPostViewController" bundle:nil withType:PostTypeDefault withBackDict:nil];
    UINavigationController  *NAVc = [[UINavigationController alloc]initWithRootViewController:postVCtr];
    [self.navigationController presentViewController:NAVc animated:YES completion:NULL];
}
-(void)ltDataInit
{
    NSString *str1 = [NSString stringWithFormat:@"{\"city_id\":\"%@\",\"quarter_id\":\"%@\",\"community_id\":\"%@\",\"module_id\":\"\"}",[SurveyRunTimeData sharedInstance].city_id,[SurveyRunTimeData sharedInstance].quarter_id,[SurveyRunTimeData sharedInstance].community_id];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtHttpSer = [[SQForumHttpService alloc]init];
    sqLtHttpSer.strUrl = SheQuHuDong_m10_02;
    sqLtHttpSer.delegate = self;
    sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtHttpSer beginQuery];
    isUp = YES;
}
-(void)ltAddData{
    if (startIndex == idList.count) {
        [ltTableView footerEndRefreshing];
        [ltTableView setFooterHidden:YES];
        [SVProgressHUD showErrorWithStatus:@"没有更多数据了!" duration:1.5];
        return;
    }
    NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"%@\",\"community_id\":\"%@\",\"id_list\":%@}",[SurveyRunTimeData sharedInstance].city_id,[SurveyRunTimeData sharedInstance].community_id,[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqLtHttpSer = [[SQForumHttpService alloc]init];
    sqLtHttpSer.strUrl = SheQuHuDong_m10_03;
    sqLtHttpSer.delegate = self;
    sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqLtHttpSer beginQuery];
    isUp = NO;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *flowTraceDict = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];
    AXHSQForumCell *sqForumCell = [AXHSQForumCell handCellHeight:flowTraceDict];
    sqForumCell.backgroundColor = [UIColor clearColor];
    UIView *view = (UIView *)[sqForumCell.contentView viewWithTag:8];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 1.0;
    view.backgroundColor = [UIColor whiteColor];
    sqForumCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return sqForumCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];
    AXHSQForumDetailViewController *sqLTDetailVCtr = [[AXHSQForumDetailViewController alloc]initWithNibName:nil bundle:nil withDetailDict:dict];
    [self.navigationController pushViewController:sqLTDetailVCtr animated:YES];
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
    NSDictionary *flowTraceDict = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];
    return [AXHSQForumCell handCellHeight:flowTraceDict].frame.size.height;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            startIndex = 0;
            idList = [NSArray arrayWithArray:sqLtHttpSer.responDict[@"id_list"]];

            if ([sqLtHttpSer.responDict[@"ecode"] intValue] == 3007) {
                [SVProgressHUD showErrorWithStatus:@"没有数据" duration:1.5];
                [ltTableView headerEndRefreshing];
                [ltTableView footerEndRefreshing];
                return;
            }else if ([sqLtHttpSer.responDict[@"ecode"] intValue] != 1000){
                [SVProgressHUD showErrorWithStatus:@"系统内部错误" duration:1.5];
                [ltTableView headerEndRefreshing];
                [ltTableView footerEndRefreshing];
                return;
                
            }
            
            NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"%@\",\"community_id\":\"%@\",\"id_list\":%@}",[SurveyRunTimeData sharedInstance].city_id,[SurveyRunTimeData sharedInstance].community_id,[self getFromArr:idList withNumber: startIndex + 5]];
            
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqLtHttpSer = [[SQForumHttpService alloc]init];
            sqLtHttpSer.strUrl = SheQuHuDong_m10_03;
            sqLtHttpSer.delegate = self;
            sqLtHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqLtHttpSer beginQuery];
            
        }
            break;
        case 2:{
            [ltTableView headerEndRefreshing];
            [ltTableView footerEndRefreshing];
            
            if (isUp) {
                [postArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:sqLtHttpSer.responDict[@"info"]];
            for (int i = responArr.count - 1; i >= 0; i--) {
                [postArr addObject:responArr[i]];
            }
            //            [postArr addObjectsFromArray:responArr];
            [ltTableView reloadData];
        }
            break;
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    [ltTableView headerEndRefreshing];
    [ltTableView footerEndRefreshing];
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


@end
