//
//  AXHImageViewController.m
//  ZHSQ
//
//  Created by 安雄浩 on 15/2/10.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHImageViewController.h"

@interface AXHImageViewController (){
    UIImage *zoomImage;
}

@end

@implementation AXHImageViewController
@synthesize zoomScrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withImage:(UIImage *)image
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        zoomImage = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self customLeftNarvigationBarWithImageName:nil highlightedName:nil];
    [self customViewBackImageWithImageName:nil];
    self.navigationItem.title = @"图片预览";
    
    // Do any additional setup after loading the view.
     zoomScrollView = [[MRZoomScrollView alloc]initWithFrame:self.view.frame andImgNamed:zoomImage];
    [self.view addSubview:zoomScrollView];
}
-(void)backUpper{
    [self.navigationController  popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
