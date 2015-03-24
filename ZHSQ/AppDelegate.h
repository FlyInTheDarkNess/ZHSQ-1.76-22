//
//  AppDelegate.h
//  ZHSQ
//
//  Created by lacom on 14-4-10.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "DengLuHouZhuYeViewController.h"
#import "SheQuXuanZeViewController.h"
#import "AddressMessageViewController.h"
#import "shouyeViewController.h"

int CommunitySelectionSource;
NSString *Card_id;
NSString *email;
NSString *columns_id;
NSString *columns_introduction;
NSString *first_play_time;
NSString *repeat_play_time;
NSString *HitRecommend_type;
NSString *community_id;
NSString *agency_id;
NSString *city_id;
NSString *area_id;
NSString *quarter_id;
NSString *string_Account;
NSString *string_Password;
NSString *Title_label;
int IsFiirst;
int WDNum;
NSString *Name;
NSString *biaoti;
NSString *xinwentitle;
NSString *pindaoID;
NSString *UserName;
NSString *Session;
NSString *LuXianXinXi;
NSString *icon_path;
NSString *rowString;
NSString *xiaoquIDString;
NSString *xiaoquming;
NSString *Type;
NSString *Payment_url;
NSString *SheQuFuWu_Title;
NSString *mobel_iphone;
NSString *Address_id;
NSString *charge_mode;
NSMutableArray *arr_info_shequfuwu;
NSMutableArray *arr_shequfuwu;
NSMutableArray *arr_ChangTuKeYun;


NSDictionary *WeiZhangJiLuDictionary;
NSDictionary *Dictionary;
NSDictionary *TZDictionary;
NSDictionary *SQTZDictionary;
NSDictionary *SQdtDictionary;
NSDictionary *FUWUdtDictionary;
NSDictionary *SheQuHuDongXiangQingDictionary;
NSDictionary *ZhengFuGongGaoDictionary;
NSDictionary *FangChanYeWuDictionary;
NSDictionary *ShiPinYaoPin_Dictionary;
NSDictionary *WYF_Dictionary;
NSDictionary *NQF_Dictionary;
NSDictionary *WoDeZhangDan_Dictionary;
NSDictionary *QiChe_Dictionary;
NSDictionary *SJXXdtDictionary;
NSDictionary *MyMessageDictionary;
NSDictionary *PersonInformationDictionary;
NSDictionary *YouHuiZiXunDic;
NSDictionary *GroupBuyingDic;


/*
 与赵贺无关
 */

UserInfo *user;




@class shouyeViewController;
@class wViewController;
NSMutableArray *searchResults;
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager *mapManager; //实例化
    NSMutableArray *arr_info;
    NSString *mima;

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AddressMessageViewController *AddressviewController;
@property (strong, nonatomic) SheQuXuanZeViewController *viewController;
@property (strong, nonatomic) DengLuHouZhuYeViewController *vController;
@property (strong, nonatomic) shouyeViewController *LoginController;
- (void)exitApplication;
-(void)SetTag:(NSArray *) tag  withAlias:(NSString *)alias;
@end
