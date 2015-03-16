//
//  zhujianliebiao.h
//  ZHSQ
//
//  Created by yanglaobao on 14-8-15.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "WorkItem.h"
@interface zhujianliebiao : NSObject
@property (nonatomic, retain) NSString *city_id;
@property (nonatomic, retain) NSString *longitude;
@property (nonatomic, retain) NSString *latitude;
@property (nonatomic, retain) NSString *servicetype_id;
@property (nonatomic, retain) NSString *distance_scope;
@property (nonatomic, retain) NSString *sort_id;
@end
