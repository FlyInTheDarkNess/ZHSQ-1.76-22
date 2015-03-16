//
//  CommunityDynamicViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-13.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityDynamicHttpRequest.h"
#import "CommunityDynamicHttpService.h"
@interface CommunityDynamicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HttpDataServiceDelegate>
@property(nonatomic,strong) UITableView *dtTableView;


@end
