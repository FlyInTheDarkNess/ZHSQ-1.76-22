//
//  UIViewController+CustomAppearance.h
//  HenanOA
//
//  Created by zengmiao on 7/8/14.
//  Copyright (c) 2014 安雄浩的mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomAppearance)

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
 *  如果需要自定义返回动作 重写此方法
 */
- (void)backBtnTapped;

/**
 *  导航栏右侧按钮事件
 */
- (void)rightBtnTapped;

/**
 *  底层背景
 */
- (void)customViewBackImageWithImageName:(NSString *)name;
@end
