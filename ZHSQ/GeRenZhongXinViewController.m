//
//  GeRenZhongXinViewController.m
//  ZHSQ
//
//  Created by lacom on 14-5-6.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "GeRenZhongXinViewController.h"
#import "DengLuHouZhuYeViewController.h"
#import "shouyeViewController.h"
#import "ZhuCeViewController.h"
#import "XiuGaiMiMaViewController.h"
#import "GeRenXinXiWanShanViewController.h"
#import "ZhuZhiXinXiViewController.h"
#import "CheLiangXinXiYiLanViewController.h"
#import "WoDeZhangDanViewController.h"
#import "ZhuXiao.h"
#import "MJRefresh.h"
#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "MBProgressHUD.h"
#import "URL.h"
#import "JiaMiJieMi.h"
#import "UIImageView+WebCache.h"
extern NSString *Session;
extern NSString *UserName;
extern NSString *Card_id;
extern NSString *Name;
extern NSString *icon_path;
extern int IsFiirst;
@interface GeRenZhongXinViewController ()

@end

@implementation GeRenZhongXinViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//- (void)loadView
//{
//    [super loadView];
//    ZhuXiao*customer =[[ZhuXiao alloc]init];
//    customer.session=Session;
//    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
//    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str_jiami];
//    [HttpPostExecutor postExecuteWithUrlStr:QieHuanXiaoQu_m1_13 Paramters:Str FinishCallbackBlock:^(NSString *result){
//        // 执行post请求完成后的逻辑
//        //NSLog(@"第2次: %@", result);//result就是NSString类型的返回值
//        NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
//      //  NSLog(@"第2次: %@", str_jiemi);//result就是NSString类型的返回值
//        
//        SBJsonParser *parser = [[SBJsonParser alloc] init];
//        NSError *error = nil;
//        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//        arr_info=[rootDic objectForKey:@"address_info"];
//        for (int i=0; i<[arr_info count]; i++)
//        {
//            NSString *string=[[arr_info objectAtIndex:i] objectForKey:@"isdefaultshow"];
//            if ([string isEqualToString:@"1"])
//            {
//                NSDictionary *Dic=[arr_info objectAtIndex:i];
//                str_zhuzhi=[NSString stringWithFormat:@"%@%@%@%@%@",[Dic objectForKey:@"community_name"],[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
//                label5.text=str_zhuzhi;
//            }
//        }
//
//    }];
//    
//}
-(void)viewWillAppear:(BOOL)animated
{
    label1.text=UserName;
    NSUserDefaults *userDefaulte= [NSUserDefaults standardUserDefaults];
    NSString *myString_zhanghao = [userDefaulte stringForKey:@"dizhixinxi"];
    label5.text=myString_zhanghao;
}
- (void)viewDidLoad
{
    @try
    {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    beijing_view=[[UIView alloc]initWithFrame:CGRectMake(0, 20, Width, Hidth-20)];
    beijing_view.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:0.8];
    label19=[[UILabel alloc]initWithFrame:CGRectMake(10, 110, 300, 40)];
    label19.backgroundColor=[UIColor blackColor];
    label19.text=@"选择当前住址";
    [label9 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label19.textColor=[UIColor whiteColor];
    [beijing_view addSubview:label19];
    label20=[[UILabel alloc]initWithFrame:CGRectMake(20, 400, 280, 40)];
    label20.backgroundColor=[UIColor grayColor];
    [beijing_view addSubview:label20];
    btn_queding=[[UIButton alloc]initWithFrame:CGRectMake(30, 405, 120, 30)];
    [btn_queding setTitle:@"确定" forState:UIControlStateNormal];
    [btn_queding setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn_queding.backgroundColor=[UIColor whiteColor];
    [btn_queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [beijing_view addSubview:btn_queding];
    btn_quxiao=[[UIButton alloc]initWithFrame:CGRectMake(170, 405, 120, 30)];
    [btn_quxiao setTitle:@"取消" forState:UIControlStateNormal];
    btn_quxiao.backgroundColor=[UIColor whiteColor];
    [btn_quxiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn_quxiao addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [beijing_view addSubview:btn_quxiao];
    
    self.view.backgroundColor=[UIColor whiteColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    label.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    label.text=@"个人中心";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [fanhui setBackgroundImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [self.view addSubview:fanhui];
    
    imageview1= [[UIImageView alloc]initWithFrame:CGRectMake(135, 65, 60, 60)];
    imageview1.layer.cornerRadius = 30;
    imageview1.layer.masksToBounds = YES;
    imageview1.tag = 10000;
    imageview1.userInteractionEnabled=NO;
    [imageview1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",icon_path]]
           placeholderImage:[UIImage imageNamed:@"tx11"] options:SDWebImageProgressiveDownload];
    [self.view addSubview:imageview1];

    
//    imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 60, 60, 60)];
//    imageview1.image=[UIImage imageNamed:@"m_personcenter.png"];
//    [self.view addSubview:imageview1];
    
    label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 130, 320, 20)];
    
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:label1];
    
    myscrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 160, Width, Hidth-130)];
    myscrollview.delegate=self;
    myscrollview.contentSize=CGSizeMake(Width, 765);
    myscrollview.directionalLockEnabled =NO; //只能一个方向滑动
    myscrollview.pagingEnabled = NO; //是否翻页
    myscrollview.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:myscrollview];
    btn_gerenziliao=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 300, 35)];
    btn_gerenziliao.layer.masksToBounds = YES;
    btn_gerenziliao.layer.cornerRadius = 5;
    btn_gerenziliao.layer.borderWidth = 0.5;
    btn_gerenziliao.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_gerenziliao.backgroundColor=[UIColor whiteColor];
    [btn_gerenziliao addTarget:self action:@selector(gerenziliao) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_gerenziliao];
    imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(18, 14, 25, 25)];
    imageview2.image=[UIImage imageNamed:@"m_personcenter.png"];
    [myscrollview addSubview:imageview2];
    label2=[[UILabel alloc]initWithFrame:CGRectMake(45, 14, 180, 25)];
    label2.text=@"个人资料";
    label2.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label2];
    label_jiantou1=[[UILabel alloc]initWithFrame:CGRectMake(280, 14, 40, 25)];
    label_jiantou1.text=@">";
    label_jiantou1.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou1];
    
    btn_youxiandianshixinxi=[[UIButton alloc]initWithFrame:CGRectMake(10, 45, 300, 35)];
    btn_youxiandianshixinxi.layer.masksToBounds = YES;
    btn_youxiandianshixinxi.layer.cornerRadius = 5;
    btn_youxiandianshixinxi.layer.borderWidth = 0.5;
    btn_youxiandianshixinxi.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_youxiandianshixinxi.backgroundColor=[UIColor whiteColor];
    [btn_youxiandianshixinxi addTarget:self action:@selector(youxiandianshi) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_youxiandianshixinxi];
    imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(18, 49, 25, 25)];
    imageview3.image=[UIImage imageNamed:@"jidinghe.png"];
    [myscrollview addSubview:imageview3];
    label3=[[UILabel alloc]initWithFrame:CGRectMake(45, 49, 180, 25)];
    label3.text=@"有线电视机顶盒信息";
    label3.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label3];
    label_jiantou2=[[UILabel alloc]initWithFrame:CGRectMake(280, 49, 40, 25)];
    label_jiantou2.text=@">";
    label_jiantou2.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou2];
        
        
    btn_cheliangxinxi=[[UIButton alloc]initWithFrame:CGRectMake(10, 80, 300, 35)];
    btn_cheliangxinxi.layer.masksToBounds = YES;
    btn_cheliangxinxi.layer.cornerRadius = 5;
    btn_cheliangxinxi.layer.borderWidth = 0.5;
    btn_cheliangxinxi.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_cheliangxinxi.backgroundColor=[UIColor whiteColor];
    [btn_cheliangxinxi addTarget:self action:@selector(cheliangxinxi) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_cheliangxinxi];
    imageview7=[[UIImageView alloc]initWithFrame:CGRectMake(18, 85, 25, 25)];
    imageview7.image=[UIImage imageNamed:@"car_info2.png"];
    [myscrollview addSubview:imageview7];
    label21=[[UILabel alloc]initWithFrame:CGRectMake(45, 85, 180, 25)];
    label21.text=@"车辆信息";
    label21.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label21];
    label_jiantou14=[[UILabel alloc]initWithFrame:CGRectMake(280, 85, 40, 25)];
    label_jiantou14.text=@">";
    label_jiantou14.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou14];
  
        
        
    
    imageview4=[[UIImageView alloc]initWithFrame:CGRectMake(10, 125, 30, 30)];
    imageview4.image=[UIImage imageNamed:@"icon_xiaoxu0707.png"];
    [myscrollview addSubview:imageview4];
    label4=[[UILabel alloc]initWithFrame:CGRectMake(45, 135, 160, 20)];
    label4.text=@"我的住址信息";
    label4.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label4];
    btn_tianjiaxinzhuzhi=[[UIButton alloc]initWithFrame:CGRectMake(200, 135, 100, 30)];
    [btn_tianjiaxinzhuzhi setTitle:@"添加新住址" forState:UIControlStateNormal];
    [btn_tianjiaxinzhuzhi setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn_tianjiaxinzhuzhi addTarget:self action:@selector(tianjiazhuzhi) forControlEvents:UIControlEventTouchUpInside];
    btn_tianjiaxinzhuzhi.titleLabel.font=[UIFont systemFontOfSize:14];
    [myscrollview addSubview:btn_tianjiaxinzhuzhi];
    
    btn_yajuyuan=[[UIButton alloc]initWithFrame:CGRectMake(10, 165, 300, 35)];
    btn_yajuyuan.layer.masksToBounds = YES;
    btn_yajuyuan.layer.cornerRadius = 5;
    btn_yajuyuan.layer.borderWidth = 0.5;
    btn_yajuyuan.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_yajuyuan.backgroundColor=[UIColor whiteColor];
    [btn_yajuyuan addTarget:self action:@selector(qiehuanxiaoqu) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_yajuyuan];
    label5=[[UILabel alloc]initWithFrame:CGRectMake(15, 170, 260, 25)];
    
    label5.font=[UIFont systemFontOfSize:14];
    [myscrollview addSubview:label5];
    label_jiantou3=[[UILabel alloc]initWithFrame:CGRectMake(280, 170, 40, 25)];
    label_jiantou3.text=@">";
    label5.text=str_zhuzhi;
    label_jiantou3.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou3];

    label6=[[UILabel alloc]initWithFrame:CGRectMake(10, 215, 294, 25)];
    label6.text=@"笑脸币";
    label6.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label6];
    
    btn_wodexiaolianbi=[[UIButton alloc]initWithFrame:CGRectMake(10, 245, 300, 35)];
    btn_wodexiaolianbi.layer.masksToBounds = YES;
    btn_wodexiaolianbi.layer.cornerRadius = 5;
    btn_wodexiaolianbi.layer.borderWidth = 0.5;
    btn_wodexiaolianbi.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_wodexiaolianbi.backgroundColor=[UIColor whiteColor];
    [btn_wodexiaolianbi addTarget:self action:@selector(wodexiaolianbi) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_wodexiaolianbi];
    imageview5=[[UIImageView alloc]initWithFrame:CGRectMake(18, 250, 25, 25)];
    imageview5.image=[UIImage imageNamed:@"icon_money0707.png"];
    [myscrollview addSubview:imageview5];
    label7=[[UILabel alloc]initWithFrame:CGRectMake(45, 250, 180, 25)];
    label7.text=@"我的笑脸币";
    label7.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label7];
    label_jiantou4=[[UILabel alloc]initWithFrame:CGRectMake(280, 250, 40, 25)];
    label_jiantou4.text=@">";
    label_jiantou4.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou4];
    
    btn_xiaolianbishangcheng=[[UIButton alloc]initWithFrame:CGRectMake(10, 280, 300, 35)];
    btn_xiaolianbishangcheng.layer.masksToBounds = YES;
    btn_xiaolianbishangcheng.layer.cornerRadius = 5;
    btn_xiaolianbishangcheng.layer.borderWidth = 0.5;
    btn_xiaolianbishangcheng.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_youxiandianshixinxi.backgroundColor=[UIColor whiteColor];
    [btn_xiaolianbishangcheng addTarget:self action:@selector(xiaolianbishangcheng) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_xiaolianbishangcheng];
    imageview6=[[UIImageView alloc]initWithFrame:CGRectMake(18, 285, 25, 25)];
    imageview6.image=[UIImage imageNamed:@"icon_market0707.png"];
    [myscrollview addSubview:imageview6];
    label8=[[UILabel alloc]initWithFrame:CGRectMake(45, 285, 180, 25)];
    label8.text=@"笑脸币商城";
    label8.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label8];
    label_jiantou5=[[UILabel alloc]initWithFrame:CGRectMake(280, 285, 40, 25)];
    label_jiantou5.text=@">";
    label_jiantou5.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou5];
    
    label9=[[UILabel alloc]initWithFrame:CGRectMake(10, 335, 294, 25)];
    label9.text=@"动态";
    label9.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label9];
    btn_wodexiaoxi=[[UIButton alloc]initWithFrame:CGRectMake(10, 365, 300, 35)];
    btn_wodexiaoxi.layer.masksToBounds = YES;
    btn_wodexiaoxi.layer.cornerRadius = 5;
    btn_wodexiaoxi.layer.borderWidth = 0.5;
    btn_wodexiaoxi.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_wodexiaoxi.backgroundColor=[UIColor whiteColor];
    [btn_wodexiaoxi addTarget:self action:@selector(wodexiaoxi) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_wodexiaoxi];
    label10=[[UILabel alloc]initWithFrame:CGRectMake(45, 373, 180, 25)];
    label10.text=@"我的消息";
    label10.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label10];
    label_jiantou6=[[UILabel alloc]initWithFrame:CGRectMake(280, 373, 40, 25)];
    label_jiantou6.text=@">";
    label_jiantou6.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou6];
    btn_wodehuifu=[[UIButton alloc]initWithFrame:CGRectMake(10, 400, 300, 35)];
    btn_wodehuifu.layer.masksToBounds = YES;
    btn_wodehuifu.layer.cornerRadius = 5;
    btn_wodehuifu.layer.borderWidth = 0.5;
    btn_wodehuifu.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_wodehuifu.backgroundColor=[UIColor whiteColor];
    [btn_wodehuifu addTarget:self action:@selector(wodehuifu) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_wodehuifu];
    label11=[[UILabel alloc]initWithFrame:CGRectMake(45, 405, 180, 25)];
    label11.text=@"我的回复";
    label11.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label11];
    label_jiantou7=[[UILabel alloc]initWithFrame:CGRectMake(280, 405, 40, 25)];
    label_jiantou7.text=@">";
    label_jiantou7.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou7];
    btn_wodeshoucang=[[UIButton alloc]initWithFrame:CGRectMake(10, 435, 300, 35)];
    btn_wodeshoucang.layer.masksToBounds = YES;
    btn_wodeshoucang.layer.cornerRadius = 5;
    btn_wodeshoucang.layer.borderWidth = 0.5;
    btn_wodeshoucang.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_wodeshoucang.backgroundColor=[UIColor whiteColor];
    [btn_wodeshoucang addTarget:self action:@selector(wodeshoucang) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_wodeshoucang];
    label12=[[UILabel alloc]initWithFrame:CGRectMake(45, 440, 180, 25)];
    label12.text=@"我的收藏";
    label12.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label12];
    label_jiantou8=[[UILabel alloc]initWithFrame:CGRectMake(280, 440, 40, 25)];
    label_jiantou8.text=@">";
    label_jiantou8.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou8];
    btn_wodetiezi=[[UIButton alloc]initWithFrame:CGRectMake(10, 470, 300, 35)];
    btn_wodetiezi.layer.masksToBounds = YES;
    btn_wodetiezi.layer.cornerRadius = 5;
    btn_wodetiezi.layer.borderWidth = 0.5;
    btn_wodetiezi.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_wodetiezi.backgroundColor=[UIColor whiteColor];
    [btn_wodetiezi addTarget:self action:@selector(wodetiezi) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_wodetiezi];
    label13=[[UILabel alloc]initWithFrame:CGRectMake(45, 475, 180, 25)];
    label13.text=@"我的帖子";
    label13.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label13];
    label_jiantou9=[[UILabel alloc]initWithFrame:CGRectMake(280, 475, 40, 25)];
    label_jiantou9.text=@">";
    label_jiantou9.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou9];

    label14=[[UILabel alloc]initWithFrame:CGRectMake(10, 525, 194, 25)];
    label14.text=@"预交费与账单";
    label14.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label14];
    btn_wodeyujiaofei=[[UIButton alloc]initWithFrame:CGRectMake(10, 555, 300, 35)];
    btn_wodeyujiaofei.layer.masksToBounds = YES;
    btn_wodeyujiaofei.layer.cornerRadius = 5;
    btn_wodeyujiaofei.layer.borderWidth = 0.5;
    btn_wodeyujiaofei.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_wodeyujiaofei.backgroundColor=[UIColor whiteColor];
    [btn_wodeyujiaofei addTarget:self action:@selector(yujiaofeiyuzhangdan) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_wodeyujiaofei];
    label15=[[UILabel alloc]initWithFrame:CGRectMake(45, 562, 180, 25)];
    label15.text=@"我的预交费";
    label15.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label15];
    label_jiantou10=[[UILabel alloc]initWithFrame:CGRectMake(280, 562, 40, 25)];
    label_jiantou10.text=@">";
    label_jiantou10.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou10];
    btn_wodezhangdan=[[UIButton alloc]initWithFrame:CGRectMake(10, 590, 300, 35)];
    btn_wodezhangdan.layer.masksToBounds = YES;
    btn_wodezhangdan.layer.cornerRadius = 5;
    btn_wodezhangdan.layer.borderWidth = 0.5;
    btn_wodezhangdan.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_wodezhangdan.backgroundColor=[UIColor whiteColor];
    [btn_wodezhangdan addTarget:self action:@selector(wodezhangdan) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_wodezhangdan];
    label16=[[UILabel alloc]initWithFrame:CGRectMake(45, 595, 180, 25)];
    label16.text=@"我的账单";
    label16.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label16];
    label_jiantou11=[[UILabel alloc]initWithFrame:CGRectMake(280, 595, 40, 25)];
    label_jiantou11.text=@">";
    label_jiantou11.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou11];

    btn_zhuxiao=[[UIButton alloc]initWithFrame:CGRectMake(10, 645, 300, 35)];
    btn_zhuxiao.layer.masksToBounds = YES;
    btn_zhuxiao.layer.cornerRadius = 5;
    btn_zhuxiao.layer.borderWidth = 0.5;
    btn_zhuxiao.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_zhuxiao.backgroundColor=[UIColor whiteColor];
    [btn_zhuxiao addTarget:self action:@selector(zhuxiao) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_zhuxiao];
    label17=[[UILabel alloc]initWithFrame:CGRectMake(45, 650, 180, 25)];
    label17.text=@"注销";
    label17.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label17];
    label_jiantou12=[[UILabel alloc]initWithFrame:CGRectMake(280, 650, 40, 25)];
    label_jiantou12.text=@">";
    label_jiantou12.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou12];
    
    btn_xiugaimima=[[UIButton alloc]initWithFrame:CGRectMake(10, 695, 300, 35)];
    btn_xiugaimima.layer.masksToBounds = YES;
    btn_xiugaimima.layer.cornerRadius = 5;
    btn_xiugaimima.layer.borderWidth = 0.5;
    btn_xiugaimima.layer.borderColor=[[UIColor grayColor] CGColor];
    btn_xiugaimima.backgroundColor=[UIColor whiteColor];
    [btn_xiugaimima addTarget:self action:@selector(xiugaimima) forControlEvents:UIControlEventTouchUpInside];
    [myscrollview addSubview:btn_xiugaimima];
    label18=[[UILabel alloc]initWithFrame:CGRectMake(45, 700, 180, 25)];
    label18.text=@"修改密码";
    label18.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label18];
    label_jiantou13=[[UILabel alloc]initWithFrame:CGRectMake(280, 700, 40, 25)];
    label_jiantou13.text=@">";
    label_jiantou13.font=[UIFont systemFontOfSize:16];
    [myscrollview addSubview:label_jiantou13];
    
    mytableview=[[UITableView alloc]initWithFrame:CGRectMake(10, 150, 300, 250)];
    mytableview.delegate=self;
    mytableview.dataSource=self;
    arr_zhuzhi=[[NSMutableArray alloc]init];

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
-(void)queding
{
    @try
    {

    QieHuanZhuZhiXinXi*customer =[[QieHuanZhuZhiXinXi alloc]init];
    customer.session=Session;
    customer.address_id=str_address_id;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
     NSLog(@": %@", str1);
    [HttpPostExecutor postExecuteWithUrlStr:QieHuanZhuZhiXinXi_24_012 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        //NSLog(@"第2次: %@", result);//result就是NSString类型的返回值
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {

        NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        NSLog(@"第2次: %@", str_jiemi);//result就是NSString类型的返回值
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
        
        
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:sss forKey:@"zhuzhi"];
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        label5.text = [userDefaultes stringForKey:@"zhuzhi"];
        
        [beijing_view removeFromSuperview];
        [mytableview removeFromSuperview];
        }
    }];

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
-(void)cheliangxinxi
{
    CheLiangXinXiYiLanViewController *xinxi=[[CheLiangXinXiYiLanViewController alloc]init];
    [self presentViewController:xinxi animated:NO completion:nil];
}
-(void)quxiao
{
    [beijing_view removeFromSuperview];
    [mytableview removeFromSuperview];
}

