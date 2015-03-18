//
//  DengLuHouZhuYeViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "DengLuHouZhuYeViewController.h"
#import "ModifyPasswordViewController.h"
#import "Header.h"
//****************
#import "PersonCenterHttpService.h"
#import "AXHSQDynamicViewController.h"
#import "AXHSQForumViewController.h"
#import "AXHSeckillViewController.h"
#import<QuartzCore/QuartzCore.h>
#import "QRViewController.h"
#import "MyBillViewController.h"
extern int WDNum;
extern int IsFiirst;
extern NSString *Card_id;
extern NSString *Name;
extern NSString *community_id;
extern NSString *Session;
extern NSString *UserName;
extern NSString *email;
extern NSString *icon_path;
extern NSString *xiaoquIDString;
extern NSString *xiaoquming;
extern NSString *Type;
extern NSString *SheQuFuWu_Title;
extern NSString *area_id;
extern NSString *community_id;
extern NSString *agency_id;
extern NSString *city_id;
extern NSString *quarter_id;
extern NSString *Title_label;
@interface DengLuHouZhuYeViewController ()<HttpDataServiceDelegate,UIActionSheetDelegate>
{
    //请求
    PersonCenterHttpService *sqHttpSer;
    NSMutableDictionary *plistDic;// plist文件
}

@end

@implementation DengLuHouZhuYeViewController
@synthesize leftSwipeGestureRecognizer,rightSwipeGestureRecognizer;
@synthesize scrollview_zhoubian,scrollview_xiaoqu,viewsArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)onClickButton  //侧拉菜单
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [UIView beginAnimations:@"Curl" context:context];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.5];
//    CGRect rect = [myView frame];
//    if (rect.origin.x>0) {
//        rect.origin.x = 0;
//    }
//    else {
//        rect.origin.x = 160.0f;
//    }
//    [myView setFrame:rect];
//    [UIView commitAnimations];
}
- (void)shezhi    //系统设置
{
    XiTongSheZhiViewController *shezhiviewcontroll=[[XiTongSheZhiViewController alloc]init];
    [self presentViewController:shezhiviewcontroll animated:NO completion:nil];
}

- (void)LiJjiDengLu    //登录
{
    [self Login];

}


- (void)showWithCustomView:(NSString*)aString
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

- (void)ShouShiZhiNan    //收视指南
{
    WoDeViewController *shoushiviewcontroll=[[WoDeViewController alloc]init];
    [self presentViewController:shoushiviewcontroll animated:NO completion:nil];
}

- (void)xinwenzhixun    //新闻资讯
{
    NewsViewController *xinwen=[[NewsViewController alloc]init];
    [self presentViewController:xinwen animated:NO completion:nil];

}

- (void)TuanGouYouHui    //团购优惠
{
    YouHuiXinXiViewController *tuangouview=[[YouHuiXinXiViewController alloc]init];
    [self presentViewController:tuangouview animated:NO completion:nil];
}

- (void)shequdongtai    //社区动态
{
    CommunityDynamicViewController *dongtai=[[CommunityDynamicViewController alloc]init];
    [self presentViewController:dongtai animated:NO completion:nil];
//    SheQuDongTaiViewController *dongtai=[[SheQuDongTaiViewController alloc]init];
//    [self presentViewController:dongtai animated:NO completion:nil];
}

