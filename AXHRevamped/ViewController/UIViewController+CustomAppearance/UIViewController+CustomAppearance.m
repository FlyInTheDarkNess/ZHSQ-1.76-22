//
//  UIViewController+CustomAppearance.m
//  HenanOA
//
//  Created by zengmiao on 7/8/14.
//  Copyright (c) 2014 安雄浩的mac. All rights reserved.
//

#import "UIViewController+CustomAppearance.h"
#define KBarButtomWidth 28

@implementation UIViewController (CustomAppearance)

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
    [btn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(10, 0, 58/2, 88/2);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn] ;
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)customLeftNarvigationBarWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn addTarget:self action:@selector(backBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 35, 35);
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
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

    if (!name) {
        name = @"ZXNavAdd.png";
    }
    if (!highLightedName) {
        highLightedName = @"ZXNavAdd.png";
    }
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highLightedName] forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn addTarget:self action:@selector(rightBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, KBarButtomWidth, KBarButtomWidth);
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
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
    NSString *normalTitle;
    NSString *highlightedTitle;
    if (!normalTitle) {
        normalTitle = @"完成";
    }
    if (!highlightedTitle) {
        highlightedTitle = @"完成";
    }
    [btn setTitle:normalTitle forState:UIControlStateNormal];
    [btn setTitle:highlightedTitle forState:UIControlStateHighlighted];
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [btn addTarget:self action:@selector(rightBtnTapped) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 35, 35);
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;

}

- (void)backBtnTapped{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnTapped
{
    
}
#pragma mark ViewBackImage
- (void)customViewBackImageWithImageName:(NSString *)name{
    if (!name) {
        name = @"BackImage";
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