-(void)qiehuanxiaoqu
{
    @try
    {

    ZhuXiao*customer =[[ZhuXiao alloc]init];
    customer.session=Session;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:QieHuanXiaoQu_m1_13 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        //NSLog(@"第2次: %@", result);//result就是NSString类型的返回值
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {

        NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
        //  NSLog(@"第2次: %@", str_jiemi);//result就是NSString类型的返回值
        
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSError *error = nil;
        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
        NSString *a=[rootDic objectForKey:@"ecode"];
        int intb = [a intValue];
        
        if (intb==1000)
        {
        arr_info=[rootDic objectForKey:@"address_info"];
        [self.view addSubview:beijing_view];
        [beijing_view addSubview:mytableview];
        [mytableview reloadData];
        }
        if (intb==4000)
        {
            [self showWithCustomView:@"服务器内部错误"];
        }
        }
    }];

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
-(void)zhuxiao
{
    @try
    {

    ZhuXiao*customer =[[ZhuXiao alloc]init];
    customer.session=Session;
    NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    [HttpPostExecutor postExecuteWithUrlStr:ZhuXiao_m1_05 Paramters:Str FinishCallbackBlock:^(NSString *result)
     {
         // 执行post请求完成后的逻辑
         if (result.length<=0)
         {
             UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             [aler show];
         }
         else
         {

         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
         SBJsonParser *parser = [[SBJsonParser alloc] init];
         NSError *error = nil;
         NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
         NSString *a=[rootDic objectForKey:@"ecode"];
         int intb = [a intValue];
         
         if (intb==1000)
         {
             UserName=nil;
             Card_id=nil;
             Name=nil;
             [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(jieguo) userInfo:nil repeats:NO];
             [self showWithCustomView:@"已退出登录状态"];
             
             
         }
         }
     }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_info.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [mytableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 49, 280, 1)];
    label.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [cell addSubview:label];

    cell.textLabel.text=[NSString stringWithFormat:@"%@%@%@%@%@",[arr_info[indexPath.row] objectForKey:@"community_name"],[arr_info[indexPath.row] objectForKey:@"quarter_name"],[arr_info[indexPath.row] objectForKey:@"building_name"],[arr_info[indexPath.row] objectForKey:@"unit_name"],[arr_info[indexPath.row] objectForKey:@"room_name"]];

    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];//未选cell时的图片
    //cell.imageView.highlightedImage=[UIImage imageNamed:@"payeco_plugin_radiobt_bg_checked.png"];//选中cell后的图
//    if ([[arr_info[indexPath.row] objectForKey:@"isdefaultshow"] isEqualToString:@"1"])
//    {
//        NSIndexPath *first = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
//        [mytableview selectRowAtIndexPath:first animated:NO  scrollPosition:UITableViewScrollPositionBottom];
//        cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg_checked.png"];//未选cell时的图片
//    }
    if ([[arr_info[indexPath.row] objectForKey:@"isdefaultshow"] isEqualToString:@"1"])
    {
        NSIndexPath *first = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [mytableview selectRowAtIndexPath:first animated:NO  scrollPosition:UITableViewScrollPositionBottom];
    }
    cell.imageView.image=[UIImage imageNamed:@"payeco_plugin_radiobt_bg.png"];
    cell.imageView.highlightedImage=[UIImage imageNamed:@"payeco_plugin_radiobt_bg_checked.png"];
    cell.selected = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[mytableview cellForRowAtIndexPath:indexPath];
    sss=cell.textLabel.text;
    str_address_id=[arr_info[indexPath.row] objectForKey:@"address_id"];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)jieguo
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
-(void)xiugaimima
{
    XiuGaiMiMaViewController *xiugai=[[XiuGaiMiMaViewController alloc]init];
    [self presentViewController:xiugai animated:NO completion:nil];
}
-(void)yujiaofeiyuzhangdan
{
    
}
-(void)wodezhangdan
{
    WoDeZhangDanViewController *zhangdan=[[WoDeZhangDanViewController alloc]init];
    [self presentViewController:zhangdan animated:NO completion:nil];
}
-(void)wodexiaoxi
{
    
}
-(void)wodetiezi
{
    
}
-(void)wodeshoucang
{
    
}
-(void)wodehuifu
{
    
}
-(void)wodexiaolianbi
{

}
-(void)xiaolianbishangcheng
{
    
}
-(void)tianjiazhuzhi
{
    ZhuZhiXinXiViewController *xinxi=[[ZhuZhiXinXiViewController alloc]init];
    [self presentViewController:xinxi animated:NO completion:nil];
}
-(void)youxiandianshi
{

}
-(void)gerenziliao
{
    GeRenXinXiWanShanViewController *wanshan=[[GeRenXinXiWanShanViewController alloc]init];
    [self presentViewController:wanshan animated:NO completion:nil];
}
-(void)fanhui
{
        DengLuHouZhuYeViewController *zhuye=[[DengLuHouZhuYeViewController alloc]init];
        [self presentViewController:zhuye animated:NO completion:nil];
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


@end
