//
//  ZhengFuGongGaoXiangQingViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-8-11.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhengFuGongGaoXiangQingViewController : UIViewController<UIScrollViewDelegate>
{
    UILabel *label;
    UILabel *title_label;
    UILabel *label_time;
    UILabel *label_content;
    UILabel *label_publish_department;
    UILabel *hengxian;
    UIButton *fanhui_btn;
    UIScrollView *myscrollview;
    UIImageView *imageview;
    
}
@property (strong,nonatomic)UIScrollView *myscrollview;

@end
