//
//  Car.h
//  ZHSQ
//
//  Created by 赵中良 on 15/3/23.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

/*
 汽车id
 */
@property (nonatomic,strong) NSString *carId;

/*
 号牌类别id
 */
@property (nonatomic,strong) NSString *Plate_Code;

/*
 号牌类别名称
 */
@property (nonatomic,strong) NSString *Plate_Name;

/*
 号牌号码
 */
@property (nonatomic,strong) NSString *Car_Code;

/*
 车辆识别代号
 */
@property (nonatomic,strong) NSString *dentification_code;

@end
