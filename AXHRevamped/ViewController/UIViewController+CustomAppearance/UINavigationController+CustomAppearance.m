//
//  UINavigationController+CustomAppearance.m
//  ZHSQ
//
//  Created by 安雄浩 on 15/2/12.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "UINavigationController+CustomAppearance.h"

@implementation UINavigationController (CustomAppearance)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
   
    return toInterfaceOrientation != UIDeviceOrientationPortrait;
}
- (BOOL)shouldAutorotate
{
    
   
    return NO;
}


- (NSUInteger)supportedInterfaceOrientations
{
    
    
        return UIInterfaceOrientationMaskPortrait;
}

@end
