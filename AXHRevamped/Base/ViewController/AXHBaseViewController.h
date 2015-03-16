//
//  AXHBaseViewController.h
//  HappyFace
//
//  Created by 安雄浩的mac on 14-12-5.
//  Copyright (c) 2014年 安雄浩的mac. All rights reserved.
//
#define kViewwidth [UIScreen mainScreen].applicationFrame.size.width
#define kViewHeight [UIScreen mainScreen].applicationFrame.size.height
#import <UIKit/UIKit.h>
#import "AXHhttpService.h"
@interface AXHBaseViewController : UIViewController<HttpDataServiceDelegate>





-(void)backUpper;
-(void)nextControl;

/**
 *  自适应lab高宽
 *
 *  @param lab      传入UILabel
 */
-(void)labelSizeToFitHeight:(UILabel *)lab withWidth:(float)width withy:(float)y;
-(void)labelSizeToFitWidth:(UILabel *)lab;

/**
 *  自定义导航栏返回按钮
 *
 *  @param name            图片名称 默认 back
 *  @param highLightedName highLightedName description
 */
- (void)customLeftNarvigationBarWithImageName:(NSString *)name
                              highlightedName:(NSString *)highLightedName;

/**
 *  自定义导航栏返回按钮
 *
 *  @param title title 默认 "返回"
 */
- (void)customLeftNarvigationBarWithTitle:(NSString *)title;

/**
 *  自定义导航栏右侧按钮
 *
 *  @param name            图片名称 默认 ZXNavAdd.png
 *  @param highLightedName highLightedName description
 */
- (void)customRightNarvigationBarWithImageName:(NSString *)name
                               highlightedName:(NSString *)highLightedName;

/**
 *  自定义导航栏右侧按钮
 *
 *  @param title title 默认 "完成"
 */
- (void)customRightNarvigationBarWithTitle:(NSString *)title;

/**
 *
 *@param rightBtn移除
 */

- (void)rightNarvigationBarMove;

/**
 *  自定义视图背景图片
 *
 *  @param title title 默认 白色
 */
- (void)customViewBackImageWithImageName:(NSString *)name withColor:(UIColor *)viewBackColore;

-(void)altshowMsg:(NSString *)msg;
@end
