//
//  AXHYHGoodsDetailViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "AXHYHGoodsHttpService.h"
@interface AXHYHGoodsDetailViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withGoodsId:(NSString *)goodsId;
@property (nonatomic,strong) UITableView *yhGoodsDetailTableView;
@end
