//
//  ShangJiaPingJiaViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-7-25.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "PingJiaXinXi.h"
@interface ShangJiaPingJiaViewController : UIViewController<RatingViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UILabel *label_title;
    UIButton *fanhui;
    UIButton *wancheng;
    RatingView *starView;
	UILabel *ratingLabel;
    UIActionSheet *actSheet;
    NSString* filePath;
    UIActionSheet *myActionSheet;
    PingJiaXinXi *pingjia;
}
@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (strong, nonatomic) IBOutlet RatingView *starView;
@end