- (void)WoDeZhouBian    //我的周边
{
    ZhouBianViewController *zhoubianview=[[ZhouBianViewController alloc]init];
    [self presentViewController:zhoubianview animated:NO completion:nil];
}
- (void)shequfuwu    //社区服务
{
//    FuWwYingYongViewController *fuwuview=[[FuWwYingYongViewController alloc]init];
//    [self presentViewController:fuwuview animated:NO completion:nil];
    FuWuDaoHangViewController *fuwuview=[[FuWuDaoHangViewController alloc]init];
    [self presentViewController:fuwuview animated:NO completion:nil];

}
-(void)gerenzhongxin    //个人中心
{
    GeRenZhongXinViewController *gerenview=[[GeRenZhongXinViewController alloc]init];
    [self presentViewController:gerenview animated:NO completion:nil];
}
-(void)shequhudong
{
    
    if (UserName==nil)
    {
        shouyeViewController *denglu=[[shouyeViewController alloc]init];
        [self presentViewController:denglu animated:NO completion:nil];
    }
    else
    {
        SheQuHuDongViewController *hudong=[[SheQuHuDongViewController alloc]init];
        [self presentViewController:hudong animated:NO completion:nil];
    }
}
-(void)kuaijiejiaofei
{
    
    if (![Session isEqualToString:@""] && Session.length>0)
    {
        KuaiJieJiaoFeiViewController *jiaofei=[[KuaiJieJiaoFeiViewController alloc]init];
        [self presentViewController:jiaofei animated:NO completion:nil];

    }
    else
    {
        [self Login];

    }

    
}
-(void)xiaoqubibei
{
    XiaoQuBiBieViewController *bibie=[[XiaoQuBiBieViewController alloc]init];
    [self presentViewController:bibie animated:NO completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor=[UIColor whiteColor];
    [self AddCommunityPreferentialMessageDate
     ];
//    NSUserDefaults *userDefau = [NSUserDefaults standardUserDefaults];
//    NSString *myString = [userDefau stringForKey:@"xiaoqu"];
    //NSLog(@"%@+++++++",myString);
    label_title.text=@"笑脸社区";
    label_title.textAlignment=NSTextAlignmentCenter;
    if (xiaoquming.length>0)
    {
        label_title.text=xiaoquming;
    }
    if (![Session isEqualToString:@""] && Session.length>0)
    {
        /*
         //主页卡顿代码
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:icon_path]];
        if (data.length>0 && ![icon_path isEqualToString:@""] && ![icon_path isEqualToString:nil])
        {
            
            [imageview_HeadPortraits setImageWithURL:[NSURL URLWithString:icon_path] placeholderImage:[UIImage imageNamed:@"setPerson"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
        else
        {
            imageview_HeadPortraits.image=[UIImage imageNamed:@"p051_我.png"];
        }
         */
        
        /*
         修改人 赵忠良
         修改时间 15.3.12
         修改原因 返回主页卡顿问题
         */
        //****************************
        
        if (![icon_path isEqualToString:@""])
        {
            
            [imageview_HeadPortraits setImageWithURL:[NSURL URLWithString:icon_path] placeholderImage:[UIImage imageNamed:@"setPerson"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
        else
        {
            imageview_HeadPortraits.image=[UIImage imageNamed:@"p051_我.png"];
        }
        //******************************
        

        imageview_HeadPortraits.frame=CGRectMake(30, 35, 40, 40);
        [DengLuBtn removeFromSuperview];
        [view_wode addSubview:Btn_ForgotPassword];
        [view_wode addSubview:Btn_Logout];
       
        [view_wode addSubview:label_MemberGrade];
        [view_wode addSubview:label_AvailableHappyFaceMoney];
        label_NickName.frame=CGRectMake(80, 35, 150, 20);
        label_NickName.text=UserName;
        [view_wode addSubview:label_NickName];
        
        label_Member.frame=CGRectMake(80, 55, 200, 20);
        if (label_Member.text.length < 1) {
            label_Member.text=@"铜牌会员 | 笑脸币：0";
        }
        [view_wode addSubview:label_Member];
        
        
        /*
         修改人 赵忠良
         修改时间 15.3.11
         修改内容 添加调用笑脸币更新
         */
        [self keyong];
        
    }
    else
    {
        imageview_HeadPortraits.image=[UIImage imageNamed:@"p051_我.png"];
        
    }
    NSLog(@"加载完毕");
}
-(void)guanyu
{
    GuanYuWoMenViewController *women=[[GuanYuWoMenViewController alloc]init];
    [self presentViewController:women animated:NO completion:nil];
}
//-(void)viewDidAppear:(BOOL)animated
//{
//    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\"}"];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str1];
//     [HttpPostExecutor postExecuteWithUrlStr:ipAddress_m1_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
//        // 执行post请求完成后的逻辑
//        if (result.length<=0)
//        {
//            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示:未能取得用户ip地址" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [aler show];
//        }
//        else
//        {
//            
//           // NSLog(@"ip地址: %@", result);
//            SBJsonParser *parser = [[SBJsonParser alloc] init];
//            NSError *error = nil;
//            NSDictionary *rootDic = [parser objectWithString:result error:&error];
//            NSString *daima=[rootDic objectForKey:@"ecode"];
//            int intString = [daima intValue];
//            if (intString==4000)
//            {
//                [self showWithCustomView:@"服务器内部错误"];
//            }
//            if (intString==1000)
//            {
//                string_Ip=[rootDic objectForKey:@"ip"];
//            }
//        }
//
//        
//    }];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    shouyeViewController *denglu=[[shouyeViewController alloc]init];
//    [denglu setDelegate_:self];
   
    IsFiirst=4;
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
    /*
     **
     侧滑的隐式菜单
     **
     */
    if([CheckNetwork isExistenceNetwork]==1)
    {
//        NSString *googleURL = @"http://www.weather.com.cn/data/cityinfo/101121601.html";
//        NSURL *url = [NSURL URLWithString:googleURL];
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//        NSURLConnection *connection = [[NSURLConnection alloc]
//                                       initWithRequest:request
//                                       delegate:self];
//        
        
        
//        //解析网址通过ip 获取城市天气代码
//        NSURL *url = [NSURL URLWithString:@"http://61.4.185.48:81/g/"];
//        
//        //    定义一个NSError对象，用于捕获错误信息
//        NSError *error;
//        NSString *jsonString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
//        
//        NSLog(@"------------%@",jsonString);
//        
//        // 得到城市代码字符串，截取出城市代码
//        NSString *Str;
//        for (int i = 0; i<=[jsonString length]; i++)
//        {
//            for (int j = i+1; j <=[jsonString length]; j++)
//            {
//                Str = [jsonString substringWithRange:NSMakeRange(i, j-i)];
//                if ([Str isEqualToString:@"id"]) {
//                    if (![[jsonString substringWithRange:NSMakeRange(i+3, 1)] isEqualToString:@"c"]) {
//                        _intString = [jsonString substringWithRange:NSMakeRange(i+3, 9)];
//                        NSLog(@"***%@***",_intString);
//                    }
//                }
//            }
//        }
//        
//        //中国天气网解析地址；
//        NSString *path=@"http://m.weather.com.cn/data/cityNumber.html";
//        //将城市代码替换到天气解析网址cityNumber 部分！
//        path=[path stringByReplacingOccurrencesOfString:@"cityNumber" withString:_intString];
//        
//        NSLog(@"path:%@",path);
        //ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:path]];
        NSString *googleURL = @"http://www.weather.com.cn/data/cityinfo/101121601.html";
         //NSString *path = @"http://m.weather.com.cn/data/101010100.html";
        
        ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:googleURL]];
        
        
        request.delegate = self;
        [request startAsynchronous];
        
    }
    
    
    
    /*
     **
     主页页面内容
     **
     */
    myView=[[UIView alloc]init];
    myView.frame=CGRectMake(0, 0, Width, Hidth);
    myView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myView];
        
    label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
    label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [myView addSubview:label_beijingse];
    
    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    label_title.textColor=[UIColor whiteColor];
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [myView addSubview:label_title];
        
        zhoubian=[[UIButton alloc]initWithFrame:CGRectMake(0, 60, Width/3, 40)];
        [zhoubian setImage:[UIImage imageNamed:@"p004_zhoubian_unchecked.png"] forState:UIControlStateNormal];
        [zhoubian addTarget:self action:@selector(zhoubian) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:zhoubian];
        
        xiaoqu=[[UIButton alloc]initWithFrame:CGRectMake(Width/3, 60, Width/3, 40)];
        [xiaoqu setImage:[UIImage imageNamed:@"p002_xiaoqu_checked.png"] forState:UIControlStateNormal];
        [xiaoqu addTarget:self action:@selector(xiaoqu) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:xiaoqu];
        
        wode=[[UIButton alloc]initWithFrame:CGRectMake(2*Width/3, 60, Width/3, 40)];
        [wode setImage:[UIImage imageNamed:@"p003_wo_unchecked.png"] forState:UIControlStateNormal];
        [wode addTarget:self action:@selector(wode) forControlEvents:UIControlEventTouchUpInside];
        [myView addSubview:wode];
        /*
         ***
         ****周边
         ***
         */
        scrollview_zhoubian=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, Width, Hidth-100)];
        scrollview_zhoubian.delegate=self;
        scrollview_zhoubian.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        scrollview_zhoubian.pagingEnabled = NO; //是否翻页
        scrollview_zhoubian.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
        scrollview_zhoubian.contentSize=CGSizeMake(scrollview_zhoubian.frame.size.width, 468);
        [myView addSubview:scrollview_zhoubian];
        
        
   
        imageview_miaosha=[[UIImageView alloc]initWithFrame:CGRectMake(0, 2, (Width-10)/3, 124)];
        [scrollview_zhoubian addSubview:imageview_miaosha];
        Btn_Seckill=[[UIButton alloc]initWithFrame:CGRectMake(0, 2, Width/3, 124)];
        [Btn_Seckill addTarget:self action:@selector(Seckill) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_Seckill];
    
        imageview_tuangou=[[UIImageView alloc]initWithFrame:CGRectMake(5+(Width-10)/3, 2, (Width-10)/3, 124)];
       [scrollview_zhoubian addSubview:imageview_tuangou];

        Btn_GroupBuying=[[UIButton alloc]initWithFrame:CGRectMake(Width/3, 2, Width/3, 124)];
        [Btn_GroupBuying addTarget:self action:@selector(GroupBuying) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_GroupBuying];

        imageview_youhuishangpin=[[UIImageView alloc]initWithFrame:CGRectMake(10+2*(Width-10)/3, 2, (Width-10)/3, 124)];
        [scrollview_zhoubian addSubview:imageview_youhuishangpin];

        Btn_Preferential=[[UIButton alloc]initWithFrame:CGRectMake(2*Width/3, 2, Width/3, 124)];
        [Btn_Preferential addTarget:self action:@selector(Preferential) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_Preferential];

    
        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n美食";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_MeiShi=[[UIButton alloc]initWithFrame:CGRectMake(3.6*Width/40, 135, 35, 35)];
        [Btn_MeiShi setImage:[UIImage imageNamed:@"p012_周边美食.png"] forState:UIControlStateNormal];
        [Btn_MeiShi addTarget:self action:@selector(meishi) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_MeiShi];

        ////////////////

        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(11+(Width-23)/4, 130, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n维修";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_WeiXiu=[[UIButton alloc]initWithFrame:CGRectMake(13.1*Width/40, 135, 35, 35)];
        [Btn_WeiXiu setImage:[UIImage imageNamed:@"p014_周边维修.png"] forState:UIControlStateNormal];
        [Btn_WeiXiu addTarget:self action:@selector(weixiu) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_WeiXiu];
        
        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(12+2*(Width-23)/4, 130, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n家政";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_JiaZheng=[[UIButton alloc]initWithFrame:CGRectMake(22.8*Width/40, 135, 35, 35)];
        [Btn_JiaZheng setImage:[UIImage imageNamed:@"p015_周边家政.png"] forState:UIControlStateNormal];
        [Btn_JiaZheng addTarget:self action:@selector(jiazheng) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_JiaZheng];

        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(13+3*(Width-23)/4, 130, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n医疗";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_YiLiao=[[UIButton alloc]initWithFrame:CGRectMake(32.3*Width/40, 135, 35, 35)];
        [Btn_YiLiao setImage:[UIImage imageNamed:@"p016_周边医疗.png"] forState:UIControlStateNormal];
        [Btn_YiLiao addTarget:self action:@selector(yiliao) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_YiLiao];

        
        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(10, 189, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n娱乐";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_YuLe=[[UIButton alloc]initWithFrame:CGRectMake(3.6*Width/40, 195, 35, 35)];
        [Btn_YuLe setImage:[UIImage imageNamed:@"p033_周边娱乐.png"] forState:UIControlStateNormal];
        [Btn_YuLe addTarget:self action:@selector(yule) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_YuLe];

        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(11+(Width-23)/4, 189, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n培训";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_PeiXun=[[UIButton alloc]initWithFrame:CGRectMake(13.1*Width/40, 195, 35, 35)];
        [Btn_PeiXun setImage:[UIImage imageNamed:@"p021_周边培训.png"] forState:UIControlStateNormal];
        [Btn_PeiXun addTarget:self action:@selector(peixun) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_PeiXun];

        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(12+2*(Width-23)/4, 189, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n旅游";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_LuYou=[[UIButton alloc]initWithFrame:CGRectMake(22.8*Width/40, 195, 35, 35)];
        [Btn_LuYou setImage:[UIImage imageNamed:@"p034_周边旅游.png"] forState:UIControlStateNormal];
        [Btn_LuYou addTarget:self action:@selector(luyou) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_LuYou];

        
        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(13+3*(Width-23)/4, 189, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n健身";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_JianShen=[[UIButton alloc]initWithFrame:CGRectMake(32.3*Width/40, 195, 35, 35)];
        [Btn_JianShen setImage:[UIImage imageNamed:@"p035_周边健身.png"] forState:UIControlStateNormal];
        [Btn_JianShen addTarget:self action:@selector(jianshen) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_JianShen];
        
        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(10, 248, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n酒店";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_JiuDian=[[UIButton alloc]initWithFrame:CGRectMake(3.6*Width/40, 253, 35, 35)];
        [Btn_JiuDian setImage:[UIImage imageNamed:@"p036_周边酒店.png"] forState:UIControlStateNormal];
        [Btn_JiuDian addTarget:self action:@selector(jiudian) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_JiuDian];
    
    
    
    label_bai=[[UILabel alloc]initWithFrame:CGRectMake(11+(Width-23)/4, 248, (Width-23)/4, 58)];
    label_bai.backgroundColor=[UIColor whiteColor];
    label_bai.numberOfLines=0;
    label_bai.text=@"\n\n\n家居";
    label_bai.font=[UIFont systemFontOfSize:12];
    label_bai.textAlignment=NSTextAlignmentCenter;
    [scrollview_zhoubian addSubview:label_bai];
    Btn_YouHuiQuan=[[UIButton alloc]initWithFrame:CGRectMake(13.1*Width/40, 253, 35, 35)];
    [Btn_YouHuiQuan setImage:[UIImage imageNamed:@"p017_周边优惠.png"] forState:UIControlStateNormal];
    [Btn_YouHuiQuan addTarget:self action:@selector(youhuiquan) forControlEvents:UIControlEventTouchUpInside];
    [scrollview_zhoubian addSubview:Btn_YouHuiQuan];
    
    label_bai=[[UILabel alloc]initWithFrame:CGRectMake(12+2*(Width-23)/4, 248, (Width-23)/4, 58)];
    label_bai.backgroundColor=[UIColor whiteColor];
    label_bai.numberOfLines=0;
    label_bai.text=@"\n\n\n酒水";
    label_bai.font=[UIFont systemFontOfSize:12];
    label_bai.textAlignment=NSTextAlignmentCenter;
    [scrollview_zhoubian addSubview:label_bai];
    Btn_ErShou=[[UIButton alloc]initWithFrame:CGRectMake(22.8*Width/40, 253, 35, 35)];
    [Btn_ErShou setImage:[UIImage imageNamed:@"p019_周边二手.png"] forState:UIControlStateNormal];
    [Btn_ErShou addTarget:self action:@selector(ershou) forControlEvents:UIControlEventTouchUpInside];
    [scrollview_zhoubian addSubview:Btn_ErShou];
    

    
    
        label_bai=[[UILabel alloc]initWithFrame:CGRectMake(13+3*(Width-23)/4, 248, (Width-23)/4, 58)];
        label_bai.backgroundColor=[UIColor whiteColor];
        label_bai.numberOfLines=0;
        label_bai.text=@"\n\n\n房产";
        label_bai.font=[UIFont systemFontOfSize:12];
        label_bai.textAlignment=NSTextAlignmentCenter;
        [scrollview_zhoubian addSubview:label_bai];
        Btn_GengDuo=[[UIButton alloc]initWithFrame:CGRectMake(32.3*Width/40, 253, 35, 35)];
        [Btn_GengDuo setImage:[UIImage imageNamed:@"p022_周边其他.png"] forState:UIControlStateNormal];
        [Btn_GengDuo addTarget:self action:@selector(gengduo) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_GengDuo];
        

        
        Btn_zhoubian_beijing1=[[UIButton alloc]initWithFrame:CGRectMake(0, 310, Width, 71)];
        [Btn_zhoubian_beijing1 setImage:[UIImage imageNamed:@"渐变1.png"] forState:UIControlStateNormal];
        [Btn_zhoubian_beijing1 addTarget:self action:@selector(YouHuiZiXun) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_zhoubian addSubview:Btn_zhoubian_beijing1];
        
        Btn_zhoubian_beijing1=[[UIButton alloc]initWithFrame:CGRectMake(0, 383, Width, 71)];
        [Btn_zhoubian_beijing1 setImage:[UIImage imageNamed:@"渐变1.png"] forState:UIControlStateNormal];
        [Btn_zhoubian_beijing1 addTarget:self action:@selector(YouHuiZiXun) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollview_zhoubian addSubview:Btn_zhoubian_beijing1];

        
        
        /*
         ***
         ****我的
         ***
         */
    @try
    {
        view_wode=[[UIView alloc]initWithFrame:CGRectMake(0, 100, Width, Hidth-100)];
        view_wode.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [myView addSubview:view_wode];
        

        imageview_Me=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 124)];
        imageview_Me.image=[UIImage imageNamed:@"p050_我_背景.png"];
        [view_wode addSubview:imageview_Me];
        
        imageview_HeadPortraits=[[UIImageView alloc]init];
        imageview_HeadPortraits.frame=CGRectMake((self.view.frame.size.width-40)/2, 25, 40, 40);
        imageview_HeadPortraits.layer.masksToBounds=YES;
        imageview_HeadPortraits.layer.cornerRadius = 20;
        [view_wode addSubview:imageview_HeadPortraits];
        
        
        DengLuBtn=[[UIButton alloc]initWithFrame:CGRectMake(Width-50, 45, 45, 45)];
        [DengLuBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
        [DengLuBtn setImage:[UIImage imageNamed:@"back_right.png"] forState:UIControlStateNormal];
        [view_wode addSubview:DengLuBtn];
        
        label_NickName=[[UILabel alloc]init];
        label_NickName.textColor=[UIColor whiteColor];
        label_NickName.font=[UIFont systemFontOfSize:16];
        
        label_Member=[[UILabel alloc]init];
        label_Member.textColor=[UIColor colorWithRed:255/255.0 green:215/255.0 blue:0/255.0 alpha:1];
        label_Member.font=[UIFont systemFontOfSize:16];
        
        DengLuBtn=[[UIButton alloc]initWithFrame:CGRectMake(Width/3, 70, Width/3, 25)];
        [DengLuBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
        DengLuBtn.titleLabel.font=[UIFont systemFontOfSize:16];
        DengLuBtn.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
        DengLuBtn.layer.masksToBounds=YES;
        DengLuBtn.layer.cornerRadius = 5;
        [DengLuBtn setTitle:@"立即登录/注册" forState:UIControlStateNormal];
        [DengLuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [view_wode addSubview:DengLuBtn];

        Btn_Logout=[[UIButton alloc]initWithFrame:CGRectMake(2*Width/3-35, 90, 40, 35)];
        [Btn_Logout addTarget:self action:@selector(certainToLogout) forControlEvents:UIControlEventTouchUpInside];
        Btn_Logout.titleLabel.font=[UIFont systemFontOfSize:16];
        [Btn_Logout setTitle:@"注销" forState:UIControlStateNormal];
        [Btn_Logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       

        Btn_ForgotPassword=[[UIButton alloc]initWithFrame:CGRectMake((2*Width/3), 90, 100, 35)];
        [Btn_ForgotPassword addTarget:self action:@selector(ForgotPassword) forControlEvents:UIControlEventTouchUpInside];
        [Btn_ForgotPassword setTitle:@"| 修改密码" forState:UIControlStateNormal];
        [Btn_ForgotPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        Btn_ForgotPassword.titleLabel.font=[UIFont systemFontOfSize:16];
        
        
        arr_imagelistOfSectionOne=[NSArray arrayWithObjects:@"p038_我_我的住址信息.png", nil];
        
        arr_imagelistOfSectionTwo=[NSArray arrayWithObjects:@"p045_我_我的笑脸币.png",@"p046_我_笑脸币商城.png", nil];
        
        arr_imagelistOfSectionThree=[NSArray arrayWithObjects:@"p041_我_我的消息.png",@"p042_我_我的回复.png",@"p043_我_我的收藏.png",@"p044_我_我的发帖.png",@"p3009.png",nil];
        arr_imagelistOfSectionFour=[NSArray arrayWithObjects:@"p047_我_我的银行卡.png",@"p049_我_我的账单.png", nil];
        arr_imagelistOfSectionFive=[NSArray arrayWithObjects:@"p033_更多_系统设置.png",@"p034_更多_意见反馈.png",@"p035_更多_关于我们.png",@"p035_更多_关于我们.png", nil];
       // NSString *strrr1=xiaoquming;
        NSUserDefaults *userDefaulte= [NSUserDefaults standardUserDefaults];
        NSString *strrr1 = [userDefaulte stringForKey:@"dizhixinxi"];
        if (strrr1.length==0 ||[strrr1 isEqualToString:@""] || [strrr1 isEqualToString:nil])
        {
            strrr1=@"还没有绑定住址信息";

        }
//        NSString *strrr2=@"我的收货地址";
//        
//        NSString *strrr3=@"我的车辆信息";
        
        arr_strlistOfSectionOne=[[NSMutableArray alloc]init];
        [arr_strlistOfSectionOne addObject:strrr1];
       
        
        arr_strlistOfSectionTwo=[NSArray arrayWithObjects:@"我的笑脸币",@"笑脸币商城", nil];
        
        arr_strlistOfSectionThree=[NSArray arrayWithObjects:@"我的消息",@"我的回复",@"我的收藏",@"我的帖子",@"我的报料", nil];
        arr_strlistOfSectionFour=[NSArray arrayWithObjects:@"我的银行卡",@"我的账单", nil];
        arr_strlistOfSectionFive=[NSArray arrayWithObjects:@"系统设置",@"意见反馈", @"关于我们",@"应用二维码",nil];
        //arr_HeaderTitle=[NSArray arrayWithObjects:@"绑定信息",@"笑脸币",@"动态",@"银行卡与账单",@"系统设置", nil];
        
        
        /*
         设置tableview
         */
        //*********************************
        tableview=[[UITableView alloc]initWithFrame:CGRectMake(10, 125, Width-20, view_wode.frame.size.height-150)];
        tableview.bounces = YES;
        tableview.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        tableview.delegate=self;
        tableview.dataSource=self;
        [view_wode addSubview:tableview];
        //*********************************
        
        
          /*
         ***
         ****小区
         ***
         */
    
   

        scrollview_xiaoqu=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, Width, Hidth-100)];
        scrollview_xiaoqu.delegate=self;
        scrollview_xiaoqu.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        scrollview_xiaoqu.pagingEnabled = NO; //是否翻页
        scrollview_xiaoqu.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
        scrollview_xiaoqu.contentSize=CGSizeMake(scrollview_xiaoqu.frame.size.width, 488);
        [myView addSubview:scrollview_xiaoqu];

        
        imageview_Community=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 124)];
        imageview_Community.image=[UIImage imageNamed:@"p009_笑脸首页.png"];
        [scrollview_xiaoqu addSubview:imageview_Community];
        
        viewsArray=[[NSMutableArray alloc]init];
        scrollview_Advertisement=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0, Width,124)];
        NSString *str1=[NSString stringWithFormat:@"{\"city_id\":\"101\",\"area_id\":\"\",\"agency_id\":\"\",\"community_id\":\"\",\"quarter_id\":\"\",\"ad_position_model\":\"0\"}"];
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
        [HttpPostExecutor postExecuteWithUrlStr:TopXinXi_m39_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
            // 执行post请求完成后的逻辑
            if (result.length<=0)
            {
                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [aler show];
            }
            else
            {
                
                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                //NSLog(@"第一次: %@", str_jiemi);
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSError *error = nil;
                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                NSArray *array=[NSArray arrayWithArray:[rootDic objectForKey:@"info"]];
                for (int kk=0; kk<array.count; kk++)
                {
                    NSLog(@"%d",kk);
                    NSString *value=[array[kk] objectForKey:@"ad_position_value"];
                    if ([value isEqualToString:@"mobile_quarter_01"])
                    {
                        NSString *image_url=[array[kk] objectForKey:@"ad_media_url"];
                        [viewsArray addObject:image_url];
                    }
                    if ([value isEqualToString:@"mobile_area_seckill"])
                    {
                        [imageview_miaosha setImageWithURL:[NSURL URLWithString:[array[kk] objectForKey:@"ad_media_url"]] placeholderImage:[UIImage imageNamed:@"shangjia1"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];

                    }
                    if ([value isEqualToString:@"mobile_area_group"])
                    {
                        [imageview_tuangou setImageWithURL:[NSURL URLWithString:[array[kk] objectForKey:@"ad_media_url"]] placeholderImage:[UIImage imageNamed:@"shangjia1"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    }
                    if ([value isEqualToString:@"mobile_area_discount"])
                    {
                        [imageview_youhuishangpin setImageWithURL:[NSURL URLWithString:[array[kk] objectForKey:@"ad_media_url"]] placeholderImage:[UIImage imageNamed:@"shangjia1"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    }
                    
                }
              

                scrollview_Advertisement.contentSize = CGSizeMake(viewsArray.count*320.0f,124);
                scrollview_Advertisement.pagingEnabled = YES;
                scrollview_Advertisement.showsHorizontalScrollIndicator = NO;
                scrollview_Advertisement.delegate = self;
                citylabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];
                //citylabel.text=city;
                citylabel.textColor=[UIColor whiteColor];
                
                templabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 70, 40, 20)];
                templabel.textColor=[UIColor whiteColor];
               // templabel.text=tianqi1;
                
                timelabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 70, 60, 20)];
                NSString *tianqi2=[NSString stringWithFormat:@"~ %@",temperature2];
              //  NSLog(@"%@",[NSString stringWithFormat:@"%@~%@",temperature1,temperature2]);

                timelabel.textColor=[UIColor whiteColor];
                //timelabel.text=tianqi2;
                weatherlabel=[[UILabel alloc]initWithFrame:CGRectMake(120, 70, 200, 20)];
               // weatherlabel.text = weather;
                weatherlabel.textColor=[UIColor whiteColor];
                
                Date_label=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, 200, 20)];
                Date_label.textColor=[UIColor whiteColor];

                for (int i = 0; i <viewsArray.count; i++)
                {
                    
                    UIImageView *imageview=[[UIImageView alloc]init];
                    imageview.frame=CGRectMake((320*i), 0, 320,124);
                    [imageview setImageWithURL:[NSURL URLWithString:viewsArray[i]] placeholderImage:[UIImage imageNamed:@"shangjia1"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    [scrollview_Advertisement addSubview:imageview];
                    
                    if (i==0)
                    {
                        [imageview addSubview:citylabel];
                        [imageview addSubview:templabel];
                        [imageview addSubview:timelabel];
                        [imageview addSubview:weatherlabel];
                        [imageview addSubview:Date_label];


                    }
                }
                [scrollview_xiaoqu addSubview:scrollview_Advertisement];
                //使用NSTimer实现定时触发滚动控件滚动的动作。
                timeCount = 0;
                [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
            }
        }];
        
        label_BulletinNotice=[[UILabel alloc]initWithFrame:CGRectMake(10, 128, (Width-35)/4, 64)];
        label_BulletinNotice.textAlignment=NSTextAlignmentCenter;
        label_BulletinNotice.text=@"\n\n账单缴费";
        label_BulletinNotice.numberOfLines=0;
        label_BulletinNotice.textColor=[UIColor whiteColor];
        label_BulletinNotice.backgroundColor=[UIColor colorWithRed:72/255.0 green:185/255.0 blue:215/255.0 alpha:1];
        label_BulletinNotice.font=[UIFont systemFontOfSize:14];
        [scrollview_xiaoqu addSubview:label_BulletinNotice];
        Btn_BulletinNotice=[[UIButton alloc]initWithFrame:CGRectMake(3.6*Width/40, 132, 35, 35)];
        [Btn_BulletinNotice setImage:[UIImage imageNamed:@"p005_笑脸首页.png"] forState:UIControlStateNormal];
        [Btn_BulletinNotice addTarget:self action:@selector(zhangdanjiaofei) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_xiaoqu addSubview:Btn_BulletinNotice];
        
        
        label_bill=[[UILabel alloc]initWithFrame:CGRectMake(15+(Width-35)/4, 128, (Width-35)/4, 64)];
        label_bill.textAlignment=NSTextAlignmentCenter;
        label_bill.text=@"\n\n来拉呱";
        label_bill.numberOfLines=0;
        label_bill.textColor=[UIColor whiteColor];
        label_bill.backgroundColor=[UIColor colorWithRed:248/255.0 green:123/255.0 blue:0/255.0 alpha:1];
        label_bill.font=[UIFont systemFontOfSize:14];
        [scrollview_xiaoqu addSubview:label_bill];
        Btn_bill=[[UIButton alloc]initWithFrame:CGRectMake(13.1*Width/40, 132, 35, 35)];
        [Btn_bill setImage:[UIImage imageNamed:@"p006_笑脸首页.png"] forState:UIControlStateNormal];
        [Btn_bill addTarget:self action:@selector(woyanfayan) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_xiaoqu addSubview:Btn_bill];

        
        label_Speak=[[UILabel alloc]initWithFrame:CGRectMake(20+2*(Width-35)/4, 128, (Width-35)/4, 64)];
        label_Speak.textAlignment=NSTextAlignmentCenter;
        label_Speak.text=@"\n\n报 料";
        label_Speak.numberOfLines=0;
        label_Speak.textColor=[UIColor whiteColor];
        label_Speak.backgroundColor=[UIColor colorWithRed:0/255.0 green:212/255.0 blue:115/255.0 alpha:1];
        label_Speak.font=[UIFont systemFontOfSize:14];
        [scrollview_xiaoqu addSubview:label_Speak];
        Btn_Speak=[[UIButton alloc]initWithFrame:CGRectMake(22.8*Width/40, 132, 35, 35)];
        [Btn_Speak setImage:[UIImage imageNamed:@"p3009.png"] forState:UIControlStateNormal];
        [Btn_Speak addTarget:self action:@selector(woyaobaoliao) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_xiaoqu addSubview:Btn_Speak];

        
        label_LifeHelp=[[UILabel alloc]initWithFrame:CGRectMake(25+3*(Width-35)/4, 128, (Width-35)/4, 64)];
        label_LifeHelp.textAlignment=NSTextAlignmentCenter;
        label_LifeHelp.text=@"\n\n生活帮";
        label_LifeHelp.numberOfLines=0;
        label_LifeHelp.textColor=[UIColor whiteColor];
        label_LifeHelp.backgroundColor=[UIColor colorWithRed:222/255.0 green:60/255.0 blue:84/255.0 alpha:1];
        label_LifeHelp.font=[UIFont systemFontOfSize:14];
        [scrollview_xiaoqu addSubview:label_LifeHelp];
        Btn_LifeHelp=[[UIButton alloc]initWithFrame:CGRectMake(32.3*Width/40, 132, 35, 35)];
        [Btn_LifeHelp setImage:[UIImage imageNamed:@"p007_笑脸首页.png"] forState:UIControlStateNormal];
        [Btn_LifeHelp addTarget:self action:@selector(shenghuobang) forControlEvents:UIControlEventTouchUpInside];
        [scrollview_xiaoqu addSubview:Btn_LifeHelp];
        
        arr_Community=[[NSArray alloc]init];
        arr_News=[[NSArray alloc]init];

        [[NSUserDefaults standardUserDefaults] setObject:area_id  forKey:@"area_id"];
        [[NSUserDefaults standardUserDefaults] setObject:community_id  forKey:@"community_id"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self AddCommunityPreferentialMessageDate];

    /*
     ********
     *********滑动手势****
     ********
     */
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
        
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
-(void)AddCommunityPreferentialMessageDate
{
    NSString *str_area = [SurveyRunTimeData sharedInstance].area_id;
    
    NSString *str_community=[[NSUserDefaults standardUserDefaults] stringForKey: @"community_id"];
    
    

    
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\",\"area_id\":\"%@\",\"city_id\":\"101\",\"community_id\":\"%@\",\"quarter_id\":\"%@\"}",str_area,str_community,xiaoquIDString];
    
    
    //NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\",\"city_id\":\"101\",\"community_id\":\"%@\",\"quarter_id\":\"%@\"}",community_id,xiaoquIDString];
    
    NSLog(@"%@",community_id);
    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
    NSString *str2=@"para=";
    NSString *Str;
    Str=[str2 stringByAppendingString:str_jiami];
    
    arr=[[NSMutableArray alloc]init];
    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_09 Paramters:Str FinishCallbackBlock:^(NSString *result){
        // 执行post请求完成后的逻辑
        if (result.length<=0)
        {
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [aler show];
        }
        else
        {
            
            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
            //NSLog(@"第一次: %@", str_jiemi);
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSError *error = nil;
            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
            NSString *daima=[rootDic objectForKey:@"ecode"];
            int intString = [daima intValue];
            if (intString==4000)
            {
                [self showWithCustomView:@"服务器内部错误"];
            }
            if (intString==1000)
            {
                arr_infoa=[[NSMutableArray array]init];
                arr_infoa=[rootDic objectForKey:@"info"];
                
                NSMutableArray *type_id_arr=[[NSMutableArray alloc]init];
                NSMutableArray *article_id_arr=[[NSMutableArray alloc]init];
                arr_count=[[NSMutableArray alloc]init];
                
                
                /*
                 修改人  赵忠良
                 修改时间 15.3.12
                 修改内容 NSUserDefaults存储造成程序卡死，现修改为plist存储
                 */
                //****************************
                //1. 创建一个plist文件
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                NSString *path=[paths objectAtIndex:0];
                NSLog(@"path = %@",path);
                NSString *name = [NSString stringWithFormat:@"messageCountArr.plist"];
                NSString *filename=[path stringByAppendingPathComponent:name];
                NSMutableArray *messageCountArr = [NSMutableArray array];
                plistDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filename];
                if (!plistDic) {
                    NSFileManager* fm = [NSFileManager defaultManager];
                    [fm createFileAtPath:filename contents:nil attributes:nil];
                    plistDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filename];
                }
                NSArray * messageArr=plistDic[@"messageCountArr"];
                [messageCountArr addObjectsFromArray:messageArr];
                //********************************
                
                
                
                /*
                 修改人  赵忠良
                 修改时间 15.3.11
                 修改内容 添加新的计数统计
                 */
                //****************************

                /*
                NSMutableArray *messageCountArr=[[NSUserDefaults standardUserDefaults] mutableArrayValueForKey: @"messageCountArr"];
                NSMutableArray *mCountArr=[[NSUserDefaults standardUserDefaults] mutableArrayValueForKey: @"mCountArr"];
                
                 */
                if (messageCountArr.count < arr_infoa.count) {
                    messageCountArr = [NSMutableArray array];
                    

                    for (NSDictionary *dic in arr_infoa) {
                        NSLog(@"121");
                        /*
                        NSDictionary *articleDic = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"article_item_id"],@"article_item_id",dic[@"article_id"],@"article_id",@"",@"city_id",@"",@"arear_id",@"",@"community_id",@"",@"quarter_id", nil];
                        [messageCountArr addObject:articleDic];
                         */
                        NSDictionary *articleDic = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"article_item_id"],@"article_item_id",dic[@"article_id"],@"article_id",@"",@"city_id",@"",@"arear_id",@"",@"community_id",@"",@"quarter_id", nil];
                        [messageCountArr addObject:articleDic];
                    }
                    NSMutableDictionary *pDic = [NSMutableDictionary dictionary];
                    [pDic setObject:messageCountArr forKey:@"messageCountArr"];
                    [pDic writeToFile:filename atomically:YES];
                }else{
                    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"session",@"2",@"scope",messageCountArr,@"id_list", nil];
                    NSString *requestStr = [self dictionaryToJson:dic];
                    NSLog(@"%@",str1);
                    NSString *str_jiami=[JiaMiJieMi hexStringFromString:requestStr];
                    NSString *str2=@"para=";
                    NSString *Str;
                    Str=[str2 stringByAppendingString:str_jiami];
                    
                    arr=[[NSMutableArray alloc]init];
                    [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_10 Paramters:Str FinishCallbackBlock:^(NSString *result){
                        // 执行post请求完成后的逻辑
                        if (result.length<=0)
                        {
                            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                            [aler show];
                        }
                        else
                        {
                            
                            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                            NSLog(@"第2次: %@", str_jiemi);
                            SBJsonParser *parser = [[SBJsonParser alloc] init];
                            NSError *error = nil;
                            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                            NSString *daima=[rootDic objectForKey:@"ecode"];
                            int intString = [daima intValue];
                            if (intString==4000)
                            {
                                [self showWithCustomView:@"服务器内部错误"];
                            }
                            if (intString==1000)
                            {
                                NSArray *infoArr = [rootDic objectForKey:@"info"];
                                for (int i = 0; i < infoArr.count; i++) {
                                    NSString *tiaoshu=[infoArr[i] objectForKey:@"count"];
                                    [arr_count addObject:tiaoshu];
                                    UILabel *count_label=[[UILabel alloc]init];
                                    count_label.frame=CGRectMake((self.view.frame.size.width-23)/4 +3, 198+70*i, 20, 20);
                                    count_label.font=[UIFont systemFontOfSize:12];
                                    count_label.textAlignment=NSTextAlignmentCenter;
                                    count_label.layer.cornerRadius=10;
                                    count_label.layer.masksToBounds = YES;
                                    if ([tiaoshu isEqualToString:@"0"])
                                    {
                                        count_label.backgroundColor=[UIColor clearColor];
                                        count_label.textColor=[UIColor clearColor];
                                        
                                    }
                                    else
                                    {
                                        count_label.backgroundColor=[UIColor redColor];
                                        count_label.textColor=[UIColor whiteColor];
                                    }
                                    //                                    count_label.backgroundColor=[UIColor redColor];
                                    //                                    count_label.textColor=[UIColor blackColor];
                                    
                                    count_label.text=tiaoshu;
                                    [scrollview_xiaoqu addSubview:count_label];
                                }
                                
                                
                            }
                        }
                    }];
                }
                
                
                /*
                 小区资讯消息

                 */
                 
                 
                //*****************************
                
                scrollview_xiaoqu.contentSize=CGSizeMake(scrollview_xiaoqu.frame.size.width, 200+72*arr_infoa.count);
                
                int k;
                for (k=0; k<arr_infoa.count; k++)
                {
                    Btn_xiaoqu_beijing=[[UIButton alloc]initWithFrame:CGRectMake(10, 196+70*k, self.view.frame.size.width- 20, 70)];
                    [Btn_xiaoqu_beijing setImage:[UIImage imageNamed:@"渐变1.png"] forState:UIControlStateNormal];
                    //Btn_xiaoqu_beijing.tag=[[arr_infoa[k] objectForKey:@"article_type_id"] intValue];
                    Btn_xiaoqu_beijing.tag=k;
                    
                    [Btn_xiaoqu_beijing setEnabled:YES];
                    [Btn_xiaoqu_beijing addTarget:self action:@selector(GotoSecond:) forControlEvents:UIControlEventTouchUpInside];
                    [scrollview_xiaoqu addSubview:Btn_xiaoqu_beijing];
                    
                    //图片
                    imageview_AddCommunityPreferentialMessageDate=[[UIImageView alloc]initWithFrame:CGRectMake(20, 201+70*k, (self.view.frame.size.width-23)/4, 60)];
                    NSString *imageUrl=[[arr_infoa[k] objectForKey:@"pic"][0] objectForKey:@"thumbs_url"];
                    if (imageUrl.length>0)
                    {
                        [imageview_AddCommunityPreferentialMessageDate setImageWithURL:[NSURL URLWithString:[[arr_infoa[k] objectForKey:@"pic"][0] objectForKey:@"thumbs_url"]] placeholderImage:[UIImage imageNamed:@"shangjia1"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    }
                    else
                    {
                        [imageview_AddCommunityPreferentialMessageDate setImageWithURL:[NSURL URLWithString:[arr_infoa[k] objectForKey:@"article_item_icon"]] placeholderImage:[UIImage imageNamed:@"shangjia1"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                        
                    }
                    
                    [scrollview_xiaoqu addSubview:imageview_AddCommunityPreferentialMessageDate];
                    
                    //标题
                    label_AddCommunityPreferentialMessageDateTitle=[[UILabel alloc]initWithFrame:CGRectMake(31+(self.view.frame.size.width-23)/4, 199+70*k, 2*(self.view.frame.size.width-23)/4, 20)];
                    label_AddCommunityPreferentialMessageDateTitle.text=[arr_infoa[k] objectForKey:@"article_item_name"];
                    label_AddCommunityPreferentialMessageDateTitle.font=[UIFont systemFontOfSize:16];
                    [scrollview_xiaoqu addSubview:label_AddCommunityPreferentialMessageDateTitle];
                    
                    
                    
                    //时间
                    NSString *stringTime =[arr_infoa[k] objectForKey:@"article_date"];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                    NSDate *dateTime = [formatter dateFromString:stringTime];
                    [formatter setDateFormat:@"MM/dd"];
                    NSString *locationString=[formatter stringFromDate:dateTime];
                    label_AddCommunityPreferentialMessageDateTime=[[UILabel alloc]initWithFrame:CGRectMake(3.5*(self.view.frame.size.width-23)/4, 199+70*k, 1.5*(self.view.frame.size.width-23)/8, 20)];
                    label_AddCommunityPreferentialMessageDateTime.text=locationString;
                    label_AddCommunityPreferentialMessageDateTime.textColor=[UIColor grayColor];
                    label_AddCommunityPreferentialMessageDateTime.font=[UIFont systemFontOfSize:12];
                    [scrollview_xiaoqu addSubview:label_AddCommunityPreferentialMessageDateTime];
                    //内容
                    label_AddCommunityPreferentialMessageDateContent=[[UILabel alloc]initWithFrame:CGRectMake(31+(self.view.frame.size.width-23)/4, 216+70*k, 2.8*(self.view.frame.size.width-23)/4, 35)];
                    label_AddCommunityPreferentialMessageDateContent.numberOfLines=2;
                    label_AddCommunityPreferentialMessageDateContent.textColor=[UIColor grayColor];
                    label_AddCommunityPreferentialMessageDateContent.text=[arr_infoa[k] objectForKey:@"title"];
                    label_AddCommunityPreferentialMessageDateContent.font=[UIFont systemFontOfSize:14];
                    [scrollview_xiaoqu addSubview:label_AddCommunityPreferentialMessageDateContent];
                    
                    
                }
                /*
                 //错误计数统计
                 
                NSArray *a=[[NSUserDefaults standardUserDefaults] arrayForKey: @"shengyutiaoshu_article_item_id"];
                NSArray *b=[[NSUserDefaults standardUserDefaults] arrayForKey: @"shengyutiaoshu_article_id"];
                
                
                // NSArray *tiaoshu=[[NSUserDefaults standardUserDefaults] objectForKey: @"shengyutiaoshu"];
                //                NSDictionary *b=[[NSUserDefaults standardUserDefaults] objectForKey: @"shengyutiaoshu"];
                //
                //                NSMutableArray *arr_i=[[NSMutableArray array]init];
                //                arr_i=[b objectForKey:@"info"];
                
                NSLog(@"%@  tiaoshu :%d   ||||   %@      %d",a,a.count,b,b.count);
                
                // NSArray *tiaoshu=[userDefaulte arrayForKey:@"shengyutiaoshu"];
                if (a.count>0)
                {
                    
                    int j;
                    for (j=0; j<a.count; j++)
                    {
                        
                        //                        // 资讯栏目ID
                        //                        NSString *type_id=[arr_infoa[j] objectForKey:@"article_item_id"];
                        //
                        //                        // 资讯ID (本类别最新的资讯id)
                        //                        NSString *article_id=[arr_infoa[j] objectForKey:@"article_id"];
                        //
                        // 资讯栏目ID
                        NSString *type_id=a[j];
                        
                        // 资讯ID (本类别最新的资讯id)
                        NSString *article_id=b[j];
                        
                        
                        
                        
                        //                        NSString *city_id=[arr_infoa[j] objectForKey:@"city_id"];
                        //                        NSString *community_id=[arr_infoa[j] objectForKey:@"community_id"];
                        //                        NSString *quarter_id=[arr_infoa[j] objectForKey:@"quarter_id"];
                        //                        NSString *xianqu_id=[arr_infoa[j] objectForKey:@"area_id"];
                        //
                        
                        //NSString *str1=[NSString stringWithFormat:@"{\"id_list\":[{\"article_item_id\":\"%@\",\"article_id\":\"%@\",\"city_id\":\"%@\",\"area_id\":\"%@\",\"community_id\":\"%@\",\"quarter_id\":\"%@\"}],\"scope\":\"2\",\"session\":\"\"}",type_id,article_id,city_id,xianqu_id,community_id,quarter_id];
                        NSString *str1=[NSString stringWithFormat:@"{\"id_list\":[{\"article_item_id\":\"%@\",\"article_id\":\"%@\",\"city_id\":\"%@\",\"area_id\":\"%@\",\"community_id\":\"%@\",\"quarter_id\":\"%@\"}],\"scope\":\"2\",\"session\":\"\"}",type_id,article_id,@"",@"",@"",@""];
                        
                        
                        NSLog(@"%@",str1);
                        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                        NSString *str2=@"para=";
                        NSString *Str;
                        Str=[str2 stringByAppendingString:str_jiami];
                        
                        arr=[[NSMutableArray alloc]init];
                        [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_10 Paramters:Str FinishCallbackBlock:^(NSString *result){
                            // 执行post请求完成后的逻辑
                            if (result.length<=0)
                            {
                                UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                [aler show];
                            }
                            else
                            {
                                
                                NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                                NSLog(@"第2次: %@", str_jiemi);
                                SBJsonParser *parser = [[SBJsonParser alloc] init];
                                NSError *error = nil;
                                NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
                                NSString *daima=[rootDic objectForKey:@"ecode"];
                                int intString = [daima intValue];
                                if (intString==4000)
                                {
                                    [self showWithCustomView:@"服务器内部错误"];
                                }
                                if (intString==1000)
                                {
                                    NSString *tiaoshu=[[rootDic objectForKey:@"info"][0] objectForKey:@"count"];
                                    [arr_count addObject:tiaoshu];
                                    UILabel *count_label=[[UILabel alloc]init];
                                    count_label.frame=CGRectMake((self.view.frame.size.width-23)/4, 195+72*j, 20, 20);
                                    count_label.font=[UIFont systemFontOfSize:12];
                                    count_label.textAlignment=NSTextAlignmentCenter;
                                    count_label.layer.cornerRadius=10;
                                    count_label.layer.masksToBounds = YES;
                                    if ([tiaoshu isEqualToString:@"0"])
                                    {
                                        count_label.backgroundColor=[UIColor clearColor];
                                        count_label.textColor=[UIColor clearColor];
                                        
                                    }
                                    else
                                    {
                                        count_label.backgroundColor=[UIColor redColor];
                                        count_label.textColor=[UIColor whiteColor];
                                    }
                                    //                                    count_label.backgroundColor=[UIColor redColor];
                                    //                                    count_label.textColor=[UIColor blackColor];
                                    
                                    count_label.text=tiaoshu;
                                    [scrollview_xiaoqu addSubview:count_label];
                                    
                                }
                            }
                        }];
                        
                    }
                    
                }
                else
                {
                    int h;
                    for (h=0; h<arr_infoa.count; h++)
                    {
                        
                        
                        NSString *type_id=[arr_infoa[h] objectForKey:@"article_item_id"];
                        
                        [type_id_arr addObject:type_id];
                        // 资讯ID (本类别最新的资讯id)
                        NSString *article_id=[arr_infoa[h] objectForKey:@"article_id"];
                        [article_id_arr addObject:article_id];
                        NSLog(@"%@   %@",type_id,article_id);
                        
                    }
                    [[NSUserDefaults standardUserDefaults] setObject:type_id_arr  forKey:@"shengyutiaoshu_article_item_id"];
                    [[NSUserDefaults standardUserDefaults] setObject:article_id_arr  forKey:@"shengyutiaoshu_article_id"];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                 */
                
            }
        }
    }];
    
}


//-(void)AddCommunityPreferentialMessageDate
//{
//    //NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\",\"city_id\":\"101\",\"community_id\":\"%@\",\"quarter_id\":\"%@\"}",community_id,xiaoquIDString];
//    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"\",\"city_id\":\"101\",\"community_id\":\"\",\"quarter_id\":\"\"}"];
//
//    NSLog(@"%@",community_id);
//    NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
//    NSString *str2=@"para=";
//    NSString *Str;
//    Str=[str2 stringByAppendingString:str_jiami];
//
//    arr=[[NSMutableArray alloc]init];
//    [HttpPostExecutor postExecuteWithUrlStr:ZhuYeXiaoQuZiXun_m38_07 Paramters:Str FinishCallbackBlock:^(NSString *result){
//                // 执行post请求完成后的逻辑
//        if (result.length<=0)
//        {
//            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                        [aler show];
//        }
//        else
//        {
//    
//            NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
//            NSLog(@"第一次: %@", str_jiemi);
//            SBJsonParser *parser = [[SBJsonParser alloc] init];
//            NSError *error = nil;
//            NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//            NSString *daima=[rootDic objectForKey:@"ecode"];
//            int intString = [daima intValue];
//            if (intString==4000)
//            {
//                [self showWithCustomView:@"服务器内部错误"];
//            }
//            if (intString==1000)
//            {
//                arr_infoa=[[NSMutableArray array]init];
//                arr_infoa=[rootDic objectForKey:@"info"];
//                
//                NSMutableArray *type_id_arr=[[NSMutableArray alloc]init];
//                arr_count=[[NSMutableArray alloc]init];
//                
//                scrollview_xiaoqu.contentSize=CGSizeMake(scrollview_xiaoqu.frame.size.width, 200+72*arr_infoa.count);
//
//                
//                for (k=0; k<arr_infoa.count; k++)
//                {
//                    Btn_xiaoqu_beijing=[[UIButton alloc]initWithFrame:CGRectMake(0, 196+72*k, self.view.frame.size.width, 70)];
//                    [Btn_xiaoqu_beijing setImage:[UIImage imageNamed:@"渐变1.png"] forState:UIControlStateNormal];
//                    //Btn_xiaoqu_beijing.tag=[[arr_infoa[k] objectForKey:@"article_type_id"] intValue];
//                    Btn_xiaoqu_beijing.tag=k;
//
//                    [Btn_xiaoqu_beijing setEnabled:YES];
//                    [Btn_xiaoqu_beijing addTarget:self action:@selector(GotoSecond:) forControlEvents:UIControlEventTouchUpInside];
//                    [scrollview_xiaoqu addSubview:Btn_xiaoqu_beijing];
//
//                    //图片
//                    imageview_AddCommunityPreferentialMessageDate=[[UIImageView alloc]initWithFrame:CGRectMake(10, 201+72*k, (self.view.frame.size.width-23)/4, 60)];
//                    NSString *imageUrl=[[arr_infoa[k] objectForKey:@"pic"][0] objectForKey:@"thumbs_url"];
//                    if (imageUrl.length>0)
//                    {
//                        [imageview_AddCommunityPreferentialMessageDate setImageWithURL:[NSURL URLWithString:[[arr_infoa[k] objectForKey:@"pic"][0] objectForKey:@"thumbs_url"]] placeholderImage:[UIImage imageNamed:@"shangjia1"] options:SDWebImageRetryFailed usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//                    }
//                    else
//                    {
//                        imageview_AddCommunityPreferentialMessageDate.image=[UIImage imageNamed:@"video0916.png"];
//                    }
//                    
//                    [scrollview_xiaoqu addSubview:imageview_AddCommunityPreferentialMessageDate];
//        
//                    //标题
//                    label_AddCommunityPreferentialMessageDateTitle=[[UILabel alloc]initWithFrame:CGRectMake(21+(self.view.frame.size.width-23)/4, 199+72*k, 2*(self.view.frame.size.width-23)/4, 20)];
//                    label_AddCommunityPreferentialMessageDateTitle.text=[arr_infoa[k] objectForKey:@"article_type_name"];
//                    label_AddCommunityPreferentialMessageDateTitle.font=[UIFont systemFontOfSize:16];
//                    [scrollview_xiaoqu addSubview:label_AddCommunityPreferentialMessageDateTitle];
//                    
//                    
//                   
//                    //时间
//                    NSString *stringTime =[arr_infoa[k] objectForKey:@"article_date"];
//                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
//                    NSDate *dateTime = [formatter dateFromString:stringTime];
//                    [formatter setDateFormat:@"MM/dd"];
//                    NSString *locationString=[formatter stringFromDate:dateTime];
//                    label_AddCommunityPreferentialMessageDateTime=[[UILabel alloc]initWithFrame:CGRectMake(3.5*(self.view.frame.size.width-23)/4, 199+72*k, 1.5*(self.view.frame.size.width-23)/8, 20)];
//                    label_AddCommunityPreferentialMessageDateTime.text=locationString;
//                    label_AddCommunityPreferentialMessageDateTime.textColor=[UIColor grayColor];
//                    label_AddCommunityPreferentialMessageDateTime.font=[UIFont systemFontOfSize:12];
//                    [scrollview_xiaoqu addSubview:label_AddCommunityPreferentialMessageDateTime];
//                    //内容
//                    label_AddCommunityPreferentialMessageDateContent=[[UILabel alloc]initWithFrame:CGRectMake(21+(self.view.frame.size.width-23)/4, 216+72*k, 2.8*(self.view.frame.size.width-23)/4, 35)];
//                    label_AddCommunityPreferentialMessageDateContent.numberOfLines=2;
//                    label_AddCommunityPreferentialMessageDateContent.textColor=[UIColor grayColor];
//                    label_AddCommunityPreferentialMessageDateContent.text=[arr_infoa[k] objectForKey:@"title"];
//                    label_AddCommunityPreferentialMessageDateContent.font=[UIFont systemFontOfSize:14];
//                    [scrollview_xiaoqu addSubview:label_AddCommunityPreferentialMessageDateContent];
//
//
//                }
//
//                
//                int j;
//                for (j=0; j<arr_infoa.count; j++)
//                {
//                
//                    // 资讯类别ID
//                    
//                   
//                
//                NSString *type_id=[arr_infoa[j] objectForKey:@"article_type_id"];
//                [type_id_arr addObject:type_id];
//                // 资讯ID (本类别最新的资讯id)
//                NSString *article_id=[arr_infoa[j] objectForKey:@"article_id"];
//                NSString *city_id=[arr_infoa[j] objectForKey:@"city_id"];
//                NSString *community_id=[arr_infoa[j] objectForKey:@"community_id"];
//                NSString *quarter_id=[arr_infoa[j] objectForKey:@"quarter_id"];
//
//                
//                NSString *str1=[NSString stringWithFormat:@"{\"id_list\":[{\"article_id\":\"%@\",\"city_id\":\"%@\",\"community_id\":\"%@\",\"quarter_id\":\"%@\",\"type_id\":\"%@\"}],\"scope\":\"2\",\"session\":\"\"}",article_id,city_id,community_id,quarter_id,type_id];
//                
//                
//                NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
//                NSString *str2=@"para=";
//                NSString *Str;
//                Str=[str2 stringByAppendingString:str_jiami];
//                
//                arr=[[NSMutableArray alloc]init];
//                [HttpPostExecutor postExecuteWithUrlStr:ZhuYeXiaoQuZiXun_m38_08 Paramters:Str FinishCallbackBlock:^(NSString *result){
//                    // 执行post请求完成后的逻辑
//                    if (result.length<=0)
//                    {
//                        UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                        [aler show];
//                    }
//                    else
//                    {
//                        
//                        NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
//                       // NSLog(@"第2次: %@", str_jiemi);
//                        SBJsonParser *parser = [[SBJsonParser alloc] init];
//                        NSError *error = nil;
//                        NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
//                        NSString *daima=[rootDic objectForKey:@"ecode"];
//                        int intString = [daima intValue];
//                        if (intString==4000)
//                        {
//                            [self showWithCustomView:@"服务器内部错误"];
//                        }
//                        if (intString==1000)
//                        {
//                            NSString *tiaoshu=[[rootDic objectForKey:@"info"][0] objectForKey:@"count"];
//                            [arr_count addObject:tiaoshu];
//                            UILabel *count_label=[[UILabel alloc]init];
//                            count_label.frame=CGRectMake((self.view.frame.size.width-23)/4, 195+72*j, 20, 20);
//                            count_label.font=[UIFont systemFontOfSize:12];
//                            count_label.textAlignment=NSTextAlignmentCenter;
//                            count_label.layer.cornerRadius=10;
//                            count_label.layer.masksToBounds = YES;
//                            if ([tiaoshu isEqualToString:@"0"])
//                            {
//                                count_label.backgroundColor=[UIColor clearColor];
//                                count_label.textColor=[UIColor clearColor];
//
//                            }
//                            else
//                            {
//                                count_label.backgroundColor=[UIColor redColor];
//                                count_label.textColor=[UIColor blackColor];
//                            }
////                            count_label.backgroundColor=[UIColor redColor];
////                            count_label.textColor=[UIColor blackColor];
//
//                            count_label.text=tiaoshu;
//                            [scrollview_xiaoqu addSubview:count_label];
//
//                        }
//                    }
//                }];
//
//            }
//            }
//        }
//    }];
//    
//}
//
//定时滚动
-(void)scrollTimer
{
    timeCount ++;
    if (timeCount ==viewsArray.count)
    {
        timeCount = 0;
    }
    [scrollview_Advertisement scrollRectToVisible:CGRectMake(timeCount *320, 65, 320,114) animated:YES];
}
#pragma mark - 新闻咨询界面跳转 -
-(void)GotoSecond:(UIButton*)sender
{
    
    //修改获取信息错误问题
    UIButton *butt=[[UIButton alloc] init];
    butt=sender;
    int t=butt.tag;
    WDNum=t;
    NSLog(@"%d",WDNum);
    Title_label=[arr_infoa[t] objectForKey:@"article_item_name"];
    
    Article_type_id=[[arr_infoa[t] objectForKey:@"article_item_id"] intValue];
    [SurveyRunTimeData sharedInstance].agency_id = [arr_infoa[t] objectForKey:@"agency_id"];
    
//    
//    [SurveyRunTimeData sharedInstance].area_id = [arr_infoa[t] objectForKey:@"area_id"];
//    [SurveyRunTimeData sharedInstance].agency_id = [arr_infoa[t] objectForKey:@"agency_id"];
//    [SurveyRunTimeData sharedInstance].city_id = [arr_infoa[t] objectForKey:@"city_id"];
//    [SurveyRunTimeData sharedInstance].community_id = [arr_infoa[t] objectForKey:@"community_id"];
//    [SurveyRunTimeData sharedInstance].quarter_id = [arr_infoa[t] objectForKey:@"quarter_id"];
    
    /*
     修改人 赵忠良
     修改时间 15.3.12
     修改内容 NSUserDefaults存储造成程序卡死，现修改为plist存储
     */

    //**************************************
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSLog(@"path = %@",path);
    NSString *name = [NSString stringWithFormat:@"messageCountArr.plist"];
    NSString *filename=[path stringByAppendingPathComponent:name];
    NSMutableArray *messageCountArr = [NSMutableArray array];
    plistDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filename];
    NSArray * messageArr=plistDic[@"messageCountArr"];
    [messageCountArr addObjectsFromArray:messageArr];
    
    NSDictionary *articleDic = [NSDictionary dictionaryWithObjectsAndKeys:[arr_infoa[t] objectForKey:@"article_item_id"],@"article_item_id",[arr_infoa[t] objectForKey:@"article_id"],@"article_id",@"",@"city_id",@"",@"arear_id",@"",@"community_id",@"",@"quarter_id", nil];
    //    [messageCountArr setObject:articleDic atIndexedSubscript:t];
    [messageCountArr replaceObjectAtIndex:t withObject:articleDic];
    
    NSMutableDictionary *pDic = [NSMutableDictionary dictionary];
    [pDic setObject:messageCountArr forKey:@"messageCountArr"];
    [pDic writeToFile:filename atomically:YES];
    //******************************************
    
    /*
     修改人  赵忠良
     修改时间 15.3.11
     修改内容 添加新的计数统计
     */
    /*
     ******************************************
    NSMutableArray *messageCountArr=[[NSUserDefaults standardUserDefaults] mutableArrayValueForKey: @"messageCountArr"];
    NSDictionary *articleDic = [NSDictionary dictionaryWithObjectsAndKeys:[arr_infoa[t] objectForKey:@"article_item_id"],@"article_item_id",[arr_infoa[t] objectForKey:@"article_id"],@"article_id",@"",@"city_id",@"",@"arear_id",@"",@"community_id",@"",@"quarter_id", nil];
//    [messageCountArr setObject:articleDic atIndexedSubscript:t];
    [messageCountArr replaceObjectAtIndex:t withObject:articleDic];

//    [[NSUserDefaults standardUserDefaults] setObject:messageCountArr  forKey:@"message"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     *******************************************
     */
    
    
    
    AXHSQDynamicViewController *sqDyVCtr = [[AXHSQDynamicViewController alloc]initWithNibName:nil bundle:nil withTitle:Title_label withType:Article_type_id];
    UINavigationController *NAVCtr = [[UINavigationController alloc]initWithRootViewController:sqDyVCtr];
    [self presentViewController:NAVCtr animated:YES completion:NULL];
    
    

}
-(void)addPreferentialMessageDate
{
     @try
    {
        if([CheckNetwork isExistenceNetwork]==1)
        {
            
            NSString *str1=@"{\"session\":\"\",\"city_id\":\"101\",\"area_id\":\"\",\"agency_id\":\"\",\"community_id\":\"\",\"quarter_id\":\"\",\"article_type_id\":\"60\"}";
            NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
            NSString *str2=@"para=";
            NSString *Str;
            Str=[str2 stringByAppendingString:str_jiami];
            arr=[[NSMutableArray alloc]init];
            
            [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_01 Paramters:Str FinishCallbackBlock:^(NSString *result){
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
                    
                    NSArray *shuzu=[[NSArray alloc]init];
                    shuzu=[rootDic objectForKey:@"id_list"];
                  //  NSLog(@"%@",shuzu);
                    int i;

                    for (i=0; i<3; i++)
                    {
                        NSDictionary *dic=[[NSDictionary alloc]init];
                        dic=[shuzu objectAtIndex:i];
                        NSString *stringInt =[dic objectForKey:@"id"];
                        [arr addObject:stringInt];
                    }
                    if ([arr count]==0)
                    {
                        
                    }
                    if ([arr count]==1)
                    {
                        fuwu *gonggao =[[fuwu alloc]init];
                        NSArray *workItems = [[NSArray alloc]initWithArray:shuzu];
                        gonggao.id_list = workItems;
                        
                        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                        // NSLog(@"=======%@",str1);
                        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                        NSString *str2=@"para=";
                        NSString *Str;
                        Str=[str2 stringByAppendingString:str_jiami];
                        [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02                                          Paramters:Str FinishCallbackBlock:^(NSString *result)
                         {
                             // 执行post请求完成后的逻辑
                             // NSLog(@"第二次:sssssssssss %@", result);
                             //创建解析器
                             if (result.length<=0)
                             {
                                 UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                 [aler show];
                             }
                             else
                             {
                                 
                                 NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                                 SBJsonParser *parser=[[SBJsonParser alloc]init];
                                 NSError *error=nil;
                                 NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                                 NSString *daima=[rootDic objectForKey:@"ecode"];
                                 int intString = [daima intValue];
                                 if (intString==4000)
                                 {
                                     [self showWithCustomView:@"服务器内部错误"];
                                 }
                                 if (intString==1000)
                                 {
                                     NSMutableArray *info=[[NSMutableArray array]init];
                                     info=[rootDic objectForKey:@"info"];
                                    
                                     imageview_AddPreferentialMessageDateUp=[[UIImageView alloc]initWithFrame:CGRectMake(10, 313, (self.view.frame.size.width-23)/4, 65)];
                                     [imageview_AddPreferentialMessageDateUp setImageWithURL:[NSURL URLWithString:[info[0] objectForKey:@"pic_url"]]
                                                                            placeholderImage:[UIImage imageNamed:@"shangjia1"]
                                                                                     options:SDWebImageRetryFailed
                                                                 usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                                     [scrollview_zhoubian addSubview:imageview_AddPreferentialMessageDateUp];
                                     
                                     label_AddPreferentialMessageDateTitle=[[UILabel alloc]initWithFrame:CGRectMake(11+(self.view.frame.size.width-23)/4, 313, 2*(self.view.frame.size.width-23)/4, 20)];
                                     label_AddPreferentialMessageDateTitle.text=[info[0] objectForKey:@"title"];
                                     label_AddPreferentialMessageDateTitle.font=[UIFont systemFontOfSize:16];
                                     [scrollview_zhoubian addSubview:label_AddPreferentialMessageDateTitle];
                                     NSString *aaa=[info[0] objectForKey:@"createdate"];
                                     NSString *bbb=[aaa substringWithRange:NSMakeRange(5,5)];
                                     label_AddPreferentialMessageDateTime=[[UILabel alloc]initWithFrame:CGRectMake(3.5*(self.view.frame.size.width-23)/4, 313, (self.view.frame.size.width-23)/8, 20)];
                                     label_AddPreferentialMessageDateTime.text=bbb;
                                     label_AddPreferentialMessageDateTime.font=[UIFont systemFontOfSize:14];
                                     [scrollview_zhoubian addSubview:label_AddPreferentialMessageDateTime];
                                     
                                     label_AddPreferentialMessageDateContent=[[UILabel alloc]initWithFrame:CGRectMake(11+(self.view.frame.size.width-23)/4, 330, 2.8*(self.view.frame.size.width-23)/4, 35)];
                                     label_AddPreferentialMessageDateContent.numberOfLines=2;
                                     label_AddPreferentialMessageDateContent.textColor=[UIColor grayColor];
                                     label_AddPreferentialMessageDateContent.text=[info[0] objectForKey:@"content"];
                                     label_AddPreferentialMessageDateContent.font=[UIFont systemFontOfSize:14];
                                     [scrollview_zhoubian addSubview:label_AddPreferentialMessageDateContent];
                                     
                                 }
                             }
                         }];
                        
                    }
                    
                    if ([arr count]>=2)
                    {
                        fuwu *gonggao =[[fuwu alloc]init];
                        
                        WorkItem *workItem1 =[[WorkItem alloc]init];
                        NSString *a=[arr objectAtIndex:0];
                        workItem1.id=a;
                        WorkItem *workItem2 =[[WorkItem alloc]init];
                        NSString *b=[arr objectAtIndex:1];
                        workItem2.id=b;
                        NSArray *workItems = [[NSArray alloc] initWithObjects:workItem1,workItem2, nil];
                        gonggao.id_list = workItems;
                        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:gonggao childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
                       // NSLog(@"参数 ：%@",str1);
                        
                        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
                        NSString *str2=@"para=";
                        NSString *Str;
                        Str=[str2 stringByAppendingString:str_jiami];
                        [HttpPostExecutor postExecuteWithUrlStr:ZiXunXinXi_m38_02 Paramters:Str FinishCallbackBlock:^(NSString *result)
                         {
                             // 执行post请求完成后的逻辑
                             // NSLog(@"第二次:sssssssssss %@", result);
                             //创建解析器
                             if (result.length<=0)
                             {
                                 UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                 [aler show];
                             }
                             else
                             {
                                 
                                 NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                                 NSLog(@"第二次:sssssssssss %@", str_jiemi);
                                 SBJsonParser *parser=[[SBJsonParser alloc]init];
                                 NSError *error=nil;
                                 NSDictionary *rootDic=[parser objectWithString:str_jiemi error:&error];
                                 NSString *daima=[rootDic objectForKey:@"ecode"];
                                 int intString = [daima intValue];
                                 if (intString==4000)
                                 {
                                     [self showWithCustomView:@"服务器内部错误"];
                                 }
                                 if (intString==1000)
                                 {
                                     NSMutableArray *info=[[NSMutableArray array]init];
                                     info=[rootDic objectForKey:@"info"];
                                     
                                     for (int k=0; k<info.count; k++)
                                     {
                                     NSString *image_url1=[[info[k] objectForKey:@"pic"][0] objectForKey:@"pic_url"];
                                     imageview_AddPreferentialMessageDateUp=[[UIImageView alloc]initWithFrame:CGRectMake(10, 313+73*k, (self.view.frame.size.width-23)/4, 65)];
                                     [imageview_AddPreferentialMessageDateUp setImageWithURL:[NSURL URLWithString:image_url1]
                                                                          placeholderImage:[UIImage imageNamed:@"shangjia1"]
                                                                                   options:SDWebImageRetryFailed
                                                               usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                                     [scrollview_zhoubian addSubview:imageview_AddPreferentialMessageDateUp];
                                     
                                     label_AddPreferentialMessageDateTitle=[[UILabel alloc]initWithFrame:CGRectMake(11+(self.view.frame.size.width-23)/4, 313+73*k, 2*(self.view.frame.size.width-23)/4, 20)];
                                     label_AddPreferentialMessageDateTitle.text=[info[k] objectForKey:@"title"];
                                     label_AddPreferentialMessageDateTitle.font=[UIFont systemFontOfSize:16];
                                    [scrollview_zhoubian addSubview:label_AddPreferentialMessageDateTitle];
                                     NSString *aaa=[info[k] objectForKey:@"article_date"];
                                     NSString *bbb=[aaa substringWithRange:NSMakeRange(5,5)];
                                     label_AddPreferentialMessageDateTime=[[UILabel alloc]initWithFrame:CGRectMake(3.5*(self.view.frame.size.width-23)/4, 313+73*k, (self.view.frame.size.width-23)/8, 20)];
                                     label_AddPreferentialMessageDateTime.text=bbb;
                                     label_AddPreferentialMessageDateTime.font=[UIFont systemFontOfSize:14];
                                     [scrollview_zhoubian addSubview:label_AddPreferentialMessageDateTime];
                                     
                                     label_AddPreferentialMessageDateContent=[[UILabel alloc]initWithFrame:CGRectMake(11+(self.view.frame.size.width-23)/4, 330+73*k, 2.8*(self.view.frame.size.width-23)/4, 35)];
                                     label_AddPreferentialMessageDateContent.numberOfLines=2;
                                     label_AddPreferentialMessageDateContent.textColor=[UIColor grayColor];
                                     label_AddPreferentialMessageDateContent.text=[info[k] objectForKey:@"content"];
                                     label_AddPreferentialMessageDateContent.font=[UIFont systemFontOfSize:14];
                                     [scrollview_zhoubian addSubview:label_AddPreferentialMessageDateContent];

                                     label_PreferentialMessageTitle=[[UILabel alloc]initWithFrame:CGRectMake(3.4*self.view.frame.size.width/4, 365+73*k, self.view.frame.size.width/8, 15)];
                                     label_PreferentialMessageTitle.backgroundColor=[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:0.6];
                                     label_PreferentialMessageTitle.text=@"优惠资讯";
                                     label_PreferentialMessageTitle.textColor=[UIColor whiteColor];
                                     label_PreferentialMessageTitle.font=[UIFont systemFontOfSize:10];
                                     [scrollview_zhoubian addSubview:label_PreferentialMessageTitle];
                                     
                                     
                                    }
                                 }
                             }
                         }];
                    }
                }
            }];
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
-(void)Login
{
    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
    {
        GeRenXinXiWanShanViewController *wanshan=[[GeRenXinXiWanShanViewController alloc]init];
        [self presentViewController:wanshan animated:YES completion:nil];
    }
    else
    {   shouyeViewController *loqin=[[shouyeViewController alloc]init];
        [loqin setDelegate_:self];
        [self presentViewController:loqin animated:NO completion:nil];
    }
}
-(void)Logout
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
                         Session=@"";
                         [view_wode addSubview:DengLuBtn];
                         imageview_HeadPortraits.frame=CGRectMake((self.view.frame.size.width-40)/2, 25, 40, 40);
                         DengLuBtn.frame=CGRectMake(self.view.frame.size.width/3, 70, self.view.frame.size.width/3, 25);
                         [Btn_Logout removeFromSuperview];
                         [Btn_ForgotPassword removeFromSuperview];
                         [label_NickName removeFromSuperview];
                         [label_Member removeFromSuperview];
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
-(void)YouHuiZiXun
{
    PreferentialINFOViewController *youhui=[[PreferentialINFOViewController alloc]init];
    [self presentViewController:youhui animated:NO completion:nil];
}
-(void)EARNFaceMoney
{

}
-(void)MyFaceMoneyDetails
{
    
}
-(void)MyFaceMoney
{

}
-(void)MyProfile
{
    
}
-(void)ForgotPassword
{
    ModifyPasswordViewController *zhaohui=[[ModifyPasswordViewController alloc]init];
    [self presentViewController:zhaohui animated:NO completion:nil];
}
-(void)woyaobaoliao
{
        AXHNewPostViewController *BLVCtr = [[AXHNewPostViewController alloc]initWithNibName:@"AXHNewPostViewController" bundle:nil withType:PostTypeNews withBackDict:nil];
        UINavigationController *naVCtr = [[UINavigationController alloc]initWithRootViewController:BLVCtr];
        [self presentViewController:naVCtr animated:YES completion:NULL];
        
    
}
-(void)gonggaotongzhi
{
//    TongZhiViewController *tongzhiview=[[TongZhiViewController alloc]init];
//    [self presentViewController:tongzhiview animated:NO completion:nil];
    PropertyNoticeViewController *tongzhiview=[[PropertyNoticeViewController alloc]init];
    [self presentViewController:tongzhiview animated:NO completion:nil];

}
-(void)zhangdanjiaofei
{
    KuaiJieJiaoFeiViewController *jiaofei=[[KuaiJieJiaoFeiViewController alloc]init];
    [self presentViewController:jiaofei animated:NO completion:nil];
}
-(void)woyanfayan
{
    if (![Session isEqualToString:@""] && Session.length>0)
    {
        AXHSQForumViewController *sqForVCtr = [[AXHSQForumViewController alloc]init];
        UINavigationController *NAVCtr = [[UINavigationController alloc]initWithRootViewController:sqForVCtr];
        [self presentViewController:NAVCtr animated:NO completion:nil];

    }
    else
    {
        [self Login];
    }

}
-(void)shenghuobang
{
    LifeToHelpViewController *lToHelpVCtr = [[LifeToHelpViewController alloc]init];
    UINavigationController *naVCtr = [[UINavigationController alloc]initWithRootViewController:lToHelpVCtr];
    [self presentViewController:naVCtr animated:YES completion:NULL];
}
-(void)shequxuanze
{

    if (![Session isEqualToString:@""] && Session.length>0)
    {
        
    }
    else
    {
    SheQuXuanZeViewController *xuanze=[[SheQuXuanZeViewController alloc]init];
    [self presentViewController:xuanze animated:NO completion:nil];
    }


}
#pragma mark -
#pragma mark ASIHTTPRequestDelegate
- (void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"请求开始了");
}

- (void)requestFinished:(ASIHTTPRequest *)request
 {
    
	[activityIndicator stopAnimating];
	 NSString *str = request.responseString;
    NSMutableDictionary *jsonoObj = [str JSONValue];
    NSLog(@"天气信息 ：%@",jsonoObj);
    NSMutableDictionary *jsonoSubObj = [jsonoObj objectForKey:@"weatherinfo"];
    city = [[NSString alloc] initWithFormat:@"%@\n",[jsonoSubObj objectForKey:@"city"]];
    
    weather =[[NSString alloc] initWithFormat:@"%@\n",[jsonoSubObj objectForKey:@"weather"]];
    
    temperature1 =[[NSString alloc] initWithFormat:@"%@\n",[jsonoSubObj objectForKey:@"temp2"]];
    temperature2=[[NSString alloc] initWithFormat:@"%@\n",[jsonoSubObj objectForKey:@"temp1"]];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM月dd日"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSString*weekStr;
    if([comps weekday]==1)
    {
        weekStr=@"星期天";
    }else if([comps weekday]==2){
        weekStr=@"星期一";
        
    }else if([comps weekday]==3){
        weekStr=@"星期二";
        
    }else if([comps weekday]==4){
        weekStr=@"星期三";
        
    }else if([comps weekday]==5){
        weekStr=@"星期四";
        
    }else if([comps weekday]==6){
        weekStr=@"星期五";
        
    }else {
        weekStr=@"星期六";
        
    }
    
    if ([weather isKindOfClass:[NSNull class]])
    {
        citylabel.text = city;
        weatherlabel.text = weather;
        templabel.text=temperature1;
        timelabel.text=[NSString stringWithFormat:@" ~ %@",temperature2];
        Date_label.text =[NSString stringWithFormat:@"%@%@",locationString,weekStr];
        
    }
    

}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"请求失败了");
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
}
-(void)meishi
{
    Type=@"9";
    SheQuFuWu_Title=@"美食";
    /*
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:YES completion:nil];
     */
    
    /*
     修改人 赵忠良
     修改时间 15.3.11
     修改原因：解决重复返回及返回页面错误的问题
     */
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    UINavigationController *nVC = [[UINavigationController alloc]initWithRootViewController:fuwu];
    nVC.navigationBar.hidden = YES;
    [self presentViewController:nVC animated:YES completion:nil];
}
-(void)waimai
{
    Type=@"8";
    SheQuFuWu_Title=@"外卖";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}
-(void)weixiu
{
    Type=@"1";
    SheQuFuWu_Title=@"维修";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}
-(void)jiazheng
{
    Type=@"3";
    SheQuFuWu_Title=@"家政";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}
-(void)yiliao
{
    Type=@"4";
    SheQuFuWu_Title=@"医疗";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}
-(void)jiudian
{
    Type=@"7";
    SheQuFuWu_Title=@"酒店";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];
    
}
-(void)jianshen
{
    Type=@"13";
    SheQuFuWu_Title=@"健身";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];
}
-(void)luyou
{
    Type=@"12";
    SheQuFuWu_Title=@"旅游";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];
}
-(void)yule
{
    Type=@"10";
    SheQuFuWu_Title=@"娱乐";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}
