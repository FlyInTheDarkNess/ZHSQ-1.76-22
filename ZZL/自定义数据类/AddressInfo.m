//
//  AddressInfo.m
//  ZHSQ
//
//  Created by 赵中良 on 15/3/23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "AddressInfo.h"

@implementation AddressInfo

/*
 初始化并创建
 */
-(id)initWithAddress_id:(NSString *)Address_id City_id:(NSString *)City_id City_name:(NSString *)City_name Area_id:(NSString *)Area_id Area_name:(NSString *)Area_name Agency_id:(NSString *)Agency_id Agency_name:(NSString *)Agency_name Community_id:(NSString *)Community_id Community_name:(NSString *)Community_name Quarter_id:(NSString *)Quarter_id Quarter_name:(NSString *)Quarter_name Building_id:(NSString *)Building_id Building_name:(NSString *)Building_name Unit_id:(NSString *)Unit_id Unit_name:(NSString *)Unit_name Room_id:(NSString *)Room_id Room_name:(NSString *)Room_name Isdefaultshow:(NSString *)Isdefaultshow Charge_mode:(NSString *)Charge_mode
{
    if (self = [super init]) {
        _address_id = Address_id;
        _city_id = City_id;
        _city_name = City_name;
        _area_id = Area_id;
        _area_name = Area_name;
        _agency_id = Agency_id;
        _agency_name = Agency_name;
        _community_id = Community_id;
        _community_name = Community_name;
        _quarter_id = Quarter_id;
        _quarter_name = Quarter_name;
        _building_id = Building_id;
        _building_name = Building_name;
        _unit_id = Unit_id;
        _unit_name = Unit_name;
        _room_id = Room_id;
        _room_name = Room_name;
        _isdefaultshow = Isdefaultshow;
        _charge_mode = Charge_mode;
    }
    return self;
}

-(NSString *)description{
    NSString *str = [NSString stringWithFormat:@"地址信息：%@-%@-%@-%@-%@-%@-%@-%@",_city_name,_area_name,_agency_name,_community_name,_quarter_name,_building_name,_unit_name,_room_name];
    return str;
}

@end
