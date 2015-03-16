//
//  FoodMedicineViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 15-1-5.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface FoodMedicineViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
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
