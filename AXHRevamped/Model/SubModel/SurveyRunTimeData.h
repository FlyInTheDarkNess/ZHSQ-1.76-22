//
//  SurveyRunTimeData.h
//  HenanOA
//
//  Created by 安雄浩的mac on 14-5-12.
//  Copyright (c) 2014年 北京博微志远信息技术有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomMethod.h"
#import "MarkupParser.h"
#import "NSAttributedString+Attributes.h"

#import "MBProgressHUD.h"
@interface SurveyRunTimeData : NSObject
+ (SurveyRunTimeData*)sharedInstance;

@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *password;


//用户session
@property (nonatomic,strong) NSString *session;
//手机号码
@property (nonatomic,strong) NSString *mobilePhone;
//用户id
@property (nonatomic,strong) NSString *user_id;
/**
 *社区id
 */
@property (nonatomic,strong) NSString *community_id;
/**
 *城市id
 */
@property (nonatomic,strong) NSString *city_id;
/**
 *所在办事处
 */
@property (nonatomic,strong) NSString *agency_id;
/**
 *所在小区
 */
@property (nonatomic,strong) NSString *quarter_id;
/**
 *所在区县
 */
@property (nonatomic,strong) NSString *area_id;
// 十六进制转换为普通字符串的。
+ (NSString *)stringFromHexString:(NSString *)hexString;
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;

+ (void)creatAttributedLabel:(NSString *)o_text Label:(OHAttributedLabel *)label withFont:(float)font;
//hud
+(void)showWithCustomView:(UIView *)view withMsg:(NSString *)aString;
@end
