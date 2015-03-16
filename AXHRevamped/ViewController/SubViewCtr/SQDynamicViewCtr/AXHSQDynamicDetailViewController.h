//
//  AXHSQDynamicDetailViewController.h
//  HappyFace
//
//  Created by 安雄浩 on 14/12/9.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "tabbarView.h"
#import "MoviePlayerViewController.h"

@interface AXHSQDynamicDetailViewController : AXHBaseViewController<tabbarDelegate,MoviePlayerViewControllerDataSource,UITableViewDataSource,UITableViewDelegate>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDetailDict:(NSDictionary *)dict withTitle:(NSString *)title;

@property (nonatomic,strong) UITableView *inforTableView;
//底部按钮
@property(nonatomic,strong) tabbarView *tabbar;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong)UIView *footView;

@property (nonatomic,strong) UIView *tableHeadView;
@end
