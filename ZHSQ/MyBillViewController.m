//
//  MyBillViewController.m
//  ZHSQ
//
//  Created by 赵贺 on 15-3-11.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "MyBillViewController.h"
#import "RegistrationAndLoginAndFindHttpService.h"
#import "JiaoFeiCanShu.h"
#import "MyBillTableViewCell.h"

#import "JiaoFei.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Pay ViewController.h"
#import "MyBill.h"
extern NSString *Session;
extern NSString *Address_id;
extern NSString *Payment_url;
extern NSString *SheQuFuWu_Title;
extern NSString *charge_mode;
@interface MyBillViewController ()
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

@implementation MyBillViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    
    UILabel *label_beijing=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
    label_beijing.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_beijing];
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label_title.text=@"我的账单";
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.textColor=[UIColor whiteColor];
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(5, 20, 40, 40)];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    
    y=YES;
    btn_weijiaofeizhangdan=[[UIButton alloc]initWithFrame:CGRectMake(0, 60, 160, 30)];
    [btn_weijiaofeizhangdan setTitle:@"未缴账单" forState:UIControlStateNormal];
    btn_weijiaofeizhangdan.titleLabel.font=[UIFont systemFontOfSize:14];
    btn_weijiaofeizhangdan.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [btn_weijiaofeizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn_weijiaofeizhangdan addTarget:self action:@selector(weijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_weijiaofeizhangdan];
    btn_lishizhangdan=[[UIButton alloc]initWithFrame:CGRectMake(160, 60, 160, 30)];
    [btn_lishizhangdan setTitle:@"历史账单" forState:UIControlStateNormal];
    btn_lishizhangdan.titleLabel.font=[UIFont systemFontOfSize:14];
    btn_lishizhangdan.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    [btn_lishizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_lishizhangdan addTarget:self action:@selector(lishi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_lishizhangdan];
    
    total_label=[[UILabel alloc]initWithFrame:CGRectMake(kViewwidth/2, kViewHeight-110, kViewwidth/2, 30)];
    total_label.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:total_label];
    
    QCheckBox *_check1 = [[QCheckBox alloc] initWithDelegate:self];
    _check1.frame = CGRectMake(20, kViewHeight-80, 60, 40);
    [_check1 setTitle:@"同意" forState:UIControlStateNormal];
    [_check1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_check1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.view addSubview:_check1];
    [_check1 setChecked:YES];
    label=[[UILabel alloc]initWithFrame:CGRectMake(60, kViewHeight-80, 200, 40)];
    label.text=@"《支付服务协议》";
    label.font=[UIFont systemFontOfSize:12];
    label.textColor=[UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:label];
    
    Pay_btn=[[UIButton alloc]initWithFrame:CGRectMake(20, kViewHeight-40, kViewwidth-40, 40)];
    Pay_btn.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [Pay_btn setTitle:@"缴费" forState:UIControlStateNormal];
    [Pay_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Pay_btn.layer.masksToBounds=YES;
    Pay_btn.layer.cornerRadius=6;
    Pay_btn.titleLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:Pay_btn];
    
    newsArr = [NSMutableArray array];
    Type_Arr= [NSMutableArray array];
    
    MyBliiTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, kViewwidth, kViewHeight-210) style:UITableViewStylePlain];
    MyBliiTableview.delegate = self;
    MyBliiTableview.dataSource = self;
    str_Status=@"weijiaofei";
    [self.view addSubview:MyBliiTableview];
    
    [MyBliiTableview addHeaderWithTarget:self action:@selector(ltDataInit)];
  
    [MyBliiTableview headerBeginRefreshing];
   }
