//
//  AXHSeckillIntroduceViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface AXHSeckillIntroduceViewController : AXHBaseViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withSeckillDict:(NSDictionary *)dict;

@property (nonatomic,strong) UIScrollView *scrollRootView;

@end