-(void)ershou
{
    Type=@"17";
    SheQuFuWu_Title=@"酒水";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];
}
-(void)peixun
{
    Type=@"11";
    SheQuFuWu_Title=@"培训";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}
-(void)gengduo
{
    Type=@"18";
    SheQuFuWu_Title=@"房产";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];

}
-(void)youhuiquan
{
    Type=@"16";
    SheQuFuWu_Title=@"家具";
    FuWwYingYongViewController *fuwu=[[FuWwYingYongViewController alloc]init];
    [self presentViewController:fuwu animated:NO completion:nil];
}
-(void)Preferential
{
    AXHYHGoodsViewController *yhGoodsVCtr = [[AXHYHGoodsViewController alloc]initWithNibName:nil bundle:nil withType:GoodsTypeDefault];
    UINavigationController *naVCtr = [[UINavigationController alloc]initWithRootViewController:yhGoodsVCtr];
    [self presentViewController:naVCtr animated:YES completion:NULL];
}
-(void)GroupBuying
{
    GroupBuyingViewController *tuangou=[[GroupBuyingViewController alloc]initWithNibName:@"GroupBuyingViewController" bundle:nil];
    UINavigationController *naVCtr = [[UINavigationController alloc]initWithRootViewController:tuangou];
    [self presentViewController:naVCtr animated:YES completion:NULL];

}
-(void)Seckill
{
    AXHSeckillViewController *seckVCtr = [[AXHSeckillViewController alloc]init];
    UINavigationController *NAVCtr = [[UINavigationController alloc]initWithRootViewController:seckVCtr];
    [self presentViewController:NAVCtr animated:YES completion:NULL];

}
-(void)zhoubian
{
    [zhoubian setImage:[UIImage imageNamed:@"p001_zhoubian_checked.png"] forState:UIControlStateNormal];
    [xiaoqu setImage:[UIImage imageNamed:@"p005_xiaoqu_unchecked.png"] forState:UIControlStateNormal];
    [wode setImage:[UIImage imageNamed:@"p003_wo_unchecked.png"] forState:UIControlStateNormal];
    [scrollview_zhoubian removeFromSuperview];
    [myView addSubview:scrollview_zhoubian];
    [self addPreferentialMessageDate];
    
}
-(void)xiaoqu
{
    [zhoubian setImage:[UIImage imageNamed:@"p004_zhoubian_unchecked.png"] forState:UIControlStateNormal];
    [xiaoqu setImage:[UIImage imageNamed:@"p002_xiaoqu_checked.png"] forState:UIControlStateNormal];
    [wode setImage:[UIImage imageNamed:@"p003_wo_unchecked.png"] forState:UIControlStateNormal];
    [scrollview_xiaoqu removeFromSuperview];
    [myView addSubview:scrollview_xiaoqu];
    

}
-(void)wode
{
    [zhoubian setImage:[UIImage imageNamed:@"p004_zhoubian_unchecked.png"] forState:UIControlStateNormal];
    [xiaoqu setImage:[UIImage imageNamed:@"p005_xiaoqu_unchecked.png"] forState:UIControlStateNormal];
    [wode setImage:[UIImage imageNamed:@"p003_wo_checked.png"] forState:UIControlStateNormal];
    [view_wode removeFromSuperview];
    [myView addSubview:view_wode];
   
}