-(void)ltDataInit
{
    PayStatus=@"wuyefei";
    
    [newsArr removeAllObjects];
    NSString *str1;
    if ([str_Status isEqualToString:@"weijiaofei"])
    {
        str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"2\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
    }
    if ([str_Status isEqualToString:@"yijiaofei"])
    {
        str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"2\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
    }
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
    sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    isUp = YES;
}
-(void)weijiao
{
    MyBliiTableview.frame=CGRectMake(0, 100, kViewwidth, kViewHeight-210);
    [btn_lishizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_weijiaofeizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    PayStatus=@"wuyefei";
    str_Status=@"weijiaofei";
    [newsArr removeAllObjects];
    [Type_Arr removeAllObjects];
    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"2\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
    sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
  

}
-(void)lishi
{
    MyBliiTableview.frame=CGRectMake(0, 100, kViewwidth, kViewHeight-100);
    [btn_lishizhangdan setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn_weijiaofeizhangdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    str_Status=@"yijiaofei";
    PayStatus=@"wuyefei";
    [newsArr removeAllObjects];
    [Type_Arr removeAllObjects];
  //  NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"2\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];

    NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"2\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
    sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
}

#pragma mark - UITableView Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier=@"MyBillTableViewCell";
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
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
   
    UILabel *zhongleiLab = (UILabel *)[cell.contentView viewWithTag:1];
    NSString *strr=Type_Arr[indexPath.row];
    NSLog(@"%@",Type_Arr);
    if ([strr isEqualToString:@"1"])
    {
         zhongleiLab.text =@"水费";
    }
    if ([strr isEqualToString:@"2"])
    {
         zhongleiLab.text =@"物业费";
    }
    if ([strr isEqualToString:@"3"])
    {
         zhongleiLab.text =@"暖气费";
    }
    if ([strr isEqualToString:@"4"])
    {
         zhongleiLab.text =@"停车管理费";
    }
   
    
    UILabel *bianhaoLab = (UILabel *)[cell.contentView viewWithTag:2];
    bianhaoLab.text = [dic objectForKey:@"pay_id"];
    
    UILabel *xingmingLab = (UILabel *)[cell.contentView viewWithTag:3];
    xingmingLab.text = [dic objectForKey:@"username"];
    
    UILabel *dizhiLab = (UILabel *)[cell.contentView viewWithTag:4];
    dizhiLab.text =[NSString stringWithFormat:@"%@%@%@%@%@",[dic objectForKey:@"community_name"],[dic objectForKey:@"quarter_name"],[dic objectForKey:@"building_name"],[dic objectForKey:@"unit_name"],[dic objectForKey:@"room_name"]];
    UILabel *qijianLab = (UILabel *)[cell.contentView viewWithTag:5];
    qijianLab.text =[NSString stringWithFormat:@"%@-%@", [dic objectForKey:@"period_start"],[dic objectForKey:@"peroid_end"]];
    
    UILabel *jineLab = (UILabel *)[cell.contentView viewWithTag:6];
    jineLab.text = [dic objectForKey:@"money_sum"];
    if ([str_Status isEqualToString:@"weijiaofei"])
    {
        seckillBtn = (AXHButton *)[cell.contentView viewWithTag:7];
        NSInteger a=indexPath.row;
        seckillBtn.tag=a;
        [seckillBtn setBackgroundImage:[UIImage imageNamed:@"checkc.png"] forState:UIControlStateNormal];
        [seckillBtn addTarget:self action:@selector(xuanzhe:) forControlEvents:UIControlEventTouchUpInside];
    }
    

    
    
    return cell;
    
}
-(void)xuanzhe:(AXHButton *)btn
{
    
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    seckillBtn.tag=indexPath.row;
//    if ([charge_mode isEqualToString:@"0"])
//    {
//        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:newsArr[indexPath.row]];
//        if (y==YES)
//        {
//            [seckillBtn setBackgroundImage:[UIImage imageNamed:@"checknull.png"] forState:UIControlStateNormal];
//            
//            if (JinE>0)
//            {
//                JinE=JinE-[[dic objectForKey:@"money_sum"] floatValue];
//                total_label.text=[NSString stringWithFormat:@"金额(元): %0.2f",JinE];
//            }
//            
//            y=NO;
//            return;
//        }
//        if (y==NO)
//        {
//            [seckillBtn setBackgroundImage:[UIImage imageNamed:@"checkc.png"] forState:UIControlStateNormal];
//            JinE=JinE+[[dic objectForKey:@"money_sum"] floatValue];
//            total_label.text=[NSString stringWithFormat:@"金额(元): %0.2f",JinE];
//            y=YES;
//            return;
//        }
//    }

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
    //    NSDictionary *flowTraceDict = [NSDictionary dictionaryWithDictionary:postArr[indexPath.row]];
    //    return [AXHSQForumCell handCellHeight:flowTraceDict].frame.size.height;
    return 150;
}
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked
{
    
    if (checked==0)
    {
        Pay_btn.userInteractionEnabled=YES;
        [Pay_btn addTarget:self action:@selector(jiaofei) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        Pay_btn.userInteractionEnabled=NO;
        
    }
}
-(void)jiaofei
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
            bill.remark1=[NSString stringWithFormat:@"用户住址:%@%@%@%@%@%@",[newsArr[0] objectForKey:@"city_name"],[newsArr[0] objectForKey:@"community_name"],[newsArr[0] objectForKey:@"quarter_name"],[newsArr[0] objectForKey:@"building_name"],[newsArr[0] objectForKey:@"unit_name"],[newsArr[0] objectForKey:@"room_name"]];
            bill.remark2=[NSString stringWithFormat:@"%@:", [newsArr[0] objectForKey:@"username"]];
            bill.payment=[NSString stringWithFormat:@"%0.1f",JinE];
            NSString *jin=[NSString stringWithFormat:@"%0.1f",JinE];
            bill.property_id=[newsArr[0] objectForKey:@"property_id"];
            
            bill.proinfo=[NSString stringWithFormat:@"笑脸社区综合缴费金额:%@",jin];
            
            bill.order_id=[NSString stringWithFormat:@"%@",[newsArr[0] objectForKey:@"pay_id"]];
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
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
            
        case 12:{
            //缴费账单主键
            NSLog(@"主键id:%@      %@",sqHttpSer.responDict,PayStatus);
            NSString *str_tishi=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intb = [str_tishi intValue];

            if ([PayStatus isEqualToString:@"tingchefei"])
            {
                if (intb==1000)
                {
                    startIndex=0;
                    idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
                    for (int i=0; i<idList.count;i++ )
                    {
                        [Type_Arr addObject:@"4"];
                    }

                    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber:idList.count]];
                    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                    sqHttpSer.strUrl = TingCheFei_m30_05;
                    sqHttpSer.delegate = self;
                    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                    [sqHttpSer beginQuery];
                }
                else
                {
                    float sum=0;
                    for (int j=0; j<newsArr.count; j++)
                    {
                        NSString *jine=[newsArr[j] objectForKey:@"money_sum"];
                        float J=[jine intValue];
                        sum=sum+J;
                    }
                    JinE=sum;
                    
                    total_label.text=[NSString stringWithFormat:@"金额(元): %0.2f",JinE];
                    NSLog(@"数组:%@",newsArr);
                    [MyBliiTableview reloadData];
                    if (newsArr.count==0)
                    {
                        [MyBliiTableview headerEndRefreshing];
                        [MyBliiTableview footerEndRefreshing];
                        
                        [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                        return;
                        
                    }
                    
                    [MyBliiTableview headerEndRefreshing];
                    [MyBliiTableview footerEndRefreshing];
                    
                }
            }
            
            if ([PayStatus isEqualToString:@"nuanqifei"])
            {
                if (intb==1000)
                {
                    startIndex=0;
                   
                    idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
                    for (int i=0; i<idList.count;i++ )
                    {
                        [Type_Arr addObject:@"3"];
                    }
                    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber:idList.count]];
                    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                    sqHttpSer.strUrl = NuanQiFei_m30_04;
                    sqHttpSer.delegate = self;
                    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                    [sqHttpSer beginQuery];
                }
                else
                {
                    PayStatus=@"tingchefei";
                    NSString *str1;
                    if ([str_Status isEqualToString:@"weijiaofei"])
                    {
                        str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"4\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
                    }
                    if ([str_Status isEqualToString:@"yijiaofei"])
                    {
                        str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"4\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
                    }
                    
                    //NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"3\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\"}",Session];
                    // NSLog(@"停车费参数：%@",str1);
                    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                    sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
                    sqHttpSer.delegate = self;
                    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                    [sqHttpSer beginQuery];
                }
                
                
                
            }
            if ([PayStatus isEqualToString:@"shuifei"])
            {
                if (intb==1000)
                {
                    startIndex=0;
                    NSLog(@"%d",idList.count);
                  
                    idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
                    for (int i=0; i<idList.count;i++ )
                    {
                        [Type_Arr addObject:@"1"];
                    }
                    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber:idList.count]];
                    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                    sqHttpSer.strUrl = ShuiFei_m30_03;
                    sqHttpSer.delegate = self;
                    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                    [sqHttpSer beginQuery];
                }
                else
                {
                    PayStatus=@"nuanqifei";
                    NSString *str1;
                    if ([str_Status isEqualToString:@"weijiaofei"])
                    {
                        str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"3\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
                    }
                    if ([str_Status isEqualToString:@"yijiaofei"])
                    {
                        str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"3\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
                    }
                    
                    // NSString *str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"3\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\"}",Session];
                    // NSLog(@"暖气费参数：%@",str1);
                    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                    sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
                    sqHttpSer.delegate = self;
                    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                    [sqHttpSer beginQuery];
                }
                
                
                
            }

            
            
            if ([PayStatus isEqualToString:@"wuyefei"])
            {
                if (intb==1000)
                {
                    startIndex=0;
                    idList = [NSArray arrayWithArray:sqHttpSer.responDict[@"id_list"]];
                    for (int i=0; i<idList.count;i++ )
                    {
                        [Type_Arr addObject:@"2"];
                    }
                    NSString *str1=[NSString stringWithFormat:@"{\"id_list\":%@}",[self getFromArr:idList withNumber:idList.count]];
                    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                    sqHttpSer.strUrl = WuYeFei_m30_02;
                    sqHttpSer.delegate = self;
                    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                    [sqHttpSer beginQuery];
                }
                else
                {
                    PayStatus=@"shuifei";
                    NSString *str1;
                    if ([str_Status isEqualToString:@"weijiaofei"])
                    {
                       // str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"1\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\"}",Session];
                        str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"1\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
                    }
                    if ([str_Status isEqualToString:@"yijiaofei"])
                    {
                       // str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"1\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\"}",Session];
                        str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"1\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
                    }
                   // NSLog(@"水费参数：%@",str1);
                    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
                    sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
                    sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
                    sqHttpSer.delegate = self;
                    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
                    [sqHttpSer beginQuery];
                }
                
            }
            
            
            
            
        }
            break;
        case 13:{
            //缴费账单-物业费
            startIndex=0;
//            if (isUp) {
//                [newsArr removeAllObjects];
//            }
            NSLog(@"我的物业费:%@",sqHttpSer.responDict);
            NSString *str_tishi=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intb = [str_tishi intValue];
            if (intb==1000)
            {

            NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
            [newsArr addObjectsFromArray:responArr];
            }
            PayStatus=@"shuifei";
            NSString *str1;
            if ([str_Status isEqualToString:@"weijiaofei"])
            {
                str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"1\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
            }
            if ([str_Status isEqualToString:@"yijiaofei"])
            {
                str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"1\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
            }
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
            sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
        }
            break;
        case 14:{
            //缴费账单-水费
            startIndex=0;
            NSLog(@"我的水费:%@",sqHttpSer.responDict);
            
            NSString *str_tishi=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intb = [str_tishi intValue];
            if (intb==1000)
            {
                
                NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
                [newsArr addObjectsFromArray:responArr];
            }

            PayStatus=@"nuanqifei";
            NSString *str1;
            if ([str_Status isEqualToString:@"weijiaofei"])
            {
                str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"3\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
            }
            if ([str_Status isEqualToString:@"yijiaofei"])
            {
                str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"3\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];
            }
            
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
            sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
        }
            break;
        case 15:{
            //缴费账单-暖气费
           startIndex=0;
            NSLog(@"我的暖气费:%@",sqHttpSer.responDict);
            
            NSString *str_tishi=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intb = [str_tishi intValue];
            if (intb==1000)
            {
                
                NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
                [newsArr addObjectsFromArray:responArr];
            }
            
            PayStatus=@"tingchefei";
            
            NSString *str1;
            if ([str_Status isEqualToString:@"weijiaofei"])
            {
                str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"3\",\"flag\":\"2\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];

            }
            if ([str_Status isEqualToString:@"yijiaofei"])
            {
                str1=[NSString stringWithFormat:@"{\"session\":%@,\"type\":\"3\",\"flag\":\"1\",\"date_start\":\"\",\"date_end\":\"\",\"address_id\":\"%@\"}",Session,Address_id];

            }
            NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
            sqHttpSer = [[RegistrationAndLoginAndFindHttpService alloc]init];
            sqHttpSer.strUrl = KuaiJieJiaoFeiZhuJian_m30_01;
            sqHttpSer.delegate = self;
            sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
            [sqHttpSer beginQuery];
        }
            break;
        case 16:{
            //缴费账单-停车费
            NSLog(@"我的停车费:%@",sqHttpSer.responDict);
                       
            NSString *str_tishi=[sqHttpSer.responDict objectForKey:@"ecode"];
            int intb = [str_tishi intValue];
            if (intb==1000)
            {
                
                NSArray *responArr = [NSArray arrayWithArray:sqHttpSer.responDict[@"info"]];
                [newsArr addObjectsFromArray:responArr];
            }

            if (newsArr.count==0)
            {
                

                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                return;

            }
            [MyBliiTableview headerEndRefreshing];
            [MyBliiTableview footerEndRefreshing];
            [MyBliiTableview reloadData];
            float sum=0;
            for (int j=0; j<newsArr.count; j++)
            {
                NSString *jine=[newsArr[j] objectForKey:@"money_sum"];
                float J=[jine intValue];
                sum=sum+J;
            }
            JinE=sum;
            
            total_label.text=[NSString stringWithFormat:@"金额(元): %0.2f",JinE];

            }
            break;
        case 18:{
            //综合缴费
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
            
            if (newsArr.count==0)
            {
                [MyBliiTableview headerEndRefreshing];
                [MyBliiTableview footerEndRefreshing];
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                return;
                
            }
            [MyBliiTableview reloadData];
            float sum=0;
            for (int j=0; j<newsArr.count; j++)
            {
                NSString *jine=[newsArr[j] objectForKey:@"money_sum"];
                float J=[jine intValue];
                sum=sum+J;
            }
            JinE=sum;
            total_label.text=[NSString stringWithFormat:@"金额(元): %0.2f",JinE];
            }
            break;
       
        default:
            break;
    }
}
-(void)didReceieveFail:(NSInteger)tag{
    [MyBliiTableview headerEndRefreshing];
    [MyBliiTableview footerEndRefreshing];
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


@end
