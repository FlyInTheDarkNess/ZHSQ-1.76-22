//
//  OneBillTableViewController.m
//  ZHSQ
//
//  Created by lacom on 15/3/16.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "OneBillTableViewController.h"
#import "HttpPostExecutor.h"
#import "SBJsonParser.h"
#import "MyBill.h"
#import "SerializationComplexEntities.h"
#import "RegistrationAndLoginAndFindHttpService.h"
#import "Pay ViewController.h"
#import "QCheckBox.h"
extern NSString *Session;
extern NSString *Address_id;
extern NSString *Payment_url;
extern NSString *SheQuFuWu_Title;
extern NSString *charge_mode;

@interface OneBillTableViewController ()<HttpDataServiceDelegate,QCheckBoxDelegate>
{
    NSArray *itemTitleArr;
    NSArray *itemDetailArr;
    
    UIButton *jiaofeiBtn;//缴费按钮
    //请求
    RegistrationAndLoginAndFindHttpService *sqHttpSer;
}

@end

@implementation OneBillTableViewController
@synthesize detailDic;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStyleBordered target:self action:@selector(backToList)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    itemTitleArr = @[@"账单编号",@"收费单位",@"客户姓名",@"客户地址",@"建筑面积",@"缴费期间",@"基础金额",@"费用介绍",@"优惠金额",@"应缴金额",@"费用介绍2"];
    itemDetailArr = @[@"pay_id",@"property_name",@"username",@"客户地址",@"square",@"缴费期间",@"money1",@"detail",@"money2",@"money_sum",@"应缴金额 = 物业费 - 优惠金额"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return itemTitleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSString *str = [NSString stringWithFormat:@"row:%d",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    NSString *itemTitle = [NSString stringWithFormat:@"%@:",itemTitleArr[indexPath.row]];
    if ([itemTitle isEqualToString:@"客户地址:"]) {
        cell.textLabel.text = @"客户地址:";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",[detailDic objectForKey:@"community_name"],[detailDic objectForKey:@"quarter_name"],[detailDic objectForKey:@"building_name"],[detailDic objectForKey:@"unit_name"],[detailDic objectForKey:@"room_name"]];
    }else if([itemTitle isEqualToString:@"缴费期间:"]){
        cell.textLabel.text = @"缴费期间:";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",detailDic[@"period_start"],detailDic[@"peroid_end"]];
    }else if([itemTitle isEqualToString:@"费用介绍:"]){
        
        cell.textLabel.text = [NSString stringWithFormat:@"      %@",detailDic[@"detail"]];
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        cell.textLabel.textColor = [UIColor redColor];
    }else if([itemTitle isEqualToString:@"费用介绍2:"]){
        
        cell.textLabel.text = [NSString stringWithFormat:@"      %@",itemDetailArr[indexPath.row]];
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        cell.textLabel.textColor = [UIColor redColor];
    }else{
        cell.textLabel.text = itemTitle;
        NSString *detailKey = [NSString stringWithFormat:@"%@",itemDetailArr[indexPath.row]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",detailDic[detailKey]];
    }
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *itemTitle = [NSString stringWithFormat:@"%@:",itemTitleArr[indexPath.row]];
    if([itemTitle isEqualToString:@"费用介绍:"]){
        return 15;
    }else if([itemTitle isEqualToString:@"费用介绍2:"]){
        
        return 15;
    }else if([itemTitle isEqualToString:@"基础金额:"]){
        
        return 20;
    }else if([itemTitle isEqualToString:@"应缴金额2:"]){
        
        return 20;
    }
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString *FooterId = @"BillCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:FooterId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FooterId];
        NSString *pay_status = [NSString stringWithFormat:@"%@",detailDic[@"pay_status"]];
        /*
         判断当前账单是否为已付费账单或者捆绑账单
         */
        if ([pay_status isEqualToString:@"0"]&&[charge_mode integerValue]==0) {
            QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
            _check1.frame = CGRectMake(20, 0, 60, 40);
            [_check1 setTitle:@"同意" forState:UIControlStateNormal];
            [_check1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
            [cell.contentView addSubview:_check1];
            
           UIButton *XYBtn=[[UIButton alloc]initWithFrame:CGRectMake(60, 0, 100, 40)];
            [XYBtn setTitle:@"《支付服务协议》" forState:UIControlStateNormal];
            XYBtn.titleLabel.font=[UIFont systemFontOfSize:12];
            [XYBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [XYBtn addTarget:self action:@selector(pushToXieyiVC) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:XYBtn];

            jiaofeiBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 50, kViewwidth - 40, 44)];
            [jiaofeiBtn setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forState:UIControlStateNormal];
            jiaofeiBtn.layer.masksToBounds = YES;
            jiaofeiBtn.layer.cornerRadius = 6.0f;
            jiaofeiBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [jiaofeiBtn setTitle:@"缴费" forState:UIControlStateNormal];
            [jiaofeiBtn addTarget:self action:@selector(jiaofei:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:jiaofeiBtn];
            [_check1 setChecked:YES];
        }
            }
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 90;
}

/*
 单项缴费
 */
- (IBAction)jiaofei:(id)sender
{
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\"}"];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str1];
    [HttpPostExecutor postExecuteWithUrlStr:ipAddress_m1_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示:未能取得用户ip地址" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {
            NSString *string_Ip;
            NSLog(@"ip地址: %@", result);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:result error:&error];
            NSString *daima=[rootDic objectForKey:@"ecode"];
            int intString = [daima intValue];
            if (intString==4000)
            {
                [SVProgressHUD showErrorWithStatus:@"服务器内部错误" duration:1];
            }
            if (intString==1000)
            {
                string_Ip=[rootDic objectForKey:@"ip"];
            }
            NSLog(@"%@",string_Ip);
            MyBill *bill=[[MyBill alloc]init];
            bill.session=Session;
            bill.remark1=[NSString stringWithFormat:@"%@%@%@%@%@%@",[detailDic objectForKey:@"city_name"],[detailDic objectForKey:@"community_name"],[detailDic objectForKey:@"quarter_name"],[detailDic objectForKey:@"building_name"],[detailDic objectForKey:@"unit_name"],[detailDic objectForKey:@"room_name"]];
            bill.remark2=[NSString stringWithFormat:@"%@:", [detailDic objectForKey:@"username"]];
            bill.payment=[NSString stringWithFormat:@"%0.2f",[detailDic[@"money_sum"] floatValue]];
            NSString *jin=[NSString stringWithFormat:@"%0.2f",[detailDic[@"money_sum"] floatValue]];
            bill.property_id=[detailDic objectForKey:@"property_id"];
            
            bill.proinfo=[NSString stringWithFormat:@"笑脸社区综合缴费金额:%@",jin];
            
            bill.order_id=[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"pay_id"]];
            bill.ip=string_Ip;
            NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:bill childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
            
            
            NSLog(@"%@",str1);
            
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
            sqHttpSer.strUrl = ZongHeJiaoFei_c1_05;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
            
        }
        
        
    }];
}


