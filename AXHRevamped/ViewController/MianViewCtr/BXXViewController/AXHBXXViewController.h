//
//  AXHBXXViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 15/1/19.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface AXHBXXViewController : AXHBaseViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollRootView;
@property (nonatomic,strong) UITableView  *subTableView;

@end
