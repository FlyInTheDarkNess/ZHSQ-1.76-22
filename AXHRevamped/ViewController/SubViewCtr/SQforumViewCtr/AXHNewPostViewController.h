//
//  AXHNewPostViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 14/12/26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

#import "SQForumHttpService.h"

#import "CTAssetsPageViewController.h"
#import "CTAssetsPickerController.h"

typedef enum {
    //以下是枚举成员
    PostTypeDefault = 0,//新帖子
    PostTypeBack,//回复帖子
    PostTypeNews,//报料
    PostTypeZXBack,//回复帖子
}PostType;//枚举名称
@interface AXHNewPostViewController : AXHBaseViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CTAssetsPickerControllerDelegate>
//UIPopoverControllerDelegate pad选图片调用

@property (nonatomic,assign) PostType postType;
@property (nonatomic, strong) NSMutableArray *assets;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withType:(PostType)type withBackDict:(NSDictionary *)dict;
@end
