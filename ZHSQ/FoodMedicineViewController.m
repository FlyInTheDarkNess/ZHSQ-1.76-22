//
//  FoodMedicineViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 15-1-5.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "FoodMedicineViewController.h"
#import "FoodMedicineHttpService.h"
extern NSDictionary *ShiPinYaoPin_Dictionary;
@interface FoodMedicineViewController ()
{
    NSMutableArray *_fakeData;
    NSMutableArray *shijian;
    
    //新闻ID
    NSArray *idList;
    //请求
    FoodMedicineHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    
    int startIndex;
    
    BOOL isUp;

}

@end

@implementation FoodMedicineViewController

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
        
        label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
        label.text=@"食品药品";
        label.textAlignment=NSTextAlignmentCenter;
        [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        label.textColor=[UIColor whiteColor];
        [self.view addSubview:label];
        button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
        [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth-60)];
        tableview.dataSource=self;
        tableview.delegate=self;
        [self.view addSubview:tableview];
        [tableview addHeaderWithTarget:self action:@selector(dataInit)];
        [tableview addFooterWithTarget:self action:@selector(addData)];
        [tableview headerBeginRefreshing];
        
        _fakeData = [NSMutableArray array];
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
- (void)dataInit
{
    NSString *str1=@"{\"city_id\":\"101\",\"article_type_id\":\"56\"}";
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[FoodMedicineHttpService alloc]init];
    sqHttpSer.strUrl = ZiXunXinXi_m38_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;

}
- (void)addData
{
    if (startIndex == idList.count) {
        [tableview footerEndRefreshing];
        [tableview setFooterHidden:YES];
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据了!" duration:1.5];
        return;
        
    }
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[FoodMedicineHttpService alloc]init];
    sqHttpSer.strUrl = ZiXunXinXi_m38_02;
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
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(10, 3, 300, 20)];
    name.text=[_fakeData[indexPath.row] objectForKey:@"title"];
    name.font=[UIFont systemFontOfSize:14];
    [cell addSubview:name];
    
    UILabel *publish_time=[[UILabel alloc]initWithFrame:CGRectMake(200, 30, 120, 20)];
    publish_time.text=[_fakeData[indexPath.row] objectForKey:@"article_date"];
    publish_time.font=[UIFont systemFontOfSize:12];
    publish_time.textColor=[UIColor grayColor];
    [cell addSubview:publish_time];
    
    
    UILabel *publish_department=[[UILabel alloc]initWithFrame:CGRectMake(15, 30, 185, 20)];
    publish_department.text=[_fakeData[indexPath.row] objectForKey:@"article_source"];
    publish_department.font=[UIFont systemFontOfSize:12];
    publish_department.textColor=[UIColor grayColor];
    [cell addSubview:publish_department];
    labelline=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, 320, 1)];
    labelline.backgroundColor=[UIColor grayColor];
    [cell addSubview:labelline];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShiPinYaoPin_Dictionary = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
//    AXHSQDynamicDetailViewController *sqDetailVCtr = [[AXHSQDynamicDetailViewController alloc]initWithNibName:nil bundle:nil withDetailDict:dict];
//    [self.navigationController pushViewController:sqDetailVCtr animated:YES];
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
    return 70;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            startIndex = 0;
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[FoodMedicineHttpService alloc]init];
            sqHttpSer.strUrl = SheQuDongTai_m7_02;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 2:{
            [tableview headerEndRefreshing];
            [tableview footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"news_info"]];
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

-(void)fanhui
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
