//
//  MRZoomScrollView.h
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MRZoomScrollView : UIScrollView <UIScrollViewDelegate>
{
    UIImageView *imageView;
   CGSize minScaleSize;
    BOOL zoom;
}

@property (nonatomic, retain) UIImageView *imageView;

- (id)initWithFrame:(CGRect)frame  andImgNamed:(UIImage *)img;
//-(void)zoomEnlargeView;

-(void)zoomReset;
@end