-(void)yijianfankui
{
   
}
-(void)wodeyinhangka
{
    
}
-(void)zhengfugonggao
{
    ZhengFuGongGaoViewController *gonggao=[[ZhengFuGongGaoViewController alloc]init];
    [self presentViewController:gonggao animated:NO completion:nil];
}
-(void)gongjijinchaxun
{
      
}
-(void)shebaochaxun
{
   
}
-(void)weizhangchaxun
{
    WeiZhangChaXunViewController *chaxun=[[WeiZhangChaXunViewController alloc]init];
    [self presentViewController:chaxun animated:NO completion:nil];
}
-(void)ditudaohang
{
    ZhouBianViewController *daohang=[[ZhouBianViewController alloc]init];
    [self presentViewController:daohang animated:NO completion:nil];
}
-(void)shipinyaopin
{
    ShiPinYaoPinViewController *yaopin=[[ShiPinYaoPinViewController alloc]init];
    [self presentViewController:yaopin animated:NO completion:nil];
}
-(void)changtukeyunchaxun
{
    ChangTuKeYunViewController *changtu=[[ChangTuKeYunViewController alloc]init];
    [self presentViewController:changtu animated:NO completion:nil];
}
-(void)fangchanyewu
{
    FangChanYeWuViewController *fangchan=[[FangChanYeWuViewController alloc]init];
    [self presentViewController:fangchan animated:NO completion:nil];
}
-(void)gongjiaoxianlu
{
    GongJiaoXianLuViewController *xianlu=[[GongJiaoXianLuViewController alloc]init];
    [self presentViewController:xianlu animated:NO completion:nil];
}
-(void)yinhangfuwu
{
    
}
-(void)fangchayewu
{
    
}
-(void)kanzhibo
{

}

