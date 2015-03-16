//
//  ChongZhiMiMaViewController.h
//  ZHSQ
//
//  Created by lacom on 14-4-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChongZhiMiMaViewController : UIViewController
{
    UIButton *DaoJiShiBtn;
    NSTimer *timer;
    NSTimer *m_pTimer;
    NSDate *m_pStartDate;
    UILabel *label;
}
- (IBAction)fanhui:(id)sender;

@end
