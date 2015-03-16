//
//  MyReplyViewController.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSAttributedString+Attributes.h"
#import "MarkupParser.h"
#import "OHAttributedLabel.h"
#import "CustomMethod.h"

@interface MyReplyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,OHAttributedLabelDelegate>
{
    NSDictionary *m_emojiDic;
    NSString *tieziID;
    NSString *sanchu_url;
    UILabel *label_title;
    UIButton *fanhui;
    UIButton *btn_weijiaofeizhangdan;
    UIButton *btn_lishizhangdan;
    UITableView *tableview_MyReply;
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
