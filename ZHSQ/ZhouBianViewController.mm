//
//  ZhouBianViewController.m
//  ZHSQ
//
//  Created by lacom on 14-4-24.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ZhouBianViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "LuXianDaoHangViewController.h"
@interface ZhouBianViewController ()

@end

@implementation ZhouBianViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置 nil,否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated {
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时,置 nil
}
-(void)luxiandaohang
{
    LuXianDaoHangViewController *chaxun=[[LuXianDaoHangViewController alloc]init];
    [self presentViewController:chaxun animated:NO completion:nil];
}
- (void)viewDidLoad
{
    
    @try
    {

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度

    mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, Width,Hidth-120)];
    
    mapView.mapType = BMKMapTypeStandard;//设置地图显示类型为普通图
    mapView.showMapScaleBar = true; // 显示比例尺控件
    mapView.mapScaleBarPosition = CGPointMake(10,5);//纵横坐标
    mapView.scrollEnabled = true; // 地图随手指移动
    mapView.zoomEnabled = true; // 多点缩放手势生效
    mapView.delegate = self;
    search = [[BMKSearch alloc] init];
    search.delegate = self;
    [self.view addSubview:mapView];
    label_xuanxiangbeijing=[[UILabel alloc]initWithFrame:CGRectMake(0, Hidth-60, 320, 60)];
    label_xuanxiangbeijing.backgroundColor=[UIColor colorWithRed:232/255.0 green:169/255.0 blue:1/255.0 alpha:1];
    [self.view addSubview:label_xuanxiangbeijing];
    
    FuWwBtn=[[UIButton alloc]initWithFrame:CGRectMake(12, Hidth-60, 40, 40)];
    [FuWwBtn setImage:[UIImage imageNamed:@"zhoubian_fuwu.png"] forState:UIControlStateNormal];
    FuWwBtn.backgroundColor=[UIColor colorWithRed:232/255.0 green:169/255.0 blue:1/255.0 alpha:1];
    [FuWwBtn addTarget:self action:@selector(SouSuoFuWw) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FuWwBtn];
    
    GouWwBtn=[[UIButton alloc]initWithFrame:CGRectMake(76, Hidth-60, 40, 40)];
    [GouWwBtn setImage:[UIImage imageNamed:@"zhoubian_gouwu.png"] forState:UIControlStateNormal];
    GouWwBtn.backgroundColor=[UIColor colorWithRed:232/255.0 green:169/255.0 blue:1/255.0 alpha:1];
    [GouWwBtn addTarget:self action:@selector(SouSuoGouWu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GouWwBtn];
    
    YuLeBtn=[[UIButton alloc]initWithFrame:CGRectMake(140, Hidth-60, 40, 40)];
    [YuLeBtn setImage:[UIImage imageNamed:@"zhoubian_yule.png"] forState:UIControlStateNormal];
    YuLeBtn.backgroundColor=[UIColor colorWithRed:232/255.0 green:169/255.0 blue:1/255.0 alpha:1];
    [YuLeBtn addTarget:self action:@selector(SouSuoYuLe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:YuLeBtn];
    
    MeiShiBtn=[[UIButton alloc]initWithFrame:CGRectMake(204, Hidth-60, 40, 40)];
    [MeiShiBtn setImage:[UIImage imageNamed:@"zhoubian_meishi.png"] forState:UIControlStateNormal];
    MeiShiBtn.backgroundColor=[UIColor colorWithRed:232/255.0 green:169/255.0 blue:1/255.0 alpha:1];
    [MeiShiBtn addTarget:self action:@selector(SouSuoMeiShi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:MeiShiBtn];
    LuXian=[[UIButton alloc]initWithFrame:CGRectMake(268, Hidth-60, 40, 40)];
    [LuXian setImage:[UIImage imageNamed:@"zhoubian_luxian.png"] forState:UIControlStateNormal];
    LuXian.backgroundColor=[UIColor colorWithRed:232/255.0 green:169/255.0 blue:1/255.0 alpha:1];
    [LuXian addTarget:self action:@selector(luxiandaohang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LuXian];
    label_shuoming=[[UILabel alloc]initWithFrame:CGRectMake(0, Hidth-20, 320, 20)];
    label_shuoming.font=[UIFont systemFontOfSize:14];
    label_shuoming.text=@"服务         购物         娱乐         美食         路线  ";
    label_shuoming.textAlignment=NSTextAlignmentCenter;
    label_shuoming.textColor=[UIColor whiteColor];
    [self.view addSubview:label_shuoming];
    sousuoview=[[UIView alloc]initWithFrame:CGRectMake(60, 0.5*Hidth, 200, 135)];
    //设置view圆角
    sousuoview.layer.masksToBounds = YES;
    sousuoview.layer.cornerRadius = 7.0;
    sousuoview.layer.borderWidth = 1.0;
    sousuoview.backgroundColor=[UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:1];
    linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 32, 200, 1)];
    linelabel.backgroundColor=[UIColor grayColor];
    [sousuoview addSubview:linelabel];
    imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 1, 100, 30)];
    imageview.image=[UIImage imageNamed:@"sousuobiaoti.png"];
    [sousuoview addSubview:imageview];
    labelbiaoti=[[UILabel alloc]initWithFrame:CGRectMake(10, 32, 150, 30)];
    labelbiaoti.text=@"输入搜索内容:";
    labelbiaoti.font=[UIFont systemFontOfSize:13];
    labelbiaoti.textColor=[UIColor whiteColor];
    [sousuoview addSubview:labelbiaoti];
    
    textfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 62, 180, 30)];
    textfield.layer.borderColor = [[UIColor greenColor] CGColor];
    textfield.borderStyle=UITextBorderStyleRoundedRect;
    textfield.returnKeyType=UIReturnKeyDone;
    textfield.delegate=self;
    textfield.layer.borderWidth = 1.0;
    [sousuoview addSubview:textfield];
    SouSuoBtn=[[UIButton alloc]initWithFrame:CGRectMake(5,100, 90, 30)];
    SouSuoBtn.layer.masksToBounds = YES;
    SouSuoBtn.layer.cornerRadius = 3;
    SouSuoBtn.backgroundColor=[UIColor whiteColor];
    [SouSuoBtn setTitle:@"搜索" forState:UIControlStateNormal];
    SouSuoBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [SouSuoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [SouSuoBtn addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    [sousuoview addSubview:SouSuoBtn];

    QuXiaoBtn=[[UIButton alloc]initWithFrame:CGRectMake(105,100, 90, 30)];
    QuXiaoBtn.layer.masksToBounds = YES;
    QuXiaoBtn.layer.cornerRadius = 3;
    QuXiaoBtn.backgroundColor=[UIColor whiteColor];
    [QuXiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
    QuXiaoBtn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [QuXiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [QuXiaoBtn addTarget:self action:@selector(quxiao) forControlEvents:UIControlEventTouchUpInside];
    [sousuoview addSubview:QuXiaoBtn];
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
-(void)sousuo
{
    NSString *textstr;
    textstr=textfield.text;
    curPage = 0;
    // 城市检索,请求发送成功返回 YES,请求发送失败返回 NO
    
    BOOL flag=[search poiSearchInCity:@"北京" withKey:textstr pageIndex:curPage];
    if (flag)
    {
        NSLog(@"search success.");
        [sousuoview removeFromSuperview];
    }
    else
    {
        
        NSLog(@"search failed!");
    }
   
}
-(void)quxiao
{
    [sousuoview removeFromSuperview];

}
-(void)SouSuoFuWw
{
    curPage = 0;
    // 城市检索,请求发送成功返回 YES,请求发送失败返回 NO
    BOOL flag=[search poiSearchInCity:@"北京" withKey:@"服务" pageIndex:curPage];
    if (flag)
    {
        NSLog(@"search success.");
    }
    else
    {
        
        NSLog(@"search failed!");
    }
}
-(void)SouSuoGouWu
{
    curPage = 0;
    // 城市检索,请求发送成功返回 YES,请求发送失败返回 NO
    
    BOOL flag=[search poiSearchInCity:@"北京" withKey:@"购物" pageIndex:curPage];
    if (flag) {
        
        NSLog(@"search success.");
    }
    else{
        NSLog(@"search failed!");
    }
    
}
-(void)SouSuoYuLe
{
    curPage = 0;
    // 城市检索,请求发送成功返回 YES,请求发送失败返回 NO
    
    BOOL flag=[search poiSearchInCity:@"北京" withKey:@"娱乐" pageIndex:curPage];
    if (flag) {
        NSLog(@"search success.");
    }
    else{
        NSLog(@"search failed!");
    }
}
-(void)SouSuoMeiShi
{
    curPage = 0;
    BOOL flag=[search poiSearchInCity:@"北京" withKey:@"餐厅" pageIndex:curPage];
    if (flag) {
        NSLog(@"search success.");
    }
    else{
        NSLog(@"search failed!");
    }
    

}
-(void)dingweia
{
    NSArray* array = [NSArray arrayWithArray:mapView.annotations];
	[mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:mapView.overlays];
	[mapView removeOverlays:array];
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    jingdu=@"116.403981";
    weidu=@"39.915101";
    pt = (CLLocationCoordinate2D){[weidu floatValue], [jingdu floatValue]};
	
	BOOL flag = [search reverseGeocode:pt];
    NSLog(@"%hhd",[search reverseGeocode:pt]);
	if (!flag) {
		NSLog(@"search failed!");
        NSLog(@"2");
	}
    NSLog(@"3");
}
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error
{
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.geoPt;
		item.title = result.strAddr;
		[mapView addAnnotation:item];
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
	
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil)
    {
        annotationView =[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
		// 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
	
    // 设置位置
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
	annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    //NSLog(@"didAddAnnotationViews");
}

#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKSearch *)searcher result:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    @try
    {

    // 清楚屏幕中所有的annotation
    
    NSArray *array =[NSArray arrayWithArray:mapView.annotations];
	[mapView removeAnnotations:array];
    
    if (error == BMKErrorOk) {
		BMKPoiResult* result = [poiResultList objectAtIndex:0];
		for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [mapView addAnnotation:item];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                mapView.centerCoordinate = poi.pt;
            }
        }
	} else if (error == BMKErrorRouteAddr){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
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

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = sousuoview.frame;
    int offset = frame.origin.y +150 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [textfield resignFirstResponder];
    return YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fanhui:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)sousuo:(id)sender {
    [self.view addSubview:sousuoview];
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