-(void)juyouli
{
    
}
-(void)baoxinxian
{
    
}
-(void)rebotuijian
{
    
}
-(void)shiyunqi
{
    
}
-(void)shequsheding
{
    SheQuXuanZeViewController *viewctrl=[[SheQuXuanZeViewController  alloc]init];
    [self presentViewController:viewctrl animated:NO completion:nil];
}
-(void)shouye    //首页
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"Curl" context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.5];
    CGRect rect = [myView frame];
    rect.origin.x =0.0f;
    
    [myView setFrame:rect];
    [UIView commitAnimations];
    

}
-(void)RefreshAddressMessage
{
    BangDingXinXi*customer =[[BangDingXinXi alloc]init];
    customer.session =Session;
    
    NSString *str1_bangding = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
    NSString *str_jia=[JiaMiJieMi hexStringFromString:str1_bangding];
    NSString *str2=@"para=";
    NSString *Str_bangding;
    Str_bangding=[str2 stringByAppendingString:str_jia];
    [HttpPostExecutor postExecuteWithUrlStr:YongHuBangDingXinXi_m1_13 Paramters:Str_bangding FinishCallbackBlock:^(NSString *result)
     {
         // 执行post请求完成后的逻辑
         //NSLog(@"第二次:登录 %@", result);
         NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
         // NSLog(@"住址信息： %@", str_jiemi);
         
         SBJsonParser *parser = [[SBJsonParser alloc] init];
         NSError *error = nil;
         NSDictionary *rootDic = [parser objectWithString:str_jiemi error:&error];
         
         
         NSString *a=[rootDic objectForKey:@"ecode"];
         int intb = [a intValue];
         NSString *aaa;
         if (intb==1000)
         {
             arr_info=[rootDic objectForKey:@"address_info"];
             NSMutableArray *arr_addressidentify=[[NSMutableArray alloc]init];
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
                             // NSLog(@"是  1");
                             NSDictionary *Dic=[arr_info objectAtIndex:i];
                             xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                             aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                             [userDefaults setObject:aaa forKey:@"dizhixinxi"];
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
                     aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                     [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                     [userDefaults setObject:xiaoquming forKey:@"xiaoqu"];
                     [userDefaults setObject:xiaoquIDString forKey:@"xiaoquID"];
                     
                 }
                 
             }
             else
             {
                 aaa=@"还没有绑定住址信息";
                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                 [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                 
             }
             [arr_strlistOfSectionOne removeAllObjects];
             NSString *strrr1=aaa;
             NSString *strrr2=@"我的收货地址";
             
             NSString *strrr3=@"我的车辆信息";
             
             [arr_strlistOfSectionOne addObject:strrr1];
             [arr_strlistOfSectionOne addObject:strrr2];
             [arr_strlistOfSectionOne addObject:strrr3];


             [tableview reloadData];
         }
         if (intb==4000)
         {
             [self showWithCustomView:@"服务器内部错误"];
         }
     }];
    
}

