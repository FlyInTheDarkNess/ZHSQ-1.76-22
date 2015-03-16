//
//  SheQuXuanZeViewController.h
//  ZHSQ
//
//  Created by lacom on 14-7-4.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "jiansuo.h"
#import "XuanZeChengShiViewController.h"
@interface SheQuXuanZeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *dataArray;
    NSMutableArray *dataArray2;
    NSMutableArray *searchResults;
    NSMutableArray *searchResults2;

    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    UITableView *mytableView;
    UILabel *xiaoquliebiao;
    UILabel *label_line;
    NSMutableArray *arr;
    NSMutableArray *arr2;
    NSMutableArray *arr1;
    XuanZeChengShiViewController *xuanze;
    jiansuo *jian;
    
}
- (IBAction)xuanzechengshi:(id)sender;
@end
