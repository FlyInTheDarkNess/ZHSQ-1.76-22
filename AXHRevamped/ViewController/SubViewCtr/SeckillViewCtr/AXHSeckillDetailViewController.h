//
//  AXHSeckillDetailViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "AXHYHGoodsHttpService.h"
#import "MZTimerLabel.h"
@interface AXHSeckillDetailViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate,MZTimerLabelDelegate>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withStoreId:(NSString *)storeId withGoodsId:(NSString *)goodsId;
@property (nonatomic,strong) UITableView *msGoodsDetailTableView;


@end
