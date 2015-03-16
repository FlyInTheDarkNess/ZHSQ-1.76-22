//
//  CommunityServiceViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "CommunityServiceViewController.h"
#import "RegistrationAndLoginAndFindHttpService.h"
#import "SerializationComplexEntities.h"
#import "ShangJiaXinXiViewController.h"

#import "zhujianliebiao.h"
extern NSDictionary *FUWUdtDictionary;
extern NSString *Session;
extern NSMutableArray *arr_shequfuwu;
extern NSMutableArray *arr_info_shequfuwu;
extern NSString *Type;
extern NSString *SheQuFuWu_Title;


@interface CommunityServiceViewController ()
{
    
    //主键ID
    NSArray *idList;
    //请求
    RegistrationAndLoginAndFindHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    //NSMutableArray *_fakeData;
    int startIndex;
    
    BOOL isUp;
}

@end

@implementation CommunityServiceViewController
@synthesize locationManager;
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
    startIndex = 0;
    
    self.view.backgroundColor=[UIColor colorWithRed:240/255.0 green:245/255.0 blue:245/255.0  alpha:1];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijingse];
    
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 35)];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label_title.text=SheQuFuWu_Title;
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 35, 35)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    [self.locationManager startUpdatingLocation];
    
    label_fanwei=[[UILabel alloc]initWithFrame:CGRectMake(10, 65, 140, 30)];
    label_fanwei.text=@"范围筛选";
    label_fanwei.font=[UIFont systemFontOfSize:14];
    label_fanwei.backgroundColor=[UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:label_fanwei];
    fanwei=@"0";
    arr_fanwei=[[NSMutableArray alloc]initWithObjects:@"全市(默认)",@"500米",@"1000米",@"2000米",@"5000米", nil];
    tableview_fanwei=[[UITableView alloc]initWithFrame:CGRectMake(30, 110, 260, 200)];
    tableview_fanwei.dataSource=self;
    tableview_fanwei.delegate=self;
    btn_fanwei=[[UIButton alloc]initWithFrame:CGRectMake(120, 70, 20, 20)];
    [btn_fanwei setImage:[UIImage imageNamed:@"triange0705.png"] forState:UIControlStateNormal];
    [btn_fanwei addTarget:self action:@selector(fanweisaixuan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_fanwei];
      
    label_paixu=[[UILabel alloc]initWithFrame:CGRectMake(170, 65, 140, 30)];
    label_paixu.text=@"排序规则";
    label_paixu.font=[UIFont systemFontOfSize:14];
    label_paixu.backgroundColor=[UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    [self.view addSubview:label_paixu];
    paixu=@"3";
    arr_paixu=[[NSMutableArray alloc]initWithObjects:@"距离(默认)",@"好评",@"优惠", nil];
    tableview_paixu=[[UITableView alloc]initWithFrame:CGRectMake(30, 210, 260, 120)];
    tableview_paixu.dataSource=self;
    tableview_paixu.delegate=self;
    btn_paixu=[[UIButton alloc]initWithFrame:CGRectMake(290, 70, 20, 20)];
    [btn_paixu setImage:[UIImage imageNamed:@"triange0705.png"] forState:UIControlStateNormal];
    [btn_paixu addTarget:self action:@selector(paixuguize) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_paixu];
    tableview_shangjia=[[UITableView alloc]initWithFrame:CGRectMake(0, 100, Width, Hidth-100)];
    tableview_shangjia.delegate=self;
    tableview_shangjia.dataSource=self;
    [self.view addSubview:tableview_shangjia];
    [tableview_shangjia addHeaderWithTarget:self action:@selector(dataInit)];
    [tableview_shangjia addFooterWithTarget:self action:@selector(addData)];
    [tableview_shangjia headerBeginRefreshing];
    
    
    newsArr = [NSMutableArray array];

}
- (void)dataInit
{
    arr_shequfuwu=[[NSMutableArray alloc]init];
    zhujianliebiao *customer =[[zhujianliebiao alloc]init];
    customer.city_id =@"101";
    customer.servicetype_id=Type;
    customer.distance_scope=fanwei;
    customer.sort_id = paixu;
    customer.latitude=@"";
    customer.longitude=@"";
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
    sqHttpSer.strUrl = SheQuFuWu_m3_08;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;

        

}
- (void)addData
{
    if (startIndex == idList.count) {
        [tableview_shangjia footerEndRefreshing];
        [tableview_shangjia setFooterHidden:YES];
        [SVProgressHUD showSuccessWithStatus:@"没有更多数据了!" duration:1.5];
        return;
        
    }
    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 5]];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
    sqHttpSer.strUrl = SheQuFuWu_m3_03;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = NO;

        
}
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:219/255.0 green:233/255.0 blue:255/255.0 alpha:1];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if ([tableView isEqual:tableview_fanwei])
    {
        cell.textLabel.text=arr_fanwei[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];
        cell.imageView.highlightedImage=[UIImage imageNamed:@"payeco_plugin_radiobt_bg_checked.png"];
    }
    if ([tableView isEqual:tableview_paixu])
    {
        cell.textLabel.text=arr_paixu[indexPath.row];
    }
    if ([tableView isEqual:tableview_shangjia])
    {
        //cell.textLabel.text=[_fakeData[indexPath.row] objectForKey:@"store_name"];
        NSString *image_url=[newsArr[indexPath.row] objectForKey:@"image_path"];
        NSData *date=[NSData dataWithContentsOfURL:[NSURL URLWithString:image_url]];
        if (date.length>0)
        {
            UIImageView *imagea=[[UIImageView alloc]init];
            imagea= [[UIImageView alloc]initWithFrame:CGRectMake(5, 1, 85,78)];
            imagea.tag = 1000;
            imagea.userInteractionEnabled=NO;
            [imagea setImageWithURL:[NSURL URLWithString:image_url]
                   placeholderImage:[UIImage imageNamed:@"xiaoqufuwu1"]
                            options:SDWebImageRetryFailed
        usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [cell.contentView addSubview:imagea];
            
            UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(95, 0, 220, 20)];
            labela.text=[newsArr[indexPath.row] objectForKey:@"store_name"];
            labela.font=[UIFont systemFontOfSize:14];
            labela.backgroundColor=[UIColor whiteColor];
            labela.textColor=[UIColor blackColor];
            [cell addSubview:labela];
            UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(95, 18, 220, 40)];
            labelb.text=[newsArr[indexPath.row] objectForKey:@"describtion"];
            labelb.backgroundColor=[UIColor whiteColor];
            labelb.numberOfLines=0;
            labelb.font=[UIFont systemFontOfSize:12];
            labelb.textColor=[UIColor grayColor];
            [cell addSubview:labelb];
            UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 58, 95, 20)];
            labelc.text=[newsArr[indexPath.row] objectForKey:@"phone"];
            labelc.backgroundColor=[UIColor whiteColor];
            labelc.font=[UIFont systemFontOfSize:12];
            labelc.textColor=[UIColor grayColor];
            [cell addSubview:labelc];
            UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(95, 58, 125, 20)];
            labeld.text=[newsArr[indexPath.row] objectForKey:@"store_master_name"];
            labeld.backgroundColor=[UIColor whiteColor];
            labeld.font=[UIFont systemFontOfSize:12];
            labeld.textColor=[UIColor grayColor];
            [cell addSubview:labeld];
            
        }
        if (date.length==0)
        {
            UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 310, 20)];
            labela.text=[newsArr[indexPath.row] objectForKey:@"store_name"];
            labela.font=[UIFont systemFontOfSize:14];
            labela.backgroundColor=[UIColor whiteColor];
            labela.textColor=[UIColor blackColor];
            [cell addSubview:labela];
            UILabel *labelb=[[UILabel alloc]initWithFrame:CGRectMake(5, 18, 310, 40)];
            labelb.text=[newsArr[indexPath.row] objectForKey:@"describtion"];
            labelb.backgroundColor=[UIColor whiteColor];
            labelb.numberOfLines=0;
            labelb.font=[UIFont systemFontOfSize:12];
            labelb.textColor=[UIColor grayColor];
            [cell addSubview:labelb];
            UILabel *labelc=[[UILabel alloc]initWithFrame:CGRectMake(220, 58, 95, 20)];
            labelc.text=[newsArr[indexPath.row] objectForKey:@"phone"];
            labelc.backgroundColor=[UIColor whiteColor];
            labelc.font=[UIFont systemFontOfSize:12];
            labelc.textColor=[UIColor grayColor];
            [cell addSubview:labelc];
            UILabel *labeld=[[UILabel alloc]initWithFrame:CGRectMake(5, 58, 215, 20)];
            labeld.text=[newsArr[indexPath.row] objectForKey:@"store_master_name"];
            labeld.backgroundColor=[UIColor whiteColor];
            labeld.font=[UIFont systemFontOfSize:12];
            labeld.textColor=[UIColor grayColor];
            [cell addSubview:labeld];
            
        }
        
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tableview_fanwei])
    {
        return arr_fanwei.count;
    }
    else if ([tableView isEqual:tableview_paixu])
    {
        return arr_paixu.count;
    }
    else
    {
        return newsArr.count;
    }
}
//返回多少个section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    @try
    {
        
        if ([tableView isEqual:tableview_fanwei]||[tableView isEqual:tableview_fenlei]||[tableView isEqual:tableview_paixu])
        {
            if ([tableView isEqual:tableview_fanwei])
            {
                if (indexPath.row==0)
                {
                    fanwei=@"0";
                }
                else if (indexPath.row==1)
                {
                    fanwei=@"500";
                }
                else if (indexPath.row==2)
                {
                    fanwei=@"1000";
                }
                else if(indexPath.row==3)
                {
                    fanwei=@"2000";
                }
                else
                {
                    fanwei=@"5000";
                }
                [tableview_fanwei removeFromSuperview];
                label_fanwei.text=arr_fanwei[indexPath.row];
            }
            if ([tableView isEqual:tableview_paixu])
            {
                if (indexPath.row==0)
                {
                    paixu=@"3";
                }
                else if (indexPath.row==1)
                {
                    paixu=@"1";
                }
                else
                {
                    paixu=@"2";
                }
                [tableview_paixu removeFromSuperview];
                label_paixu.text=arr_paixu[indexPath.row];
            }
            [arr_shequfuwu removeAllObjects];
           
            zhujianliebiao *customer =[[zhujianliebiao alloc]init];
            customer.city_id =@"101";
            customer.servicetype_id=Type;
            customer.distance_scope=fanwei;
            customer.sort_id =paixu;
            customer.latitude=weidu;
            customer.longitude=jingdu;

            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
            sqHttpSer.strUrl = SheQuFuWu_m3_08;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            isUp = YES;
            

        }
        else
        {
            if ([tableView isEqual:tableview_shangjia])
            {
                FUWUdtDictionary=newsArr[indexPath.row];
                // NSLog(@">>>>>>>>>       %@",FUWUdtDictionary);
                ShangJiaXinXiViewController *fuwu=[[ShangJiaXinXiViewController alloc]init];
                [self presentViewController:fuwu animated:NO completion:nil];
                
            }
            
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tableview_fanwei]||[tableView isEqual:tableview_fenlei]||[tableView isEqual:tableview_paixu])
    {
        return 40;
    }
    else
    {
        return 80;
    }
}