- (void)didReceieveSuccess:(NSInteger)tag{
    NSLog(@"综合缴费:%@",sqHttpSer.responDict);
    NSString *str_tishi=[sqHttpSer.responDict objectForKey:@"ecode"];
    int intb = [str_tishi intValue];
    if (intb==1000)
    {
        
        //                NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
        //                [newsArr addObjectsFromArray:responArr];
        NSString *sss=[sqHttpSer.responDict objectForKey:@"url"];
        NSLog(@"&&&&&&&&&&&&&&&:%lu",(unsigned long)sss.length);
        //NSString * url=[NSString stringWithFormat:@"%@",sss];
        //NSString * url=[NSString stringWithUTF8String:sss];
        NSString *url =[sss stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        SheQuFuWu_Title=@"缴费";
        Payment_url=url;
        Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
        [self presentViewController:subViewVCtr animated:NO completion:nil];
    }

}

- (void)didReceieveFail:(NSInteger)tag{
    
}

/*
 *支付服务协议跳转
 */
- (void)pushToXieyiVC{
    SheQuFuWu_Title=@"支付服务协议";
    Payment_url=@"http://www.xiaolianshequ.cn/download/treaty.html";
    Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
    [self presentViewController:subViewVCtr animated:NO completion:nil];
}



//checkBox 点击事件
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    
    if (checked==0)
    {
        jiaofeiBtn.userInteractionEnabled=YES;
    }
    else
    {
        jiaofeiBtn.userInteractionEnabled=NO;
        
    }
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



//返回上一级页面
- (void)backToList{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
