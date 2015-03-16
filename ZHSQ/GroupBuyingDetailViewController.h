//
//  GroupBuyingDetailViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-2-11.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface GroupBuyingDetailViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
{

    int g;
    int i;
    BOOL y;
    UILabel *num_label;
}
@property (nonatomic,strong) UITableView *tgGoodsDetailTableView;
@property (nonatomic,assign) NSDictionary *goodsType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(NSDictionary *)type;

@end
