//
//  SheQuDongTaiXiangQingViewController.h
//  ZHSQ
//
//  Created by lacom on 14-5-15.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePlayerViewController.h"
@interface SheQuDongTaiXiangQingViewController : UIViewController<MoviePlayerViewControllerDataSource,UIScrollViewDelegate>
{
    NSMutableArray *a;
    NSMutableArray *b;
    NSMutableArray *c;
    NSMutableArray *d;
    NSMutableArray *e;
    NSMutableArray *gaodu;
    NSMutableArray *zonggaodu;
    UIButton *playbtn;
    UILabel *label;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label_content;
    UIScrollView *myscrollview;
    int sum_label;
    NSString *video_url;
    UIImageView *imageview2;
    UIButton *fanhui_btn;
    int kh;
    
}
@property (strong,nonatomic)UIScrollView *myscrollview;



@end