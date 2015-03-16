//
//  ShopsDetailsViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-28.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "AXHYHGoodsHttpService.h"
#import "RatingView.h"
@interface ShopsDetailsViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStoreId:(NSString *)storeID;
@property (nonatomic,strong) UITableView *detaidTableView;


@end
