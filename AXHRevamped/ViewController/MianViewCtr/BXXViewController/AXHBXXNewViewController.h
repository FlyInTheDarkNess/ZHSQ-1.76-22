//
//  AXHBXXNewViewController.h
//  ZHSQ
//
//  Created by 安雄浩 on 15/2/12.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

#import "SQForumHttpService.h"

@interface AXHBXXNewViewController : AXHBaseViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate>



@property (nonatomic,strong) UITableView *BXXTypeTableView;
@end
