//
//  ZhengFuGongGaoViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-8-11.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhengfugonggao.h"
@interface ZhengFuGongGaoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    UILabel *labelline;
    UILabel *label;
    UIButton *button;
    NSMutableData *receiveData;
    NSMutableArray *arr;
    zhengfugonggao *gonggao;
    NSArray *workItemss;
    
}


@end
