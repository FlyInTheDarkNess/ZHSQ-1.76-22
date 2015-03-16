//
//  ShangJiaDiTuDingWeiViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-8-4.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "ShangJiaDiTuDingWeiViewController.h"
#import "BMKSearch.h"
extern NSDictionary *FUWUdtDictionary;
@interface ShangJiaDiTuDingWeiViewController ()

@end

@implementation ShangJiaDiTuDingWeiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置 nil,否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时,置 nil
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @try
    {

    self.view.backgroundColor=[UIColor whiteColor];
    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat Width=size.width;//Width 屏幕宽度
    CGFloat Hidth=size.height;//Hidth 屏幕高度
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, Width,Hidth-60)];
    [self.view addSubview:_mapView];
    _search = [[BMKSearch alloc]init];
    _search.delegate = self;
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, Width, 40)];
    la.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0  blue:87/255.0  alpha:1];
    la.text=@"位置";
    [la setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    la.textAlignment=NSTextAlignmentCenter;
    la.textColor=[UIColor whiteColor];
    [self.view addSubview:la];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 35, 35)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    [self dingwei];
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
-(void)dingwei
{
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    
    jingdu=[FUWUdtDictionary objectForKey:@"position_longitude"];
    weidu=[FUWUdtDictionary objectForKey:@"position_latitude"];
    NSLog(@"经纬度：  %@     %@",jingdu,weidu);
//    jingdu=@"117.675608";
//    weidu=@"36.208643";
   pt = (CLLocationCoordinate2D){[weidu floatValue], [jingdu floatValue]};
	
	BOOL flag = [_search reverseGeocode:pt];
    
	if (!flag)
    {
		NSLog(@"search failed!");
    }
    [_mapView setCenterCoordinate:pt animated:YES];
}
- (void)onGetAddrResult:(BMKSearch*)searcher result:(BMKAddrInfo*)result errorCode:(int)error;
{
	if (error == 0) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.geoPt;
		item.title = result.strAddr;
		[_mapView addAnnotation:item];
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
- (void)onGetPoiResult:(BMKSearch *)searcher result:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    @try
    {
 
    // 清楚屏幕中所有的annotation
    
    NSArray *array =[NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    
    if (error == BMKErrorOk) {
		BMKPoiResult* result = [poiResultList objectAtIndex:0];
		for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [_mapView addAnnotation:item];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = poi.pt;
            }
        }
	} else if (error == BMKErrorRouteAddr)
    {
        NSLog(@"起始点有歧义");
    } else
    {
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
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
