//
//  UserInfo.m
//  ZHSQ
//
//  Created by 赵中良 on 15/3/23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


-(id)initWithPersonArr:(NSArray *)PersonArr CarArr:(NSArray *)CarArr JdhArr:(NSArray *)JdhArr AddressArr:(NSArray *)AddressArr Session:(NSString *)Session{
    if (self = [super init]) {
        _personArr = PersonArr;
        NSLog(@"%@",PersonArr);
        _carArr = CarArr;
        _jdhArr = JdhArr;
        _addressArr = AddressArr;
        if (PersonArr.count > 0) {
            NSDictionary *userDic = PersonArr[0];
            _name = [NSString stringWithFormat:@"%@",userDic[@"name"]];
            _sex = [NSString stringWithFormat:@"%@",userDic[@"sex"]];
            _rank = [NSString stringWithFormat:@"%@",userDic[@"rank"]];
            _icon_path = [NSString stringWithFormat:@"%@",userDic[@"icon_path"]];
            _email = [NSString stringWithFormat:@"%@",userDic[@"email"]];
            _idnumber = [NSString stringWithFormat:@"%@",userDic[@"idnumber"]];
            _mobile_phone = [NSString stringWithFormat:@"%@",userDic[@"mobile_phone"]];
            _imei = [NSString stringWithFormat:@"%@",userDic[@"imei"]];
            _userId = [NSString stringWithFormat:@"%@",userDic[@"id"]];
            _nickName = [NSString stringWithFormat:@"%@",userDic[@"nickname"]];
        
        }
        _session = Session;
        
    }
    return self;
}

- (AddressInfo *)currentAddress{
    AddressInfo *address;
    if (_addressArr.count > 0) {
        for (NSDictionary *dic in _addressArr) {
            NSString *isdefaultshow = [NSString stringWithFormat:@"%@",dic[@"isdefaultshow"]];
            if ([isdefaultshow isEqualToString:@"1"]) {
                address = [[AddressInfo alloc]initWithAddress_id:dic[@"address_id"] City_id:dic[@"city_id"] City_name:dic[@"city_name"] Area_id:dic[@"area_id"] Area_name:dic[@"area_name"] Agency_id:dic[@"agency_id"] Agency_name:dic[@"agency_name"] Community_id:dic[@"community_id"] Community_name:dic[@"community_name"] Quarter_id:dic[@"quarter_id"] Quarter_name:dic[@"quarter_name"] Building_id:dic[@"building_id"] Building_name:dic[@"building_name"] Unit_id:dic[@"unit_id"] Unit_name:dic[@"unit_name"] Room_id:dic[@"room_id"] Room_name:dic[@"room_name"] Isdefaultshow:dic[@"isdefaultshow"] Charge_mode:dic[@"charge_mode"]];
                break;
            }
        }
    }
    return address;
}




@end
