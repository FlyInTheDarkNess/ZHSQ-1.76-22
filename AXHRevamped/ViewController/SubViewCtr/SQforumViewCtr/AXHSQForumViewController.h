//
//  AXHSQForumViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "SQForumHttpService.h"
@interface AXHSQForumViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *ltTableView;
@end
