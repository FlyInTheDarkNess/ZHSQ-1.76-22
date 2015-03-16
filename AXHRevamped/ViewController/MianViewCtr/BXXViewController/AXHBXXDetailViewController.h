//
//  AXHBXXDetailViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 15/1/24.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

@interface AXHBXXDetailViewController : AXHBaseViewController
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIView *headView;
@property (nonatomic,strong) UIView *contentView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withDetailDict:(NSDictionary *)dict;
@end
