//
//  FaTieZiViewController.h
//  ZHSQ
//
//  Created by lacom on 14-5-14.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "huitie.h"
@interface FaTieZiViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UIActionSheet *actSheet;
    NSString* filePath;
    UIActionSheet *myActionSheet;
    NSData *date_image;

}
- (IBAction)tijiaohuitie:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *textview;
- (IBAction)tianjia:(id)sender;
- (IBAction)fanhui:(id)sender;

@end
