//
//  MyBill.h
//  ZHSQ
//
//  Created by 赵贺 on 15-3-13.
//  Copyright (c) 2015年 lacom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "WorkItem.h"

@interface MyBill : NSObject
@property (nonatomic, retain) NSString *ip;
@property (nonatomic, retain) NSString *order_id;
@property (nonatomic, retain) NSString *payment;
@property (nonatomic, retain) NSString *session;
@property (nonatomic, retain) NSString *proinfo;
@property (nonatomic, retain) NSString *property_id;
@property (nonatomic, retain) NSString *remark1;
@property (nonatomic, retain) NSString *remark2;

@end
