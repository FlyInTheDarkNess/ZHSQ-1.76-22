//
//  SwitchAddressViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-1-14.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "SwitchAddressViewController.h"
#import "DengLuHouZhuYeViewController.h"
#import "PersonCenterHttpService.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "QieHuanZhuZhiXinXi.h"
#import "ZhuXiao.h"
#import "denglu.h"


extern NSString *Session;
extern NSString *LoginNum;
extern NSString *LoginPass;
extern NSString *community_id;
extern NSString *xiaoquIDString;
extern NSString *xiaoquming;
extern NSString *string_Account;
extern NSString *string_Password;
extern NSString *area_id;

/*
 添加全局属性
 */

extern NSString *Address_id;
extern NSString *charge_mode;
extern UserInfo *user;
@interface SwitchAddressViewController ()

{
    //主键ID
    NSArray *idList;
    //请求
    PersonCenterHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    //NSMutableArray *_fakeData;
    int startIndex;
    
    NSMutableArray *deleteArr;//删除列表
    
    BOOL isUp;
}

@end

@implementation SwitchAddressViewController
@synthesize type;

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
    deleteArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,320, 60)];
    image.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:image];
    label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    switch (type) {
        case 0:
            label.text=@"切换地址";
            break;
        case 1:
            label.text=@"删除地址";
            break;
            
        default:
            [[UIApplication sharedApplication].keyWindow makeToast:@"系统错误" duration:1.0f position:@"center"];
            [self dismissViewControllerAnimated:NO completion:nil];
            break;
    }
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    button=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fanhui:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *fabu=[[UIButton alloc]initWithFrame:CGRectMake(260, 20, 40, 40)];
    [fabu addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [fabu setTitle:@"完成" forState:UIControlStateNormal];
    fabu.titleLabel.textColor=[UIColor whiteColor];
    [self.view addSubview:fabu];

    
    startIndex = 0;
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, Width, Hidth - 60) style:UITableViewStylePlain];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview];
    
    [tableview addHeaderWithTarget:self action:@selector(dataInit)];
    // [tableview addFooterWithTarget:self action:@selector(addData)];
    [tableview headerBeginRefreshing];
    
    newsArr = [NSMutableArray array];

}
-(void)dataInit
{
    ZhuXiao*customer =[[ZhuXiao alloc]init];
    customer.session=Session;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
 
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService  alloc]init];
    sqHttpSer.strUrl = QieHuanXiaoQu_m1_13;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
}

