//
//  tongzhi_shequ.h
//  ZHSQ
//
//  Created by lacom on 14-6-16.
//  Copyright (c) 2014年 lacom. All rights reserved.
//
//本类的对象为社区通知类的json串对象
#import <Foundation/Foundation.h>
#import "Location.h"
#import "WorkItem.h"

@interface tongzhi_shequ : NSObject
@property (nonatomic, retain) NSString * city_id;
@property (nonatomic, retain) NSString * community_id;
@property (nonatomic, retain) NSArray  * id_array;

@end
