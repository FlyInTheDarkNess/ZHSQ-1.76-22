//
//  AXHImageViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 15/2/10.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "MRZoomScrollView.h"
@interface AXHImageViewController : AXHBaseViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withImage:(UIImage *)image;
@property (nonatomic, retain) MRZoomScrollView  *zoomScrollView;
@end
