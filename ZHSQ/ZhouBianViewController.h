//
//  ZhouBianViewController.h
//  ZHSQ
//
//  Created by lacom on 14-4-24.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMKMapView.h"
#import "BMapKit.h"

@interface ZhouBianViewController : UIViewController<BMKMapViewDelegate,BMKSearchDelegate,UITextFieldDelegate>
{
    BMKMapView *mapView;
    BMKSearch *search;
    int curPage;
    UIButton *FuWwBtn;
    UIButton *GouWwBtn;
    UIButton *YuLeBtn;
    UIButton *MeiShiBtn;
    UIButton *LuXian;
    UILabel *label;
    UIView *sousuoview;
    UILabel *linelabel;
    UIImageView *imageview;
    UILabel *labelbiaoti;
    UITextField *textfield;
    UIButton *SouSuoBtn;
    UIButton *QuXiaoBtn;
    NSString *jingdu;
    NSString *weidu;
    UILabel *label_xuanxiangbeijing;
    UILabel *label_shuoming;
}
- (IBAction)fanhui:(id)sender;
- (IBAction)sousuo:(id)sender;

@end
