//
//  MyPostsViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-21.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"
#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"

@interface MyPostsViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>

{
    NSDictionary *m_emojiDic;
    
    UILabel *label_title;
    UIButton *fanhui;
    UITableView *tableview_MyPosts;
    int intb;
    NSMutableArray *arr_MyPosts;
    NSMutableArray *arr_PostsId;
    NSString *tieziID;
}

@end
