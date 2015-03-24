//
//  UserInfo.h
//  ZHSQ
//
//  Created by 赵中良 on 15/3/23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import "JDH.h"
#import "AddressInfo.h"

@interface UserInfo : NSObject


@property (nonatomic,strong) NSString *session;  //
@property (nonatomic,strong) NSString *userId;   //用户id
@property (nonatomic,strong) NSString *nickName;  //用户名（网络昵称）
/*
 用户姓名
 */
@property (nonatomic,strong) NSString *name;
/*
 用户性别
 */
@property (nonatomic,strong) NSString *sex;
/*
 用户权限
 */
@property (nonatomic,strong) NSString *rank;
/*
 用户头像地址
 */
@property (nonatomic,strong) NSString *icon_path;
/*
 用户邮箱
 */
@property (nonatomic,strong) NSString *email;
/*
 用户身份证号
 */
@property (nonatomic,strong) NSString *idnumber;
/*
 注册手机号码
 */
@property (nonatomic,strong) NSString *mobile_phone;
/*
 当前设备imei
 */
@property (nonatomic,strong) NSString *imei;

/*
 当前地址信息
 */
@property (nonatomic,strong) AddressInfo *currentAddress;

@property (nonatomic,strong) NSArray *personArr;

@property (nonatomic,strong) NSArray *carArr;

@property (nonatomic,strong) NSArray *jdhArr;

@property (nonatomic,strong) NSArray *addressArr;

- (id)initWithPersonArr:(NSArray *)PersonArr CarArr:(NSArray *)CarArr JdhArr:(NSArray *)JdhArr AddressArr:(NSArray *)AddressArr Session:(NSString *)Session;




































@end
