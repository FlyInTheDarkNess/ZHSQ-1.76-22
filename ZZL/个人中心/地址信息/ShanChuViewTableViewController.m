//
//  ShanChuViewTableViewController.m
//  ZHSQ
//
//  Created by 赵中良 on 15/3/19.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "ShanChuViewTableViewController.h"
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
@interface ShanChuViewTableViewController ()<HttpDataServiceDelegate>{
    NSMutableArray *arr_addressidentify;
    //接口内地址信息
    NSMutableArray *addressList;
    //主键ID
    NSArray *idList;
    //请求
    PersonCenterHttpService *sqHttpSer;
    //当前列表数据
    NSMutableArray *newsArr;
    //NSMutableArray *_fakeData;
    int startIndex;
    
    NSMutableArray *deleteArr;//删除列表
}

@end

@implementation ShanChuViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"删除住址";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStyleBordered target:self action:@selector(fanhui:)];
    
    //初始化成员变量
    deleteArr = [NSMutableArray array];
    newsArr = [NSMutableArray array];
    addressList = [NSMutableArray array];
    //设置footerView
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //加载数据
    [self dataInit];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
 加载数据
 */
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return addressList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"ShanChu";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (addressList.count>0)
    {
        NSDictionary *dic = addressList[indexPath.row];
        UILabel *labelll=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, 280, 1)];
        labelll.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [cell addSubview:labelll];
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[addressList[indexPath.row] objectForKey:@"community_name"],[addressList[indexPath.row] objectForKey:@"quarter_name"],[addressList[indexPath.row] objectForKey:@"building_name"],[addressList[indexPath.row] objectForKey:@"unit_name"],[addressList[indexPath.row] objectForKey:@"room_name"]];
        
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        UIImageView *imV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
        cell.accessoryView = imV;
        
        NSString *addressId = [NSString stringWithFormat:@"%@",dic[@"address_id"]];
        
        for (NSDictionary *tDic in deleteArr) {
//            NSLog(@" deleteArr:%@",deleteArr);
            NSString *tAddressId = [NSString stringWithFormat:@"%@",tDic[@"id"]];
            if ([tAddressId isEqualToString:addressId]) {
                NSLog(@"str对比：%@:%@",tAddressId,addressId);
                imV.image=[UIImage imageNamed:@"chec.png"];//选中cell时的图片
                return cell;
            }
        }
        imV.image=[UIImage imageNamed:@"checno.png"];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1.5];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //取消当前cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     判断是否删除数组中是否存在当前住址
     */
    
    NSDictionary *dic = addressList[indexPath.row];
    NSString *addressId = [NSString stringWithFormat:@"%@",dic[@"address_id"]];
    for (NSDictionary *tDic in deleteArr) {
        NSString *tAddressId = [NSString stringWithFormat:@"%@",tDic[@"id"]];
        if ([addressId isEqualToString:tAddressId]) {
            [deleteArr removeObject:tDic];
//            NSLog(@"deletearr:%@",deleteArr);
            [self.tableView reloadData];
            return;
        }
    }
    NSDictionary *aDic = [NSDictionary dictionaryWithObject:addressId forKey:@"id"];
    [deleteArr addObject:aDic];
    [self.tableView reloadData];
    if (deleteArr.count > 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteAddress)];
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

/*
 删除住址信息
 */
-(void)deleteAddress
{
    //删除最后一个地址信息的判断
    if (addressList.count == 1) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"账号至少要绑定一个地址信息" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:Session,@"session",deleteArr,@"id_list",nil];
    NSString *str = [self dictionaryToJson:dic];
    NSString *str_jiami = [SurveyRunTimeData hexStringFromString:str];
    NSLog(@"删除住址；加密前%@",str);
    sqHttpSer = [[PersonCenterHttpService  alloc]init];
    sqHttpSer.strUrl = ShanChuZhuZhiXinXi_m24_13;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    
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
                
                return ;
                
            }
            
            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"address_info"]];
            [addressList addObjectsFromArray:responArr];
            [self.tableView reloadData];
            
        }
            break;
        case 27:
        {
            NSString *a=sqHttpSer.responDict[@"ecode"];
            NSLog(@"    %@    \n ecode=%@",sqHttpSer.responDict,a);
            
            int intb = [a intValue];
            
            if (intb==1000)
            {
                
                [SVProgressHUD showWithStatus:@"删除成功,正在更新用户数据..." maskType:SVProgressHUDMaskTypeClear];
                
                denglu*customer =[[denglu alloc]init];
                
                NSString *mima=[MyMD5 md5:string_Password];
                customer.password =mima;
                
                customer.username=string_Account;
                NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                sqHttpSer = [[PersonCenterHttpService  alloc]init];
                sqHttpSer.strUrl = YongHuBangDingXinXi_m1_17;
                sqHttpSer.delegate = self;
                sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                [sqHttpSer beginQuery];
                
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"删除失败" duration:1];
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
                [addressList removeAllObjects];
                /*
                 修改时间 3.23
                 修改人 赵忠良
                 修改内容 添加存储用户信息的全局变量
                 */
                //**************************
                NSArray *person = [sqHttpSer.responDict objectForKey:@"person_info"];
                NSArray *car_info = [sqHttpSer.responDict objectForKey:@"car_info"];
                NSArray *jdh_info = [sqHttpSer.responDict objectForKey:@"jdh_info"];
                NSArray *address_info = [sqHttpSer.responDict objectForKey:@"address_info"];
                user = [[UserInfo alloc]initWithPersonArr:person CarArr:car_info JdhArr:jdh_info AddressArr:address_info Session:[sqHttpSer.responDict objectForKey:@"session"]];
                //******************************
                NSArray *arr=[sqHttpSer.responDict objectForKey:@"address_info"];
                [addressList addObjectsFromArray:arr];
                arr_addressidentify=[[NSMutableArray alloc]init];
                for (int i=0; i<[addressList count]; i++)
                {
                    NSString *string=[[addressList objectAtIndex:i] objectForKey:@"isdefaultshow"];
                    [arr_addressidentify addObject:string];
                }
                if (addressList.count>0)
                {
                    //判断数组中是否有1存在，有则就有默认住址，没有就选择第一个
                    if ([arr_addressidentify containsObject:@"1"])
                    {
                        for (int i=0; i<[addressList count]; i++)
                        {
                            NSString *string=[[addressList objectAtIndex:i] objectForKey:@"isdefaultshow"];
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
                                NSDictionary *Dic=[addressList objectAtIndex:i];
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
                        
                        NSDictionary *Dic=[addressList objectAtIndex:0];
                        xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                        xiaoquming=[Dic objectForKey:@"quarter_name"];
                        NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                        [userDefaults setObject:xiaoquming forKey:@"xiaoqu"];
                        [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];
                        
                    }
                    
                    
                }
                else{
                    //如果登陆没有数据该怎么办
                    Address_id=@"";
                    charge_mode=@"";
                    
                    
                    [SurveyRunTimeData sharedInstance].community_id = @"";
                    [SurveyRunTimeData sharedInstance].quarter_id = @"";
                    [SurveyRunTimeData sharedInstance].city_id =  @"";
                    [SurveyRunTimeData sharedInstance].area_id = @"";
                    
                    xiaoquIDString=@"";
                    xiaoquming=@"";
                    community_id=@"";
                    area_id=@"";
                    NSString *aaa=@"添加地址信息";
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                    [userDefaults synchronize];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您当前没有绑定地址信息，请点击添加地址" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        [alert show];
                    });
                    
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
    [self.tableView reloadData];
}

- (void)fanhui:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
 *转换json语句为NSString
 */
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
