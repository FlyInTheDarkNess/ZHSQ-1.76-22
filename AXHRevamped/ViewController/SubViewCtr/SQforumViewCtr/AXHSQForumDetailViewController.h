//
//  AXHSQForumDetailViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "SQForumHttpService.h"
#import "tabbarView.h"
@interface AXHSQForumDetailViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate,tabbarDelegate>
@property (nonatomic,strong) UITableView *ltInforTableView;
//底部按钮
@property(nonatomic,strong) tabbarView *tabbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDetailDict:(NSDictionary *)dict;
@end
