//
//  SheQuTongZhiXiangQingViewController.h
//  ZHSQ
//
//  Created by lacom on 14-6-16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheQuTongZhiXiangQingViewController : UIViewController<UIScrollViewDelegate>
{
    UILabel *label;
    UILabel *title_label;
    UILabel *label_content;
    UIButton *fanhui_btn;
    UIScrollView *myscrollview;
    
}
@property (strong,nonatomic)UIScrollView *myscrollview;


@end
