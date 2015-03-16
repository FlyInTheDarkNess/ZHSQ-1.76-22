//
//  ShiPinYaoPinViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-11-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiPinYaoPinViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    NSMutableData *receiveData;
    NSMutableArray *arr;
    NSArray *workItemss;
    
}


@end
