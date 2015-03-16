//
//  LaiWupindaoViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-7-17.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHOUshizhinan.h"
@interface LaiWupindaoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_timeString;
    UIButton *fanhui;
    NSString *_nowDateString;
    NSMutableArray* _btnArray;
    
    UIView* _cBSView;
    UIView* _cBPView;
    UIView* _cBMIView;
    UIView* _lBSView;
    UIView* _lBPView;
    UIView* _lBMIView;
    UIView* _rBSView;
    UIView* _rBPView;
    UIView* _rBMIView;
    
    UILabel* _bsLable;
    UILabel* _bpLable;
    UILabel* _weightLable;
    UILabel* _appointLable;
    UILabel* _healthLable;
    UILabel* _manageLable;
    
    UILabel* _bsLableR;
    UILabel* _bpLableR;
    UILabel* _weightLableR;
    UILabel* _appointLableR;
    UILabel* _healthLableR;
    
    UILabel* _bsLableL;
    UILabel* _bpLableL;
    UILabel* _weightLableL;
    UILabel* _appointLableL;
    UILabel* _healthLableL;
    
    UIScrollView* _scrollView;
    UIView* _dateView;
    UIView* _workView;
    
    UILabel* dateLable;
    int _scrollDate;                    //控制中间日期
    int _btnDate;
    
    int _changeWeek;                    //控制滑动日期
    int _btnSelectDate;                 //btn选择的位置
    UIView* _changeDateR;
    UIView* _changeWorkR;
    UIView* _changeDateL;
    UIView* _changeWorkL;
    NSMutableArray* _changeBtnArrayR;   //RView的Btn数组
    NSMutableArray* _changeBtnArrayL;   //LView的Btn数组
    NSArray *laiwu_jiemodan;
    UITableView *tableview;
}
@property(nonatomic, retain)NSString* nowDateString;
@property(nonatomic, retain)UILabel* bsLable;
@property(nonatomic, retain)UILabel* bpLable;
@property(nonatomic, retain)UILabel* weightLable;
@property(nonatomic, retain)UILabel* appointLable;
@property(nonatomic, retain)UILabel* healthLable;
@property(nonatomic, retain)NSMutableArray* btnArray;
@property(nonatomic, retain)UIScrollView* scrollView;
@property(nonatomic, retain)UIView* dateView;
@property(nonatomic, retain)UIView* workView;


@end
