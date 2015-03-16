//
//  AXHBaseViewController.m
//  HappyFace
//
//  Created by 安雄浩的mac on 14-12-5.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//

#define KBarButtomWidth 48
#define KBarButtomHeight 20.5
#import "AXHBaseViewController.h"

@interface AXHBaseViewController ()

@end

@implementation AXHBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)didReceieveSuccess:(NSInteger)tag{
    
}
-(void)didReceieveFail:(NSInteger)tag{
    
}
#pragma mark LabSize
-(void)labelSizeToFitHeight:(UILabel *)lab withWidth:(float)width withy:(float)y
{
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    [lab sizeToFit];
    CGRect frame = lab.frame;
    frame.origin.y = y;
    frame.size.width = width;
    lab.frame = frame;
}

-(void)labelSizeToFitWidth:(UILabel *)lab
{
    lab.numberOfLines = 1;
    [lab sizeToFit];
    CGRect frame = lab.frame;
    lab.frame = frame;
}

#pragma mark NarvigationBtn
- (void)customLeftNarvigationBarWithImageName:(NSString *)name
                              highlightedName:(NSString *)highLightedName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *normalImgName = name;
    NSString *highlightedImgName = highLightedName;
    if (!normalImgName) {
        normalImgName = @"back_normal";
    }
    if (!highlightedImgName) {
        highlightedImgName = @"back_normal";
    }
    [btn setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:highlightedImgName] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(backUpper) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 0, 58/2, 88/2);
     UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn] ;
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)customLeftNarvigationBarWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn addTarget:self action:@selector(backUpper) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 35, 35);
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
}

-(void)rightNarvigationBarMove{
    self.navigationItem.rightBarButtonItem = nil;
}
/**
 *  自定义导航栏右侧按钮
 *
 *  @param name            图片名称 默认 back
 *  @param highLightedName highLightedName description
 */
- (void)customRightNarvigationBarWithImageName:(NSString *)name
                               highlightedName:(NSString *)highLightedName
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *normalImgName = name;
    NSString *highlightedImgName = highLightedName;
    if (!normalImgName) {
        normalImgName = @"fatie0508";
    }
    if (!highlightedImgName) {
        highlightedImgName = @"fatie0508";
    }
    [btn setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:highlightedImgName] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(nextControl) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 0, 35, 35);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn] ;
    self.navigationItem.rightBarButtonItem = barItem;
}

/**
 *  自定义导航栏右侧按钮
 *
 *  @param title title 默认 "完成"
 */

- (void)customRightNarvigationBarWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [btn addTarget:self action:@selector(nextControl) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 40, 40);
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
    
}
-(void)backUpper{
    
}
-(void)nextControl{
    
}
#pragma mark ViewBackImage
- (void)customViewBackImageWithImageName:(NSString *)name withColor:(UIColor *)viewBackColor{
    if (!name) {
        name = @"BackImage";
    }
    if (!viewBackColor) {
        viewBackColor = [UIColor whiteColor];
    }
    self.view.backgroundColor = viewBackColor;
    
}

-(void)altshowMsg:(NSString *)msg{
    UIAlertView  *alt = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
}
@end
