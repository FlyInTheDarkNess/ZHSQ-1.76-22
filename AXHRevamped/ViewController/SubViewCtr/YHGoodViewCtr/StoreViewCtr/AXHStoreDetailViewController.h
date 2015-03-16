//
//  AXHStoreDetailViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/21.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "AXHYHGoodsHttpService.h"
#import "RatingView.h"
@interface AXHStoreDetailViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStoreId:(NSString *)storeID;
@property (nonatomic,strong) UITableView *detaidTableView;
@end