#pragma mark - UITableView Delegate


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (newsArr.count>0)
    {
        UILabel *labelll=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, 280, 1)];
        labelll.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [cell addSubview:labelll];
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[newsArr[indexPath.row] objectForKey:@"community_name"],[newsArr[indexPath.row] objectForKey:@"quarter_name"],[newsArr[indexPath.row] objectForKey:@"building_name"],[newsArr[indexPath.row] objectForKey:@"unit_name"],[newsArr[indexPath.row] objectForKey:@"room_name"]];
        
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];//未选cell时的图片
        if ([[newsArr[indexPath.row] objectForKey:@"isdefaultshow"] isEqualToString:@"1"])
        {
            NSIndexPath *first = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            [tableview selectRowAtIndexPath:first animated:NO  scrollPosition:UITableViewScrollPositionBottom];
        }
        cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];
        cell.imageView.highlightedImage=[UIImage imageNamed:@"payeco_plugin_radiobt_bg_checked.png"];
        cell.selected = YES;
        
        
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (type) {
            //切换小区地址
        case 0:
        {
            /*
             UITableViewCell *cell=[tableview cellForRowAtIndexPath:indexPath];
             sss=cell.textLabel.text;
             str_address_id=[newsArr[indexPath.row] objectForKey:@"address_id"];
             */
            /*
             修改人 赵忠良
             修改时间 15.3.16 pm 1.44
             修改原因 小区切换无效
             */
            //*******************
            
            UITableViewCell *cell=[tableview cellForRowAtIndexPath:indexPath];
            sss=cell.textLabel.text;
            NSDictionary *Dic=[newsArr objectAtIndex:indexPath.row];
            Address_id=[Dic objectForKey:@"address_id"];
            charge_mode=[Dic objectForKey:@"charge_mode"];
            
            
            [SurveyRunTimeData sharedInstance].community_id = Dic[@"community_id"];
            [SurveyRunTimeData sharedInstance].quarter_id = Dic[@"quarter_id"];
            [SurveyRunTimeData sharedInstance].city_id =  Dic[@"city_id"];
            [SurveyRunTimeData sharedInstance].area_id = Dic[@"area_id"];
            
            xiaoquIDString=[Dic objectForKey:@"quarter_id"];
            xiaoquming=[Dic objectForKey:@"quarter_name"];
            community_id=[Dic objectForKey:@"community_id"];
            area_id=[Dic objectForKey:@"area_id"];
            NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:aaa forKey:@"dizhixinxi"];
            
            str_address_id=[Dic objectForKey:@"address_id"];
            [self tijiao];
            //********************
            
        }
            break;
            
        case 1:
        {
            
        }
            
        default:
            break;
    }


        /*
    
     */
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
-(void)tijiao
{
    QieHuanZhuZhiXinXi*customer =[[QieHuanZhuZhiXinXi alloc]init];
    customer.session=Session;
    customer.address_id=str_address_id;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];

    NSLog(@": %@", str1);
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService  alloc]init];
    sqHttpSer.strUrl = QieHuanZhuZhiXinXi_24_012;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;

}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 1:{
            NSString *a=sqHttpSer.responDict[@"ecode"];
            NSLog(@"    %@    \n ecode=%@",sqHttpSer.responDict,a);
            int intb = [a intValue];
            
            if (intb==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
                [tableview headerEndRefreshing];
                return ;
                
            }

            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"address_info"]];
            [newsArr addObjectsFromArray:responArr];
            [tableview headerEndRefreshing];
            [tableview reloadData];
            
        }
            break;
        case 2:
        {
            NSString *a=sqHttpSer.responDict[@"ecode"];
            NSLog(@"    %@    \n ecode=%@",sqHttpSer.responDict,a);

            int intb = [a intValue];
            
           if (intb==1000)
            {
                
                [SVProgressHUD showWithStatus:@"切换成功,正在更新用户数据..." maskType:SVProgressHUDMaskTypeClear];
                
                denglu*customer =[[denglu alloc]init];
                
                mima=[MyMD5 md5:string_Password];
                customer.password =mima;
                
                customer.username=string_Account;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                sqHttpSer = [[PersonCenterHttpService  alloc]init];
                sqHttpSer.strUrl = YongHuBangDingXinXi_m1_17;
                sqHttpSer.delegate = self;
                sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                [sqHttpSer beginQuery];
                isUp = YES;

                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"切换失败" duration:1];
            }

        }
            break;
        case 3:
        {
            NSString *a=sqHttpSer.responDict[@"ecode"];
            int intb = [a intValue];
            
            if (intb==1000)
            {
                [SVProgressHUD showSuccessWithStatus:@"更新成功" duration:1];
                arr_info=[[NSArray alloc]init];
                
                arr_info=[sqHttpSer.responDict objectForKey:@"address_info"];
                /*
                 修改时间 3.23
                 修改人 赵忠良
                 修改内容 添加存储用户信息的全局变量
                 */
                //**************************
                NSArray *person = [sqHttpSer.responDict objectForKey:@"person_info"];
                NSArray *car_info = [sqHttpSer.responDict objectForKey:@"car_info"];
                NSArray *jdh_info = [sqHttpSer.responDict objectForKey:@"jdh_info"];
                NSArray *address_info = [sqHttpSer.responDict objectForKey:@"address_info"];;
                user = [[UserInfo alloc]initWithPersonArr:person CarArr:car_info JdhArr:jdh_info AddressArr:address_info Session:[sqHttpSer.responDict objectForKey:@"session"]];
                //******************************
                arr_addressidentify=[[NSMutableArray alloc]init];
                for (int i=0; i<[arr_info count]; i++)
                {
                    NSString *string=[[arr_info objectAtIndex:i] objectForKey:@"isdefaultshow"];
                    [arr_addressidentify addObject:string];
                }
                if (arr_info.count>0)
                {
                    //判断数组中是否有1存在，有则就有默认住址，没有就选择第一个
                    if ([arr_addressidentify containsObject:@"1"])
                    {
                        for (int i=0; i<[arr_info count]; i++)
                        {
                            NSString *string=[[arr_info objectAtIndex:i] objectForKey:@"isdefaultshow"];
                            if ([string isEqualToString:@"1"])
                            {
                                /*
                                // NSLog(@"是  1");
                                NSDictionary *Dic=[arr_info objectAtIndex:i];
                                xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                                xiaoquming=[Dic objectForKey:@"quarter_name"];
                                community_id=[Dic objectForKey:@"community_id"];
                                area_id=[Dic objectForKey:@"area_id"];
                                NSLog(@"%@",community_id);
                               
                    
                                [SurveyRunTimeData sharedInstance].city_id =  Dic[@"city_id"];
                                [SurveyRunTimeData sharedInstance].quarter_id = Dic[@"quarter_id"];
                                [SurveyRunTimeData sharedInstance].area_id = Dic[@"area_id"];;
                                [SurveyRunTimeData sharedInstance].community_id = Dic[@"community_id"];
                                
                                NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                                
                                [userDefaults setObject:community_id forKey:@"community_id"];
                                [userDefaults synchronize];
                                 */
                                
                                /*
                                 
                                 */
                                //***********************
                                NSDictionary *Dic=[arr_info objectAtIndex:i];
                                Address_id=[Dic objectForKey:@"address_id"];
                                charge_mode=[Dic objectForKey:@"charge_mode"];
                                
                                
                                [SurveyRunTimeData sharedInstance].community_id = Dic[@"community_id"];
                                [SurveyRunTimeData sharedInstance].quarter_id = Dic[@"quarter_id"];
                                [SurveyRunTimeData sharedInstance].city_id =  Dic[@"city_id"];
                                [SurveyRunTimeData sharedInstance].area_id = Dic[@"area_id"];
                                
                                xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                                xiaoquming=[Dic objectForKey:@"quarter_name"];
                                community_id=[Dic objectForKey:@"community_id"];
                                area_id=[Dic objectForKey:@"area_id"];
                                NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                                [userDefaults synchronize];
                                //**************************
                            }
                            else
                            {
                                //NSLog(@"不是  1");
                            }
                        }
                        
                    }
                    else
                    {
                        NSDictionary *Dic=[arr_info objectAtIndex:0];
                        xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                        xiaoquming=[Dic objectForKey:@"quarter_name"];
                        NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                        [userDefaults setObject:xiaoquming forKey:@"xiaoqu"];
                        [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];
                        
                    }
                    
                    
                }
                DengLuHouZhuYeViewController *denglu=[[DengLuHouZhuYeViewController alloc]init];
                [self presentViewController:denglu animated:YES completion:nil];
              
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"更新失败" duration:1];
            }
          

        }
            break;

        default:
            break;
    }
    
}
-(void)didReceieveFail:(NSInteger)tag{
    [tableview headerEndRefreshing];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)fanhui:(id)sender
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
