//
//  GeRenXinXiWanShanViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-9-22.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeRenXinXiWanShanViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UILabel *label_title;
    UIButton *fanhui;
    UIButton *wancheng;
    UIImageView *imageview;
    UILabel *hengxian;
    UILabel *beijing;
    UILabel *label_xingming;
    UILabel *nicheng;
    UILabel *shenfenzheng;
    UILabel *youxiang;
    UILabel *huixian1;
    UILabel *huixian2;
    UILabel *huixian3;

    UITextField *nicheng_textfield;
    UITextField *xingming_textfield;
    UITextField *shenfenzheng_textfield;
    UITextField *youxiang_textfield;
    UIView *view_beijing;
    NSString *iconPath;
}

@end
