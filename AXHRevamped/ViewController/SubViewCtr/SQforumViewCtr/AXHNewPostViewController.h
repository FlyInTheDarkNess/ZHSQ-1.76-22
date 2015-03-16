//
//  AXHNewPostViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
//#import "ZYQAssetPickerController.h" ZYQAssetPickerControllerDelegate
#import "SQForumHttpService.h"
typedef enum {
    //以下是枚举成员
    PostTypeDefault = 0,//新帖子
    PostTypeBack,//回复帖子
    PostTypeNews,//报料
    PostTypeZXBack,//回复帖子
}PostType;//枚举名称
@interface AXHNewPostViewController : AXHBaseViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) PostType postType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(PostType)type withBackDict:(NSDictionary *)dict;
@end
