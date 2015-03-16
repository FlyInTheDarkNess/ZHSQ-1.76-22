//
//  MRZoomScrollView.m
//  ScrollViewWithZoom
//
//  Created by xuym on 13-3-27.
//  Copyright (c) 2013年 xuym. All rights reserved.
//

#import "MRZoomScrollView.h"

#define ZOOM_LEVELS 2.5

#define CONTENT_INSET 0.0f

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)

@interface MRZoomScrollView (Utility)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end

@implementation MRZoomScrollView
@synthesize imageView;


static inline CGFloat ZoomScaleThatFits(CGSize target, CGSize source)

{
    
    CGFloat w_scale = (target.width / source.width);
    
    CGFloat h_scale = (target.height / source.height);
    
    
    
    return ((w_scale < h_scale) ? w_scale : h_scale);
    
}
#pragma mark ReaderContentView instance methods

#pragma remark 设置捏合放大缩小的范围大小

- (void)updateMinimumMaximumZoom

{
    
    CGRect targetRect = CGRectInset(self.bounds, CONTENT_INSET, CONTENT_INSET);

    CGFloat zoomScale = ZoomScaleThatFits(targetRect.size, imageView.bounds.size);

    
    self.minimumZoomScale = zoomScale; // Set the minimum and maximum zoom scales
 
    self.maximumZoomScale = (zoomScale * ZOOM_LEVELS); // Max number of zoom levels

}
- (id)initWithFrame:(CGRect)frame  andImgNamed:(UIImage *)img

{
    
    self = [super initWithFrame:frame];

    if (self) {
        
        self.frame=frame;
        
        self.delaysContentTouches = NO;
        
        self.showsVerticalScrollIndicator = NO;
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.contentMode = UIViewContentModeRedraw;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.userInteractionEnabled = YES;
        
        self.autoresizesSubviews = NO;
        
        self.bouncesZoom = YES;
        
        self.delegate=self;

        minScaleSize = img.size;

        float theWidth;
        
        float theHeigth;
        
        if (img.size.width >= self.bounds.size.width*0.8 && img.size.height>=self.bounds.size.height*0.8) {
            
            theWidth = 320;
            
            
            theHeigth=img.size.height * 320 / img.size.width;
            if (theHeigth > self.bounds.size.height) {
                theHeigth = self.bounds.size.height;
            }
     

        }else{
            
            theWidth=img.size.width;
            theHeigth=img.size.height;

        }
        imageView=[[UIImageView alloc]initWithImage:img];
        
        imageView.userInteractionEnabled=YES;
        
        imageView.frame=CGRectMake(0,0,theWidth,theHeigth);
  
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(handleDoubleTap:)];
        [doubleTapGesture setNumberOfTapsRequired:2];
        [imageView addGestureRecognizer:doubleTapGesture];
        self.userInteractionEnabled=YES;
 
        [self addSubview:imageView];

        [self updateMinimumMaximumZoom]; // Update the minimum and maximum zoom scales
          self.zoomScale = self.minimumZoomScale;
  
    }
    return self;
  
}

//layoutSubviews－－－－在每次创建该控制器的时候或者是方向旋转时就会调用，用来控制旋转时控件的frame 大小

- (void)layoutSubviews

{
    
#ifdef DEBUGX
    
    NSLog(@"%s", __FUNCTION__);
    
#endif

    [super layoutSubviews];

    CGSize boundsSize = self.bounds.size;
    
    CGRect viewFrame = imageView.frame;
    if (viewFrame.size.width < boundsSize.width)

        viewFrame.origin.x = (((boundsSize.width - viewFrame.size.width) / 2.0f) + self.contentOffset.x);
    else
        viewFrame.origin.x = 0.0f;

    if (viewFrame.size.height <=  boundsSize.height)

        viewFrame.origin.y = (((boundsSize.height  - viewFrame.size.height) / 2.0f) + self.contentOffset.y);
    else
        viewFrame.origin.y = 0.0f;
    imageView.frame = viewFrame;

}



#pragma mark - Zoom methods

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    if (self.zoomScale > self.minimumZoomScale)
    {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
    else
    {
        CGRect zoomRect = [self zoomRectForScale:self.zoomScale * ZOOM_LEVELS withCenter:[gesture locationInView:gesture.view]];
        [self zoomToRect:zoomRect animated:YES];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{

    return imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale animated:NO];
}

#pragma mark - View cycle
- (void)dealloc
{
   
}

@end
