//
//  AppDelegate.m
//  ZHSQ
//
//  Created by lacom on 14-4-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AppDelegate.h"
#import "shouyeViewController.h"
#import "wViewController.h"
#import "URL.h"
#import "APService.h"
#import "MobClick.h"
#import "MyMD5.h"
#import "MBProgressHUD.h"

#import "SBJson.h"
#import "SerializationComplexEntities.h"
#import "Location.h"
#import "WorkItem.h"
#import "HttpPostWrapper.h"
#import "HttpPostExecutor.h"
#import "JiaMiJieMi.h"
#import "denglu.h"

#import "ShareHead.h"

extern NSString *string_Account;
extern NSString *string_Password;
extern NSString *area_id;
extern NSString *xiaoquIDString;
extern NSString *xiaoquming;
extern NSDictionary *PersonInformationDictionary;
extern NSString *community_id;
extern NSString *mobel_iphone;
extern NSString *Address_id;
extern NSString *charge_mode;
//#import "MobClick.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    //设置navigation图片
    //*****************************
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], UITextAttributeTextColor,
                                                          [UIColor colorWithRed:0 green:0.7 blue:0.8 alpha:1], UITextAttributeTextShadowColor,
                                                          [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                          [UIFont fontWithName:@"Arial-Bold" size:0.0], UITextAttributeFont,
                                                          nil]];
    //******************************
    //[MobClick startWithAppkey:@"5428cc54fd98c5c94801a23c" reportPolicy:BATCH   channelId:@"Web"];

    //分享注册
    [ShareSDK registerApp:@"286fab34b658"];
    [self initializePlat];
    
    
    
    // 要使用百度地图，先启动BaiduMapManager
    mapManager= [[BMKMapManager alloc]init];
     //如果要关注网络及授权验证事件，请设定generalDelegate参数
     // BOOL ret = [mapManager start:@"HLHfOVVlpnzbEcfutSM4dHzU" generalDelegate:self];
    BOOL ret = [mapManager start:@"rv47zkwQo0PE0HvMokyB20aG" generalDelegate:self];
    if (!ret)
    {
        NSLog(@"manager start failed!");
    }
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:234/255.0 green:87/255.0 blue:83/255.0 alpha:1]];
    UIColor *navigationTitleColor = [UIColor whiteColor];
    UIFont *navigationTitleFont = [UIFont boldSystemFontOfSize:18];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:navigationTitleColor, NSFontAttributeName:navigationTitleFont}];
    if ([SurveyRunTimeData sharedInstance].session == nil) {
        
        [SurveyRunTimeData sharedInstance].session = @"";
    }
    

    IsFiirst=1;
    NSUserDefaults *userDefaulte= [NSUserDefaults standardUserDefaults];
    NSString *myString_zhanghao = [userDefaulte stringForKey:@"denglu_zhanghao"];
    string_Account=myString_zhanghao;
    NSString *myString_mima = [userDefaulte stringForKey:@"denglu_mima"];
    string_Password=myString_mima;
    if ((myString_zhanghao.length!=0)&&(myString_mima.length!=0))
    {
        
        
        denglu*customer =[[denglu alloc]init];
        
        mima=[MyMD5 md5:myString_mima];
        customer.password =mima;
        
        customer.username=myString_zhanghao;
        
        [SurveyRunTimeData sharedInstance].username = myString_zhanghao;
        [SurveyRunTimeData sharedInstance].password = mima;
        
        NSString *str1 = [[SerializationComplexEntities sharedSerializer] serializeObjectWithChildObjectsAndComplexArray:customer childSimpleClasses:[[NSArray alloc] initWithObjects:[WorkItem class],nil] childSimpleClassInArray:[[NSArray alloc] initWithObjects:[WorkItem class],nil]];
        NSString *str_jiami=[JiaMiJieMi hexStringFromString:str1];
        NSString *str2=@"para=";
        NSString *Str;
        Str=[str2 stringByAppendingString:str_jiami];
      
        
        
        [HttpPostExecutor postExecuteWithUrlStr:YongHuBangDingXinXi_m1_17 Paramters:Str FinishCallbackBlock:^(NSString *result)
         {
             // 执行post请求完成后的逻辑
             //NSLog(@"第二次:登录 %@", result);
             if (result.length<=0)
             {
                 [SVProgressHUD showErrorWithStatus:@"网络信号不佳，请选择好的网络" duration:1.5];
                 [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(exitApplication) userInfo:nil repeats:NO];
//                 UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络信号不佳，请选择好的网络" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//                 [aler show];
             }
             else
             {
                 
                 NSString *str_jiemi=[JiaMiJieMi stringFromHexString:result];
                 NSLog(@"返回信息 :%@",str_jiemi);
                 SBJsonParser *parser = [[SBJsonParser alloc] init];
                 NSError *error = nil;
                 PersonInformationDictionary= [parser objectWithString:str_jiemi error:&error];
                 Session=[PersonInformationDictionary objectForKey:@"session"];
                 NSString *str_tishi=[PersonInformationDictionary objectForKey:@"ecode"];
                 int intb = [str_tishi intValue];
                 if (intb==1000)
                 {
                     NSString *nickname=[[[PersonInformationDictionary objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"nickname"];
                     UserName=nickname;
               
                    [SurveyRunTimeData sharedInstance].session = [PersonInformationDictionary objectForKey:@"session"];
                     [SurveyRunTimeData sharedInstance].mobilePhone = PersonInformationDictionary[@"person_info"][0][@"mobile_phone"];
                     [SurveyRunTimeData sharedInstance].user_id = PersonInformationDictionary[@"person_info"][0][@"id"];
                     
                     Address_id=[[[PersonInformationDictionary objectForKey:@"address_info"] objectAtIndex:0] objectForKey:@"address_id"];
                     charge_mode=[[[PersonInformationDictionary objectForKey:@"address_info"] objectAtIndex:0] objectForKey:@"charge_mode"];
                     Session=[PersonInformationDictionary objectForKey:@"session"];
                     email=[[[PersonInformationDictionary objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"email"];
                     Name=[[[PersonInformationDictionary objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"name"];
                     mobel_iphone=[[[PersonInformationDictionary objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"mobile_phone"];
                     Card_id=[[[PersonInformationDictionary objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"idnumber"];
                     NSLog(@"%@",Card_id);
                     icon_path=[[[PersonInformationDictionary objectForKey:@"person_info"] objectAtIndex:0] objectForKey:@"icon_path"];
                     arr_info=[PersonInformationDictionary objectForKey:@"address_info"];
                     NSMutableArray *arr_addressidentify=[[NSMutableArray alloc]init];
                     for (int i=0; i<[arr_info count]; i++)
                     {
                         NSString *string=[[arr_info objectAtIndex:i] objectForKey:@"isdefaultshow"];
                         [arr_addressidentify addObject:string];
                     }
                     NSLog(@"    >>>>>  %d",arr_info.count);
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
                                     
                                  
                                   
                                     [SurveyRunTimeData sharedInstance].city_id = Dic[@"city_id"];
                                     [SurveyRunTimeData sharedInstance].community_id = Dic[@"community_id"];
                                     [SurveyRunTimeData sharedInstance].quarter_id = Dic[@"quarter_id"];
                                     [SurveyRunTimeData sharedInstance].area_id =Dic[@"area_id"];
                                     
                                     xiaoquIDString=[Dic objectForKey:@"quarter_id"];
                                     xiaoquming=[Dic objectForKey:@"quarter_name"];
                                     community_id=[Dic objectForKey:@"community_id"];
                                     area_id=[Dic objectForKey:@"area_id"];
                                     NSString *aaa=[NSString stringWithFormat:@"%@%@%@%@",[Dic objectForKey:@"quarter_name"],[Dic objectForKey:@"building_name"],[Dic objectForKey:@"unit_name"],[Dic objectForKey:@"room_name"]];
                                     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                     [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                                      */
                                     /*3.15 zhaoz
                                      
                                      */
                                     // NSLog(@"是  1");
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
                         // 自动登录成功，已绑定小区，进入主页面

                         self.vController = [[DengLuHouZhuYeViewController alloc] initWithNibName:@"DengLuHouZhuYeViewController" bundle:nil];
                         self.window.rootViewController = self.vController;

                     }
                     else
                     {
                         NSString *aaa=@"还没有绑定住址信息";
                         NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                         [userDefaults setObject:aaa forKey:@"dizhixinxi"];
                         // 自动登录成功，却没有绑定小区，进入小区绑定页面，绑定小区
                         self.AddressviewController = [[AddressMessageViewController alloc] initWithNibName:@"AddressMessageViewController" bundle:nil];
                         self.window.rootViewController = self.AddressviewController;


                     }

                     
                 }
                else if (intb==3101)
                 {
                     [self showWithCustomView:@"用户不存在"];
                     
                     self.LoginController = [[shouyeViewController alloc] initWithNibName:@"shouyeViewController" bundle:nil];
                     self.window.rootViewController = self.LoginController;

                 }
                 
                else if (intb==3102)
                 {
                     [self showWithCustomView:@"密码错误"];
                     self.LoginController = [[shouyeViewController alloc] initWithNibName:@"shouyeViewController" bundle:nil];
                     self.window.rootViewController = self.LoginController;

                 }

                 else
                 {
                     [self showWithCustomView:@"自动登录失败"];
                     self.LoginController = [[shouyeViewController alloc] initWithNibName:@"shouyeViewController" bundle:nil];
                     self.window.rootViewController = self.LoginController;
                
                 }

             }
         }];
    }
    else
    {
        self.LoginController = [[shouyeViewController alloc] initWithNibName:@"shouyeViewController" bundle:nil];
        self.window.rootViewController = self.LoginController;
    }
    [self.window makeKeyAndVisible];
    
        
    
    
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfURL:[NSURL URLWithString:JianChaBanBen]];
    
    if (dict) {
        NSArray* list = [dict objectForKey:@"items"];
        NSDictionary* dict2 = [list objectAtIndex:0];
        
        NSDictionary* dict3 = [dict2 objectForKey:@"metadata"];
        NSString* newVersion = [dict3 objectForKey:@"bundle-version"];
        
        NSString *myVersion = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
           NSLog(@"版本号%@=====%@",newVersion,myVersion);
        
        //判断built版本号
        if ([newVersion floatValue] > [myVersion floatValue])
        {
            
            UIAlertView * aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发现新版本，是否更新？" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"暂不更新", nil];
            [aler show];
            
        }
              
        
    }
    else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请检查网络" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)];
    }
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
//
    
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    
    
    

#endif
    // Required
    [APService setupWithOption:launchOptions];
    
    //youmeng
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [MobClick startWithAppkey:@"5482f0d3fd98c5abad000408" reportPolicy:BATCH   channelId:@"lacom"];

    return YES;
}
- (void)networkDidSetup:(NSNotification *)notification
{
    
}

- (void)networkDidClose:(NSNotification *)notification
{
  
}

- (void)networkDidRegister:(NSNotification *)notification
{
}

- (void)networkDidLogin:(NSNotification *)notification
{
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}


- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    UIAlertView * aler = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [aler show];
    //[_infoLabel setText:[NSString stringWithFormat:@"收到消息\ndate:%@\ntitle:%@\ncontent:%@", [dateFormatter stringFromDate:[NSDate date]],title,content]];
    NSLog(@"收到消息 \n date:%@ \n title:%@  \n content:%@",[dateFormatter stringFromDate:[NSDate date]],title,content);
}
- (void)showWithCustomView:(NSString*)aString
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aString;
    hud.margin = 10.f;
    hud.yOffset = 170.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex ==0) {
        NSLog(@"更新");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AaiXianGengXin]];
        
    }
    else if(buttonIndex ==1){
        NSLog(@"不更新");
    }}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"联网成功");
    }
    else
    {
        NSLog(@"onGetNetworkState %d",iError);
    }
}
- (void)onGetPermissionState:(int)iError
{
    if (0 == iError)
    {
        NSLog(@"授权成功");
    }
    else
    {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
-(void)SetTag:(NSArray *) tag  withAlias:(NSString *)alias
{
    [APService setTags:[NSSet setWithArray:tag] alias:alias callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];

}

-(void)initializePlat{
    
    
    //添加新浪微博应用 注册网址 http://open.weibo.com
    [ShareSDK connectSinaWeiboWithAppKey:@"3201194191"
                               appSecret:@"0334252914651e8f76bad63337b3b78f"
                             redirectUri:@"http://appgo.cn"];
    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                              redirectUri:@"http://www.sharesdk.cn"
                              weiboSDKCls:[WeiboSDK class]];
    //添加QQ空间应用  注册网址  http://connect.qq.com/intro/login/
    [ShareSDK connectQZoneWithAppKey:@"100424468"
                           appSecret:@"c7394704798a158208a74ab60104f0ba"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    //添加QQ应用  注册网址  http://open.qq.com/
    [ShareSDK connectQQWithQZoneAppKey:@"QQ05fc5b14"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    //添加微信应用 注册网址 http://open.weixin.qq.com
    [ShareSDK connectWeChatWithAppId:@"wxd9a39c7122aa6516"
                           wechatCls:[WXApi class]];
    
}

//-------------------------------- 退出程序 -----------------------------------------//
- (void)exitApplication {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
    
}

@end
