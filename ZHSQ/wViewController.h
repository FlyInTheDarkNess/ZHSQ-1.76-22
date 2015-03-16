//
//  wViewController.h
//  shi
//
//  Created by zhao on 14-2-27.
//  Copyright (c) 2014年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface wViewController : UIViewController<UIScrollViewDelegate,UIAlertViewDelegate>
{
    UIScrollView *scrollview;
    NSMutableArray *imageArr;
    UIPageControl *pagectrl;
}

@end
