//
//  OpinionsFeedback.h
//  ZHSQ
//
//  Created by yanglaobao on 14-12-26.
//  Copyright (c) 2014年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "WorkItem.h"
@interface OpinionsFeedback : NSObject
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * device_id;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * qq;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * version;

@end
