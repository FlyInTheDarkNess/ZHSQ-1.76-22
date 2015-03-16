//
//  XiTongSheZhiViewController.h
//  ZHSQ
//
//  Created by lacom on 14-4-16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XiTongSheZhiViewController : UIViewController
{
    __weak IBOutlet UILabel *label_biejing;
    __weak IBOutlet UILabel *label_banbenhao;
    UIButton *Btn_tuisong;
    NSString *str_tuisong;
}

- (IBAction)fanhui:(id)sender;

@end
