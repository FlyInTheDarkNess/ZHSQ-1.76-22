//
//  CommunityTelViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-21.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "CommunityTelViewController.h"
#import "PersonCenterHttpService.h"
#import "SerializationComplexEntities.h"
@interface CommunityTelViewController ()
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

@implementation CommunityTelViewController

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
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];
    
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.text=@"便民电话";
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.textAlignment=NSTextAlignmentCenter;
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    btn_fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [btn_fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [btn_fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_fanhui];
    mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth - 60) style:UITableViewStylePlain];
    mytableview.backgroundColor = [UIColor whiteColor];
    mytableview.delegate = self;
    mytableview.dataSource = self;
    [self.view addSubview:mytableview];
    
    [mytableview addHeaderWithTarget:self action:@selector(dataInit)];
    [mytableview headerBeginRefreshing];
    
    newsArr = [NSMutableArray array];

}
-(void)dataInit
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *myString = [userDefaultes stringForKey:@"xiaoquID"];

    xiaoqubibei*customer =[[xiaoqubibei alloc]init];
    
    customer.quarter_id =myString;
    
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = XiaoQuBiBei_m27_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=nil;
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableSampleIdentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview]; //删除并进行重新分配
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(20, 3, 300, 20)];
    name.text=[newsArr[indexPath.row] objectForKey:@"necessary_info_name"];
    name.font=[UIFont systemFontOfSize:14];
    [cell addSubview:name];
    
    UILabel *publish_time=[[UILabel alloc]initWithFrame:CGRectMake(40, 30, 280, 20)];
    publish_time.text=[newsArr[indexPath.row] objectForKey:@"necessary_info_phone"];
    publish_time.font=[UIFont systemFontOfSize:14];
    publish_time.textColor=[UIColor blueColor];
    [cell addSubview:publish_time];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(260, 5, 40, 40)];
    imageview.image=[UIImage imageNamed:@"phone.png"];
    [cell addSubview:imageview];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *number =[newsArr[indexPath.row] objectForKey:@"necessary_info_phone"];// 此处读入电话号码
    
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return newsArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 11:{
    
            NSLog(@"%@",sqHttpSer.responDict);
            NSString *daima=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intString = [daima intValue];
            if (intString==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
                [mytableview headerEndRefreshing];
                
                return;
                
            }
            
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
            XiaoQuBiBeiXinXi*custo=[[XiaoQuBiBeiXinXi alloc]init];
            NSArray *workItems = [[NSArray alloc]initWithArray:idList];
            custo.id_list=workItems;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:custo childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class], nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class], nil] ];

            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[PersonCenterHttpService alloc]init];
            sqHttpSer.strUrl = XiaoQuBiBei_m27_02;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
            break;
        case 12:{
            [mytableview headerEndRefreshing];
            [mytableview footerEndRefreshing];
            
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSLog(@"%@",sqHttpSer.responDict);
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
            [newsArr addObjectsFromArray:responArr];
            [mytableview reloadData];
            
        }
            break;
        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag{
    [mytableview headerEndRefreshing];
    [mytableview footerEndRefreshing];
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
