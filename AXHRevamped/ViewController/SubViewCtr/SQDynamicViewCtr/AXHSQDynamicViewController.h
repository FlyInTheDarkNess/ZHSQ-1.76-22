//
//  AXHSQDynamicViewController.h
//  HappyFace
//
//  Created by 安雄浩的mac on 14-12-5.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "SQDynamicHttpService.h"
@interface AXHSQDynamicViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate>


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withTitle:(NSString *)title withType:(NSInteger)type;

@property(nonatomic,strong) UITableView *dtTableView;

@end
