//
//  LuXianDaoHangViewController.m
//  ZHSQ
//
//  Created by yanglaobao on 14-8-6.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "LuXianDaoHangViewController.h"
#import <QuartzCore/QuartzCore.h>

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]



@interface RouteAnnotation : BMKPointAnnotation
{
	int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘
	int _degree;
    
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end


@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    BOOL isRetina = FALSE;//本行代码移动了位置
    
    
	CGSize rotatedSize = self.size;
	if (isRetina) {
		rotatedSize.width *= 2;
		rotatedSize.height *= 2;
	}
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end
@interface LuXianDaoHangViewController ()

@end

@implementation LuXianDaoHangViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		NSLog ( @"%@" ,s);
		return s;
	}
	return nil ;
}

- (void)viewDidLoad
{
    @try
    {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
   

    CGRect rect=[[UIScreen mainScreen]bounds];
    CGSize size=rect.size;
    CGFloat w=size.width;
    CGFloat h=size.height;
    self.view.backgroundColor=[UIColor whiteColor];
        UILabel *label_beijingse=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, w, 60)];
        label_beijingse.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
        [self.view addSubview:label_beijingse];

    label_title=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, w, 40)];
    label_title.textColor=[UIColor whiteColor];
    label_title.text=@"线路导航";
    [label_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    label_title.textAlignment=NSTextAlignmentCenter;
    label_title.backgroundColor=[UIColor colorWithRed:234/255.0 green:83/255.0 blue:87/255.0 alpha:1];
    [self.view addSubview:label_title];
    fanhui=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
    [fanhui setImage:[UIImage imageNamed:@"back_left.png"] forState:UIControlStateNormal];
    [fanhui addTarget:self action:@selector(fanhui) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fanhui];
    caidan=[[UIButton alloc]initWithFrame:CGRectMake(280, 25, 30, 30)];
    [caidan setImage:[UIImage imageNamed:@"daohang0528.png"] forState:UIControlStateNormal];
    [caidan addTarget:self action:@selector(sousuokuang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:caidan];
    _mapView=[[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, w,h-60)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _search = [[BMKSearch alloc] init];
    _search.delegate = self;
    
    myview=[[UIView alloc]initWithFrame:CGRectMake(5, 60, 310, 130)];
    myview.backgroundColor=[UIColor whiteColor];
    myview.layer.masksToBounds = YES;
    myview.layer.cornerRadius = 6.0;
    myview.layer.borderWidth = 1.0;
    myview.layer.borderColor = [[UIColor whiteColor] CGColor];
    [self.view addSubview:myview];
    qidian=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 30, 30)];
    qidian.text=@"起点:";
    qidian.textAlignment=NSTextAlignmentCenter;
    qidian.font=[UIFont systemFontOfSize:12];
    [myview addSubview:qidian];
    zhongdian=[[UILabel alloc]initWithFrame:CGRectMake(5, 50, 30, 30)];
    zhongdian.text=@"终点:";
    zhongdian.textAlignment=NSTextAlignmentCenter;
    zhongdian.font=[UIFont systemFontOfSize:12];
    [myview addSubview:zhongdian];
    
    _startCityText=[[UITextField alloc]init];
    _startCityText.borderStyle=UITextBorderStyleRoundedRect;
    _startCityText.placeholder=@"城市";
    _startCityText.layer.borderWidth = 1;
    _startCityText.layer.borderColor=[[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1] CGColor];
    _startCityText.layer.masksToBounds=YES;
    _startCityText.layer.cornerRadius=2;
    _startCityText.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    _startCityText.frame=CGRectMake(40, 10, 70, 30);
    _startCityText.delegate=self;
    [myview addSubview:_startCityText];
    _startAddrText=[[UITextField alloc]init];
    _startAddrText.borderStyle=UITextBorderStyleRoundedRect;
    _startAddrText.placeholder=@"起点";
    _startAddrText.layer.borderWidth = 1;
    _startAddrText.layer.borderColor=[[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1] CGColor];
    _startAddrText.layer.masksToBounds=YES;
    _startAddrText.layer.cornerRadius=2;
    _startAddrText.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    _startAddrText.frame=CGRectMake(115, 10, 145, 30);
    _startAddrText.delegate=self;
    [myview addSubview:_startAddrText];
    wodeweizhi=[[UIButton alloc]initWithFrame:CGRectMake(270, 10, 30, 30)];
    [wodeweizhi setTitle:@"定位" forState:UIControlStateNormal];
    [wodeweizhi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    wodeweizhi.titleLabel.font=[UIFont systemFontOfSize:14];
    wodeweizhi.layer.masksToBounds = YES;
    wodeweizhi.layer.cornerRadius = 5;
    wodeweizhi.layer.borderWidth = 1;
    wodeweizhi.layer.borderColor=[[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] CGColor];

    [wodeweizhi addTarget:self action:@selector(ziwodingwei) forControlEvents:UIControlEventTouchUpInside];
    [myview addSubview:wodeweizhi];
    
    _endCityText=[[UITextField alloc]init];
    _endCityText.borderStyle=UITextBorderStyleRoundedRect;
    _endCityText.placeholder=@"城市";
    _endCityText.layer.borderWidth = 1;
    _endCityText.layer.borderColor=[[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1] CGColor];
    _endCityText.layer.masksToBounds=YES;
    _endCityText.layer.cornerRadius=2;
    _endCityText.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    _endCityText.frame=CGRectMake(40, 50, 70, 30);
    _endCityText.delegate=self;
    [myview addSubview:_endCityText];
    
    _endAddrText=[[UITextField alloc]init];
    _endAddrText.returnKeyType=UIReturnKeyDone;//设置键盘完成按钮
    _endAddrText.frame=CGRectMake(115, 50, 185, 30);
    _endAddrText.borderStyle=UITextBorderStyleRoundedRect;
    _endAddrText.placeholder=@"终点";
    _endAddrText.layer.borderWidth = 0.5;
    _endAddrText.layer.borderColor=[[UIColor colorWithRed:100/255.0 green:149/255.0 blue:237/255.0 alpha:1] CGColor];
    _endAddrText.layer.masksToBounds=YES;
    _endAddrText.layer.cornerRadius=2;

    _endAddrText.delegate=self;
    [myview addSubview:_endAddrText];


    jiache=[[UIButton alloc]initWithFrame:CGRectMake(10, 90, 90, 30)];
    [jiache setTitle:@"驾车搜索" forState:UIControlStateNormal];
    [jiache setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jiache.titleLabel.font=[UIFont systemFontOfSize:14];
    jiache.titleLabel.textAlignment=NSTextAlignmentCenter;
    jiache.layer.masksToBounds = YES;
    jiache.layer.cornerRadius = 5;
    jiache.layer.borderWidth = 1;
    jiache.layer.borderColor=[[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] CGColor];
    [jiache addTarget:self action:@selector(jiachesousuo) forControlEvents:UIControlEventTouchUpInside];
    [myview addSubview:jiache];

    gongjiao=[[UIButton alloc]initWithFrame:CGRectMake(110, 90, 90, 30)];
    [gongjiao setTitle:@"公交搜索" forState:UIControlStateNormal];
    [gongjiao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    gongjiao.titleLabel.font=[UIFont systemFontOfSize:14];
    gongjiao.titleLabel.textAlignment=NSTextAlignmentCenter;
    gongjiao.layer.masksToBounds = YES;
    gongjiao.layer.cornerRadius = 5;
    gongjiao.layer.borderWidth = 1;
    gongjiao.layer.borderColor=[[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] CGColor];
    [gongjiao addTarget:self action:@selector(gongjiaosousuo) forControlEvents:UIControlEventTouchUpInside];
    [myview addSubview:gongjiao];

    buxing=[[UIButton alloc]initWithFrame:CGRectMake(210, 90, 90, 30)];
    [buxing setTitle:@"步行搜素" forState:UIControlStateNormal];
    [buxing setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buxing.titleLabel.font=[UIFont systemFontOfSize:14];
    buxing.titleLabel.textAlignment=NSTextAlignmentCenter;
    buxing.layer.masksToBounds = YES;
    buxing.layer.cornerRadius = 5;
    buxing.layer.borderWidth = 1;
    buxing.layer.borderColor=[[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] CGColor];
    [buxing addTarget:self action:@selector(buxingsousuo) forControlEvents:UIControlEventTouchUpInside];
    [myview addSubview:buxing];
    
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

//
//    CGSize screenSize = [[UIScreen mainScreen] currentMode].size;
//	if (((screenSize.width >= 639.9f))
//		&& (fabs(screenSize.height >= 959.9f)))
//	{
//		isRetina = TRUE;
//	}
}

- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    if (mapView)
    {
        NSLog(@"当前的坐标是: %f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
        if (userLocation.location.coordinate.latitude!=0.000000&&userLocation.location.coordinate.longitude!=0.000000)
        {
            startPt=(CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
        }
    }

    
}

- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
	if (error != nil)
		NSLog(@"locate failed: %@", [error localizedDescription]);
	else {
		NSLog(@"locate failed");
	}
	
}

- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
	NSLog(@"start locate");
}

-(void)jiachesousuo
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
    
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = startPt;
	start.name = _startAddrText.text;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddrText.text;
	BOOL flag = [_search drivingSearch:_startCityText.text startNode:start endCity:_endCityText.text endNode:end];
	if (!flag) {
		NSLog(@"search failed");
	}

}
//驾车返回结果
- (void)onGetDrivingRouteResult:(BMKSearch*)searcher result:(BMKPlanResult*)result errorCode:(int)error
{
    //NSLog(@"onGetDrivingRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
		
		
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
		item.title = @"起点";
		item.type = 0;
		[_mapView addAnnotation:item];
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[RouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
				item.degree = step.degree * 30;
				item.type = 4;
				[_mapView addAnnotation:item];
            }
			
		}
		
		item = [[RouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
		item.type = 1;
		item.title = @"终点";
		[_mapView addAnnotation:item];
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
	}

}
-(void)gongjiaosousuo
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = startPt;
	start.name = _startAddrText.text;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddrText.text;
    
	BOOL flag = [_search transitSearch:_startCityText.text startNode:start endNode:end];
    
	if (!flag) {
		NSLog(@"search failed");
	}

}
//公交返回结果
- (void)onGetTransitRouteResult:(BMKSearch*)searcher result:(BMKPlanResult*)result errorCode:(int)error
{
    @try
    {

    //NSLog(@"onGetTransitRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKTransitRoutePlan* plan = (BMKTransitRoutePlan*)[result.plans objectAtIndex:0];
		
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = plan.startPt;
		item.title = @"起点";
		item.type = 0;
		[_mapView addAnnotation:item];
		item = [[RouteAnnotation alloc]init];
		item.coordinate = plan.endPt;
		item.type = 1;
		item.title = @"终点";
		[_mapView addAnnotation:item];
        int size = [plan.lines count];
		int index = 0;
		for (int i = 0; i < size; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
			BMKLine* line = [plan.lines objectAtIndex:i];
			index += line.pointsCount;
			if (i == size - 1) {
				i++;
				route = [plan.routes objectAtIndex:i];
				for (int j = 0; j < route.pointsCount; j++) {
					int len = [route getPointsNum:j];
					index += len;
				}
				break;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < size; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			BMKLine* line = [plan.lines objectAtIndex:i];
			memcpy(points + index, line.points, line.pointsCount * sizeof(BMKMapPoint));
			index += line.pointsCount;
			
			item = [[RouteAnnotation alloc]init];
			item.coordinate = line.getOnStopPoiInfo.pt;
			item.title = line.tip;
			if (line.type == 0) {
				item.type = 2;
			} else {
				item.type = 3;
			}
			
			[_mapView addAnnotation:item];
            route = [plan.routes objectAtIndex:i+1];
			item = [[RouteAnnotation alloc]init];
			item.coordinate = line.getOffStopPoiInfo.pt;
			item.title = route.tip;
			if (line.type == 0) {
				item.type = 2;
			} else {
				item.type = 3;
			}
			[_mapView addAnnotation:item];
            if (i == size - 1) {
				i++;
				route = [plan.routes objectAtIndex:i];
				for (int j = 0; j < route.pointsCount; j++) {
					int len = [route getPointsNum:j];
					BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
					memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
					index += len;
				}
				break;
			}
		}
		
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
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
-(void)buxingsousuo
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
	BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = startPt;
	start.name = _startAddrText.text;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
	end.name = _endAddrText.text;
	BOOL flag = [_search walkingSearch:_startCityText.text startNode:start endCity:_endCityText.text endNode:end];
    
	if (!flag) {
		NSLog(@"search failed");
	}
   
}
//步行返回结果
- (void)onGetWalkingRouteResult:(BMKSearch*)searcher result:(BMKPlanResult*)result errorCode:(int)error;
{
    @try
    {

   // NSLog(@"onGetWalkingRouteResult:error:%d", error);
	if (error == BMKErrorOk) {
		BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
        
		RouteAnnotation* item = [[RouteAnnotation alloc]init];
		item.coordinate = result.startNode.pt;
		item.title = @"起点";
		item.type = 0;
		[_mapView addAnnotation:item];
		int index = 0;
		int size = [plan.routes count];
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				index += len;
			}
		}
		
		BMKMapPoint* points = new BMKMapPoint[index];
		index = 0;
		
		for (int i = 0; i < 1; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
				index += len;
			}
			size = route.steps.count;
			for (int j = 0; j < size; j++) {
				BMKStep* step = [route.steps objectAtIndex:j];
				item = [[RouteAnnotation alloc]init];
				item.coordinate = step.pt;
				item.title = step.content;
				item.degree = step.degree * 30;
				item.type = 4;
				[_mapView addAnnotation:item];
			}
			
		}
		
		item = [[RouteAnnotation alloc]init];
		item.coordinate = result.endNode.pt;
		item.type = 1;
		item.title = @"终点";
		[_mapView addAnnotation:item];
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
		[_mapView addOverlay:polyLine];
		delete []points;
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


-(void)ziwodingwei
{
    _mapView.showsUserLocation =YES;
    _startAddrText.text=@"我的位置";
}
-(void)sousuokuang
{
   static BOOL y=YES;
    if (y==YES)
    {
        y=NO;
        [myview removeFromSuperview];
    }
    else
    {
        [self.view addSubview:myview];
        y=YES;
    }
}
-(void)fanhui
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_startAddrText resignFirstResponder];
    [_startCityText resignFirstResponder];
    [_endAddrText resignFirstResponder];
    [_endCityText resignFirstResponder];
    
    return YES;
    
}
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
	BMKAnnotationView* view = nil;
	switch (routeAnnotation.type) {
		case 0:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 1:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
				view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 2:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"bus_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"bus_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 3:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"rail_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"rail_node"];
				view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_rail.png"]];
				view.canShowCallout = TRUE;
			}
			view.annotation = routeAnnotation;
		}
			break;
		case 4:
		{
			view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
			if (view == nil) {
				view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
				view.canShowCallout = TRUE;
			} else {
				[view setNeedsDisplay];
			}
			
			UIImage* image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_direction.png"]];
			view.image = [image imageRotatedByDegrees:routeAnnotation.degree];
			view.annotation = routeAnnotation;
			
		}
			break;
		default:
			break;
	}
	
	return view;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[RouteAnnotation class]]) {
		return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
	}
	return nil;
}
- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
	if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
	return nil;
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