-(void)tuichu
{
    [((AppDelegate*)[[UIApplication sharedApplication]delegate]) exitApplication];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	outString = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
}

-(void) connection:(NSURLConnection *)connection
  didFailWithError: (NSError *)error {
	UIAlertView *errorAlert = [[UIAlertView alloc]
							   initWithTitle: [error localizedDescription]
							   message: [error localizedFailureReason]
							   delegate:nil
							   cancelButtonTitle:@"OK"
							   otherButtonTitles:nil];
	[errorAlert show];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//指定有多少个分区(Section)，默认为1

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;//返回标题数组中元素的个数来确定分区的个数
    
}
//指定每个分区中有多少行，默认为1

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:
        {
            return  1;
            break;
        }
        case 1:
        {
            return  2;
            break;
        }
        case 2:
        {
            return  5;
            break;
        }
        case 3:
        {
            return  2;
            break;
        }

        case 4:
        {
            return  4;
            break;
        }

        default:
            
            return 0;
            
            break;
            
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 20)];
    view.backgroundColor=[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    UILabel *labela=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 200, 20)];
    labela.font=[UIFont systemFontOfSize:16];
    if (section==0)
    {
        labela.text=@"绑定信息";
    }
    if (section==1)
    {
        labela.text=@"笑脸币";
    }
    if (section==2)
    {
        labela.text=@"动态";
    }
    if (section==3)
    {
        labela.text=@"银行卡与账单";
    }

    if (section==4)
    {
        labela.text=@"更多";
    }

    [view addSubview:labela];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}

