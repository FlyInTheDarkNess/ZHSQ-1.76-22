//
//  ShangJiaDiTuDingWeiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-8-4.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface ShangJiaDiTuDingWeiViewController : UIViewController<BMKMapViewDelegate, BMKSearchDelegate>
{
    BMKMapView* _mapView;
    BMKSearch* _search;
    UIButton *fanhui;
    NSString *jingdu;
    NSString *weidu;
}

@end
