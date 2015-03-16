//
//  FaBiaoTieZiViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-1.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaBiaoTieZiViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

{

    __weak IBOutlet UITextView *textview;
    __weak IBOutlet UITextField *textfield;
    UIActionSheet *actSheet;
    NSString* filePath;
    UIActionSheet *myActionSheet;
    __weak IBOutlet UIImageView *imageview;
    NSData *date_image;

}

- (IBAction)fanhui:(id)sender;
- (IBAction)fabu:(id)sender;
@end