//绘制Cell

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
    cell.layer.borderWidth = 1;
    cell.layer.borderColor=[[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:0.4] CGColor];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    Section = indexPath.section;
    if (indexPath.section==0)
    {
        cell.textLabel.text=arr_strlistOfSectionOne[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:arr_imagelistOfSectionOne[indexPath.row]];
        cell.tag=indexPath.row;
        
    }
    if (indexPath.section==1)
    {
        cell.textLabel.text=arr_strlistOfSectionTwo[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:arr_imagelistOfSectionTwo[indexPath.row]];
        cell.tag=indexPath.row;

    }
    if (indexPath.section==2)
    {
        cell.textLabel.text=arr_strlistOfSectionThree[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:arr_imagelistOfSectionThree[indexPath.row]];
        cell.tag=indexPath.row;

    }
    if (indexPath.section==3)
    {
        cell.textLabel.text=arr_strlistOfSectionFour[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:arr_imagelistOfSectionFour[indexPath.row]];
        cell.tag=indexPath.row;
        
    }

    if (indexPath.section==4)
    {
        cell.textLabel.text=arr_strlistOfSectionFive[indexPath.row];
        cell.imageView.image=[UIImage imageNamed:arr_imagelistOfSectionFive[indexPath.row]];
        cell.tag=indexPath.row;
        
        
       
        
    }

    cell.textLabel.font=[UIFont systemFontOfSize:14];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        if (Section==0)
        {
            switch (cell.tag)
            {
                case 0:
                {
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {

                    AddressMessageViewController *zhuzhi=[[AddressMessageViewController alloc]init];
                    [self presentViewController:zhuzhi animated:YES completion:nil];
                    QieHuanViewController *qiehuan=[[QieHuanViewController alloc]init];
                    [qiehuan setDelegate_:self];
                   
                    }
                    else
                    {
                        [self Login];
                    }

                    break;
                    
                }
//                case 1:
//                {
//                   
//                    
//                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
//                    {
//                        
//                        [self showWithCustomView:@"收货地址  敬请期待"];                        
//                    }
//                    else
//                    {
//                        [self Login];
//                    }
//
//                    break;
//                    
//                }
//                case 2:
//                {
//                   
//                    
//                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
//                    {
//                        
//                        CheLiangXinXiYiLanViewController *cheliangxinxi=[[CheLiangXinXiYiLanViewController alloc]init];
//                        [self presentViewController:cheliangxinxi animated:NO completion:nil];
//                        
//                    }
//                    else
//                    {
//                        [self Login];
//                    }
//
//                    break;
//                    
//                }
                default:
                    break;
            }
        }
        if (Section==1)
            
        {
            switch (cell.tag)
            {
                case 0:
                {
                    
                    
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        
                       // [self showWithCustomView:@"我的笑脸币  敬请期待"];
                        MyFaceMoneyViewController *money=[[MyFaceMoneyViewController alloc]init];
                        [self presentViewController:money animated:NO completion:nil];
                    }
                    else
                    {
                        [self Login];
                    }

                    
                    break;
                    
                }
                case 1:
                {
                    
                
                    
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        AXHYHGoodsViewController  *goodsVCtr = [[AXHYHGoodsViewController alloc]initWithNibName:nil bundle:nil withType:GoodsTypeJF];
                        UINavigationController *naVCtr = [[UINavigationController alloc]initWithRootViewController:goodsVCtr];
                        [self presentViewController:naVCtr animated:YES completion:NULL];
                   
                    }
                    else
                    {
                        [self Login];
                    }

                    break;
                    
                }
                    
                default:
                    break;
            }
        }
        if (Section==2)
        {
            switch (cell.tag)
            {
                case 0:
                {
                    
                    
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        
                        ZHMyMessageViewController *message=[[ZHMyMessageViewController alloc]init];
                        [self presentViewController:message animated:NO completion:nil];
                        
                    }
                    else
                    {
                        [self Login];
                    }

                    break;
                    
                }
                case 1:
                {
                    
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        
                        MyReplyViewController *message=[[MyReplyViewController alloc]init];
                        [self presentViewController:message animated:NO completion:nil];
                        
                        
                    }
                    else
                    {
                        [self Login];
                    }


                    break;
                    
                }
                case 2:
                {
                    
                    
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        
                        MyCollectionViewController *shoucang=[[MyCollectionViewController alloc]init];
                        [self presentViewController:shoucang animated:NO completion:nil];
                        
                    }
                    else
                    {
                        [self Login];
                    }

                    break;
                    
                }
                case 3:
                {
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        
                        MyPostsViewController *message=[[MyPostsViewController alloc]init];
                        [self presentViewController:message animated:NO completion:nil];

                        
                    }
                    else
                    {
                        [self Login];
                    }

                    
                    break;
                
                    
                }
                case 4:
                {
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        
                        MyBrokeTheNewsViewController *message=[[MyBrokeTheNewsViewController alloc]init];
                        [self presentViewController:message animated:NO completion:nil];
                        
                        
                    }
                    else
                    {
                        [self Login];
                    }
                    
                    
                    break;
                }
                default:
                    break;
            }
        }
  
        if (Section==3)
        {
            switch (cell.tag)
            {
                case 0:
                {
                    
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        
                        MyBankCardViewController *BXXVCtr = [[MyBankCardViewController alloc]init];
                        UINavigationController *naVCtr = [[UINavigationController alloc]initWithRootViewController:BXXVCtr];
                        [self presentViewController:naVCtr animated:YES completion:NULL];

                        
                    }
                    else
                    {
                        [self Login];
                    }

                    
                    break;
                    
                }
                case 1:
                {
                    
                    
                    if (Session.length>0 && ![Session isEqualToString:@""] && ![Session isEqualToString:nil])
                    {
                        /*
                        WoDeZhangDanViewController *zhangdan=[[WoDeZhangDanViewController alloc]init];
                        [self presentViewController:zhangdan animated:NO completion:nil];
                         */
                        //我的账单
                        MyBillViewController *MyBillVC = [[MyBillViewController alloc]init];
                        [self presentViewController:MyBillVC animated:NO completion:nil];
                        
                        
                        
                    }
                    else
                    {
                        [self Login];
                    }


                    break;
                    
                }
                    
                default:
                    break;
            }
        }
        if (Section==4)
        {
            switch (cell.tag)
            {
                case 0:
                {
                    
                    XiTongSheZhiViewController *shezhi=[[XiTongSheZhiViewController alloc]init];
                    [self presentViewController:shezhi animated:NO completion:nil];
                    break;
                    
                }
                case 1:
                {
                    
                    OpinionsFeedbackViewController *yijian=[[OpinionsFeedbackViewController alloc]init];
                    [self presentViewController:yijian animated:NO completion:nil];

                    break;
                    
                }
                case 2:
                {
                    
                    SheQuFuWu_Title=@"关于我们";
                    Payment_url=@"http://www.xiaolianshequ.cn/download/about.html";
                    Pay_ViewController *subViewVCtr = [[Pay_ViewController alloc]init];
                    [self presentViewController:subViewVCtr animated:NO completion:nil];
                    break;
                    
                }
                case 3:
                {
                    
                    QRViewController *QRVC = [[QRViewController alloc]initWithNibName:@"QRViewController" bundle:nil];
                    [self presentViewController:QRVC animated:YES completion:nil];
                    break;
                    
                }

                    
                default:
                    break;
            }
            
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
 修改人 赵忠良
 修改时间 15.3.11
 修改内容 修复我的中笑脸币显示不正确的bug
 */
-(void)keyong
{
    NSString *str1=[NSString stringWithFormat:@"{\"session\":\"%@\"}",Session];
    
    
    NSString *str_jiami=[SurveyRunTimeData hexStringFromString:str1];
    sqHttpSer = [[PersonCenterHttpService alloc]init];
    sqHttpSer.strUrl = WoDeXiaoLianBi_m19_03;
    sqHttpSer.delegate = self;
    sqHttpSer.requestDict = [NSDictionary dictionaryWithObjectsAndKeys:str_jiami,@"para", nil];
    [sqHttpSer beginQuery];
    
}
#pragma mark DataDelegate
-(void)didReceieveSuccess:(NSInteger)tag{
    switch (tag) {
        case 15:{
            NSLog(@"ccccc  %@",sqHttpSer.responDict);
            
            int inta = [[sqHttpSer.responDict objectForKey:@"ecode"] intValue];
            
            if (inta==3007)
            {
                [SVProgressHUD showErrorWithStatus:@"没有查找到数据" duration:1];
                tableview.hidden=YES;
                return;
            }
            if (inta==1000)
            {
                label_Member.text=[NSString stringWithFormat:@"铜牌会员 | 笑脸币：%@",[sqHttpSer.responDict  objectForKey:@"credit_usable"]];
                [label_Member sizeToFit];
            }
            
            
        }
            
            break;
            
        default:
            break;
    }
    
}

//连接失败处理
-(void)didReceieveFail:(NSInteger)tag{
    
}

/*
 注销确认提示
 */
- (void)certainToLogout{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"是否进行以下操作"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"注销"
                                  otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    //    [actionSheet showInView:self.view];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow ];
}

//Actionsheet实现点击方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            [self Logout];
        }
            break;
        default:
            break;
    }
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


@end
