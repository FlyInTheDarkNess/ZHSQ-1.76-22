//
//  AddressInfo.h
//  ZHSQ
//
//  Created by 赵中良 on 15/3/23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressInfo : NSObject

/*
 绑定信息ID
 */
@property (nonatomic,strong) NSString *address_id;

/*
 绑定城市ID
 */
@property (nonatomic,strong) NSString *city_id;

/*
 绑定城市名称
 */
@property (nonatomic,strong) NSString *city_name;

/*
 绑定区县ID
 */
@property (nonatomic,strong) NSString *area_id;

/*
 绑定区县名称
 */
@property (nonatomic,strong) NSString *area_name;

/*
 绑定办事处ID
 */
@property (nonatomic,strong) NSString *agency_id;

/*
 绑定办事处名称
 */
@property (nonatomic,strong) NSString *agency_name;

/*
 绑定社区ID
 */
@property (nonatomic,strong) NSString *community_id;

/*
 绑定社区名称
 */
@property (nonatomic,strong) NSString *community_name;

/*
 绑定小区ID
 */
@property (nonatomic,strong) NSString *quarter_id;

/*
 绑定小区名称
 */
@property (nonatomic,strong) NSString *quarter_name;

/*
 绑定楼宇ID
 */
@property (nonatomic,strong) NSString *building_id;

/*
 绑定楼宇名称
 */
@property (nonatomic,strong) NSString *building_name;

/*
 绑定单元ID
 */
@property (nonatomic,strong) NSString *unit_id;

/*
 绑定单元名称
 */
@property (nonatomic,strong) NSString *unit_name;

/*
 绑定房间ID
 */
@property (nonatomic,strong) NSString *room_id;

/*
 绑定房间名称
 */
@property (nonatomic,strong) NSString *room_name;

/*
 是否当前默认显示
 */
@property (nonatomic,strong) NSString *isdefaultshow;

/*
 小区物业费收费模式
 0：普通收费模式
 1：综合收费模式
 */
@property (nonatomic,strong) NSString *charge_mode;

- (id)initWithAddress_id : (NSString *)Address_id
                 City_id : (NSString *)City_id
               City_name : (NSString *)City_name
                 Area_id : (NSString *)Area_id
               Area_name : (NSString *)Area_name
               Agency_id : (NSString *)Agency_id
             Agency_name : (NSString *)Agency_name
            Community_id : (NSString *)Community_id
          Community_name : (NSString *)Community_name
              Quarter_id : (NSString *)Quarter_id
            Quarter_name : (NSString *)Quarter_name
             Building_id : (NSString *)Building_id
           Building_name : (NSString *)Building_name
                 Unit_id : (NSString *)Unit_id
               Unit_name : (NSString *)Unit_name
                 Room_id : (NSString *)Room_id
               Room_name : (NSString *)Room_name
           Isdefaultshow : (NSString *)Isdefaultshow
             Charge_mode : (NSString *)Charge_mode;



@end
