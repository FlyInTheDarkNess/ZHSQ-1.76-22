//
//  LuXianDaoHangViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-8-6.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface LuXianDaoHangViewController : UIViewController<BMKMapViewDelegate, BMKSearchDelegate,UITextFieldDelegate>
{
    UILabel *label_title;
    UIButton *caidan;
    UIButton *jiache;
    UIButton *gongjiao;
    UIButton *buxing;
    UIButton *wodeweizhi;
    UIButton *fanhui;
    BMKMapView *_mapView;
    BMKSearch *_search;
    UITextField* _startCityText;
    UITextField* _startAddrText;
    UITextField* _endCityText;
    UITextField* _endAddrText;
    UIView *myview;
    UILabel *qidian;
    UILabel *zhongdian;
 
    CLLocationCoordinate2D startPt;
}
@end