-(void)fanweisaixuan
{
    [self.view addSubview:tableview_fanwei];
}
-(void)paixuguize
{
    [self.view addSubview:tableview_paixu];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * currLocation = [locations lastObject];
    
    jingdu= [NSString stringWithFormat:@"%3.5f",currLocation.coordinate.latitude];
    weidu= [NSString stringWithFormat:@"%3.5f",currLocation.coordinate.longitude];
    [locationManager stopUpdatingLocation];
    // NSLog(@"location ok  %@  %@",jingdu,weidu);
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error

{
    
    NSLog(@"error: %@",error);
    
}

#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 6:{
            NSLog(@"%@",sqHttpSer.responDict);
            int inta = [[sqHttpSer.responDict objectForKey:@"ecode"] intValue];
            
            if (inta==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                return;
                
            }
            else if (inta==4000)
            {
                [SVProgressHUD showErrorWithStatus:@"服务器故障" duration:1];
                return;
                
            }
            startIndex = 0;
            NSLog(@"%@",sqHttpSer.responDict);
            idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
            NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber: startIndex + 10]];
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
            sqHttpSer.strUrl = SheQuFuWu_m3_03;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];

        }
            break;
        case 7:{
            NSLog(@"%@",sqHttpSer.responDict);
            [tableview_shangjia headerEndRefreshing];
            [tableview_shangjia footerEndRefreshing];

            NSString *str_tishi=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intb=[str_tishi intValue];
            if (intb==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                return;

            }
            if (isUp) {
                [newsArr removeAllObjects];
            }
            NSLog(@"%@",sqHttpSer.responDict);
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"wufu_info"]];
            [newsArr addObjectsFromArray:responArr];
            [tableview_shangjia reloadData];
            
            
        }
            break;
        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag
{
    
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
