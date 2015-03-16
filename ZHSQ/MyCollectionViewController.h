//
//  MyCollectionViewController.h
//  ZHSQ
//
//  Created by 赵贺 on 15-1-28.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AXHBaseViewController.h"

#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"

@interface MyCollectionViewController : AXHBaseViewController<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>
{
    NSDictionary *m_emojiDic;
    
    UILabel *label_title;
    UIButton *fanhui;
    UIButton *btn_luntan;
    UIButton *btn_shangjia;
    UITableView *tableview_MyCollection;
    UILabel *label_tishi;
    int intb;
    int Status;
    NSMutableArray *arr_Forum;
    NSMutableArray *arr_Shops;
    NSMutableArray *arr_ForumId;
    NSMutableArray *arr_ShopsId;
    NSMutableArray *arr_MyReply;
    BOOL y;
    UILabel *labelll;
}


@end
